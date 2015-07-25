%%
%% %CopyrightBegin%
%%
%% Copyright Ericsson AB 1997-2010. All Rights Reserved.
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
-module(cleanup).

-export([all/0,groups/0,init_per_group/2,end_per_group/2, cleanup/1]).

-include_lib("test_server/include/test_server.hrl").

all() -> 
    [cleanup].

groups() -> 
    [].

init_per_group(_GroupName, Config) ->
    Config.

end_per_group(_GroupName, Config) ->
    Config.


cleanup(suite) -> [];
cleanup(_) ->
    ?line Localhost = list_to_atom(net_adm:localhost()),
    ?line net_adm:world_list([Localhost]),
    ?line case nodes() of
	      [] ->
		  ok;
	      Nodes when is_list(Nodes) ->
		  Kill = fun(Node) -> spawn(Node, erlang, halt, []) end,
		  ?line lists:foreach(Kill, Nodes),
		  ?line test_server:fail({nodes_left, Nodes})
	  end.
