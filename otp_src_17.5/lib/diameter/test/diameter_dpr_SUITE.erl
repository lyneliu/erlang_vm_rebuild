%%
%% %CopyrightBegin%
%%
%% Copyright Ericsson AB 2012-2015. All Rights Reserved.
%%
%% The contents of this file are subject to the Erlang Public License,
%% Version 1.1, (the "License"); you may not use this file except in
%% compliance with the License. You should have received a copy of the
%% Erlang Public License along with this software. If not, it can be
%% retrieved online at http://www.erlang.org/.
%%
%% Software distributed under the License is distributed on an "AS IS"
%% basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
%% the License for the specific language governing rights and limitations
%% under the License.
%%
%% %CopyrightEnd%
%%

%%
%% Tests of the disconnect_cb configuration.
%%

-module(diameter_dpr_SUITE).

-export([suite/0,
         all/0,
         groups/0,
         init_per_group/2,
         end_per_group/2]).

%% testcases
-export([start/1,
         connect/1,
         send_dpr/1,
         remove_transport/1,
         stop_service/1,
         check/1,
         stop/1]).

%% disconnect_cb
-export([disconnect/5]).

-include("diameter.hrl").
-include("diameter_gen_base_rfc6733.hrl").

%% ===========================================================================

-define(util, diameter_util).

-define(ADDR, {127,0,0,1}).

-define(CLIENT, "CLIENT").
-define(SERVER, "SERVER").

%% Config for diameter:start_service/2.
-define(SERVICE(Host),
        [{'Origin-Host', Host},
         {'Origin-Realm', "erlang.org"},
         {'Host-IP-Address', [?ADDR]},
         {'Vendor-Id', hd(Host)},  %% match this in disconnect/5
         {'Product-Name', "OTP/diameter"},
         {'Acct-Application-Id', [0]},
         {restrict_connections, false},
         {application, [{dictionary, diameter_gen_base_rfc6733},
                        {alias, common},
                        {module, #diameter_callback{_ = false}}]}]).

%% Disconnect reasons that diameter passes as the first argument of a
%% function configured as disconnect_cb.
-define(REASONS, [transport, service, application]).

%% Valid values for Disconnect-Cause.
-define(CAUSES, [0, rebooting, 1, busy, 2, goaway]).

%% Establish one client connection for each element of this list,
%% configured with disconnect/5, disconnect_cb returning the specified
%% value.
-define(RETURNS,
        [[close, {dpr, [{cause, invalid}]}],
         [ignore, close],
         []]
        ++ [[{dpr, [{timeout, 5000}, {cause, T}]}] || T <- ?CAUSES]).

%% ===========================================================================

suite() ->
    [{timetrap, {seconds, 60}}].

all() ->
    [start, send_dpr, stop | [{group, R} || R <- ?REASONS]].

%% The group determines how transports are terminated: by remove_transport,
%% stop_service or application stop.
groups() ->
    Ts = tc(),
    [{R, [], Ts} || R <- ?REASONS].

init_per_group(Name, Config) ->
    [{group, Name} | Config].

end_per_group(_, _) ->
    ok.

tc() ->
    [start, connect, remove_transport, stop_service, check, stop].

%% ===========================================================================
%% start/stop testcases

start(_Config) ->
    ok = diameter:start(),
    ok = diameter:start_service(?SERVER, ?SERVICE(?SERVER)),
    ok = diameter:start_service(?CLIENT, ?SERVICE(?CLIENT)).

send_dpr(_Config) ->
    LRef = ?util:listen(?SERVER, tcp),
    Ref = ?util:connect(?CLIENT, tcp, LRef, [{dpa_timeout, 10000}]),
    #diameter_base_DPA{'Result-Code' = 2001}
        = diameter:call(?CLIENT,
                        common,
                        ['DPR', {'Origin-Host', "CLIENT.erlang.org"},
                                {'Origin-Realm', "erlang.org"},
                                {'Disconnect-Cause', 0}]),
    ok =  receive  %% endure the transport dies on DPA
              #diameter_event{service = ?CLIENT, info = {down, Ref, _, _}} ->
                  ok
          after 5000 ->
                  erlang:process_info(self(), messages)
          end.

connect(Config) ->
    Pid = spawn(fun init/0),  %% process for disconnect_cb to bang
    Grp = group(Config),
    LRef = ?util:listen(?SERVER, tcp),
    Refs = [?util:connect(?CLIENT, tcp, LRef, opts(RCs, {Grp, Pid}))
            || RCs <- ?RETURNS],
    ?util:write_priv(Config, config, [Pid | Refs]).

%% Remove all the client transports only in the transport group.
remove_transport(Config) ->
    transport == group(Config)
        andalso (ok = diameter:remove_transport(?CLIENT, true)).

%% Stop the service only in the service group.
stop_service(Config) ->
    service == group(Config)
        andalso (ok = diameter:stop_service(?CLIENT)).

%% Check for callbacks before diameter:stop/0, not the other way around
%% for the timing reason explained below.
check(Config) ->
    Grp = group(Config),
    [Pid | Refs] = ?util:read_priv(Config, config),
    Pid ! self(),                      %% ask for dictionary
    Dict = receive {Pid, D} -> D end,  %% get it
    check(Refs, ?RETURNS, Grp, Dict).  %% check for callbacks

stop(_Config) ->
    ok = diameter:stop().

%% Whether or not there are callbacks after diameter:stop() depends on
%% timing as long as the server runs on the same node: a server
%% transport could close the connection before the client has chance
%% to apply its callback. Therefore, just check that there haven't
%% been any callbacks yet.
check(_, _, application, Dict) ->
    [] = dict:to_list(Dict);

check([], [], _, _) ->
    ok;

check([Ref | Refs], CBs, Grp, Dict) ->
    check1(Ref, hd(CBs), Grp, Dict),
    check(Refs, tl(CBs), Grp, Dict).

check1(Ref, [ignore | RCs], Reason, Dict) ->
    check1(Ref, RCs, Reason, Dict);

check1(Ref, [_|_], Reason, Dict) ->
    {ok, Reason} = dict:find(Ref, Dict);  %% callback with expected reason

check1(Ref, [], _, Dict) ->
    error = dict:find(Ref, Dict).  %% no callback

%% ----------------------------------------

group(Config) ->
    {group, Grp} = lists:keyfind(group, 1, Config),
    Grp.

%% Configure the callback with the group name (= disconnect reason) as
%% extra argument.
opts(RCs, T) ->
    [{disconnect_cb, {?MODULE, disconnect, [T, RC]}} || RC <- RCs].

%% Match the group name with the disconnect reason to ensure the
%% callback is being called as expected.
disconnect(Reason, Ref, Peer, {Reason, Pid}, RC) ->
    io:format("disconnect: ~p ~p~n", [Ref, Reason]),
    {_, #diameter_caps{vendor_id = {$C,$S}}} = Peer,
    Pid ! {Reason, Ref},
    RC.

init() ->
    exit(recv(dict:new())).

recv(Dict) ->
    receive
        Pid when is_pid(Pid) ->
            Pid ! {self(), Dict};
        {Reason, Ref} ->
            recv(dict:store(Ref, Reason, Dict))
    end.
