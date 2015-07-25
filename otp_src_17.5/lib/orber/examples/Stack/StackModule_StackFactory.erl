%%  coding: latin-1
%%------------------------------------------------------------
%%
%% Implementation stub file
%% 
%% Target: StackModule_StackFactory
%% Source: /net/isildur/ldisk/daily_build/17_prebuild_opu_o.2015-03-31_14/otp_src_17/lib/orber/examples/Stack/stack.idl
%% IC vsn: 4.3.6
%% 
%% This file is automatically generated. DO NOT EDIT IT.
%%
%%------------------------------------------------------------

-module('StackModule_StackFactory').
-ic_compiled("4_3_6").


%% Interface functions
-export([create_stack/1, create_stack/2, destroy_stack/2]).
-export([destroy_stack/3]).

%% Type identification function
-export([typeID/0]).

%% Used to start server
-export([oe_create/0, oe_create_link/0, oe_create/1]).
-export([oe_create_link/1, oe_create/2, oe_create_link/2]).

%% TypeCode Functions and inheritance
-export([oe_tc/1, oe_is_a/1, oe_get_interface/0]).

%% gen server export stuff
-behaviour(gen_server).
-export([init/1, terminate/2, handle_call/3]).
-export([handle_cast/2, handle_info/2, code_change/3]).

-include_lib("orber/include/corba.hrl").


%%------------------------------------------------------------
%%
%% Object interface functions.
%%
%%------------------------------------------------------------



%%%% Operation: create_stack
%% 
%%   Returns: RetVal
%%
create_stack(OE_THIS) ->
    corba:call(OE_THIS, create_stack, [], ?MODULE).

create_stack(OE_THIS, OE_Options) ->
    corba:call(OE_THIS, create_stack, [], ?MODULE, OE_Options).

%%%% Operation: destroy_stack
%% 
%%   Returns: RetVal
%%
destroy_stack(OE_THIS, S) ->
    corba:call(OE_THIS, destroy_stack, [S], ?MODULE).

destroy_stack(OE_THIS, OE_Options, S) ->
    corba:call(OE_THIS, destroy_stack, [S], ?MODULE, OE_Options).

%%------------------------------------------------------------
%%
%% Inherited Interfaces
%%
%%------------------------------------------------------------
oe_is_a("IDL:StackModule/StackFactory:1.0") -> true;
oe_is_a(_) -> false.

%%------------------------------------------------------------
%%
%% Interface TypeCode
%%
%%------------------------------------------------------------
oe_tc(create_stack) -> 
	{{tk_objref,"IDL:StackModule/Stack:1.0","Stack"},[],[]};
oe_tc(destroy_stack) -> 
	{tk_void,[{tk_objref,"IDL:StackModule/Stack:1.0","Stack"}],[]};
oe_tc(_) -> undefined.

oe_get_interface() -> 
	[{"destroy_stack", oe_tc(destroy_stack)},
	{"create_stack", oe_tc(create_stack)}].




%%------------------------------------------------------------
%%
%% Object server implementation.
%%
%%------------------------------------------------------------


%%------------------------------------------------------------
%%
%% Function for fetching the interface type ID.
%%
%%------------------------------------------------------------

typeID() ->
    "IDL:StackModule/StackFactory:1.0".


%%------------------------------------------------------------
%%
%% Object creation functions.
%%
%%------------------------------------------------------------

oe_create() ->
    corba:create(?MODULE, "IDL:StackModule/StackFactory:1.0").

oe_create_link() ->
    corba:create_link(?MODULE, "IDL:StackModule/StackFactory:1.0").

oe_create(Env) ->
    corba:create(?MODULE, "IDL:StackModule/StackFactory:1.0", Env).

oe_create_link(Env) ->
    corba:create_link(?MODULE, "IDL:StackModule/StackFactory:1.0", Env).

oe_create(Env, RegName) ->
    corba:create(?MODULE, "IDL:StackModule/StackFactory:1.0", Env, RegName).

oe_create_link(Env, RegName) ->
    corba:create_link(?MODULE, "IDL:StackModule/StackFactory:1.0", Env, RegName).

%%------------------------------------------------------------
%%
%% Init & terminate functions.
%%
%%------------------------------------------------------------

init(Env) ->
%% Call to implementation init
    corba:handle_init('StackModule_StackFactory_impl', Env).

terminate(Reason, State) ->
    corba:handle_terminate('StackModule_StackFactory_impl', Reason, State).


%%%% Operation: create_stack
%% 
%%   Returns: RetVal
%%
handle_call({_, OE_Context, create_stack, []}, _, OE_State) ->
  corba:handle_call('StackModule_StackFactory_impl', create_stack, [], OE_State, OE_Context, false, false);

%%%% Operation: destroy_stack
%% 
%%   Returns: RetVal
%%
handle_call({_, OE_Context, destroy_stack, [S]}, _, OE_State) ->
  corba:handle_call('StackModule_StackFactory_impl', destroy_stack, [S], OE_State, OE_Context, false, false);



%%%% Standard gen_server call handle
%%
handle_call(stop, _, State) ->
    {stop, normal, ok, State};

handle_call(_, _, State) ->
    {reply, catch corba:raise(#'BAD_OPERATION'{minor=1163001857, completion_status='COMPLETED_NO'}), State}.


%%%% Standard gen_server cast handle
%%
handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_, State) ->
    {noreply, State}.


%%%% Standard gen_server handles
%%
handle_info(_, State) ->
    {noreply, State}.


code_change(OldVsn, State, Extra) ->
    corba:handle_code_change('StackModule_StackFactory_impl', OldVsn, State, Extra).

