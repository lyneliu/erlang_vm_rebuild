%%  coding: latin-1
%%------------------------------------------------------------
%%
%% Implementation stub file
%% 
%% Target: CosNotifyComm_StructuredPullSupplier
%% Source: /net/isildur/ldisk/daily_build/17_prebuild_opu_o.2015-03-31_14/otp_src_17/lib/cosNotification/src/CosNotifyComm.idl
%% IC vsn: 4.3.6
%% 
%% This file is automatically generated. DO NOT EDIT IT.
%%
%%------------------------------------------------------------

-module('CosNotifyComm_StructuredPullSupplier').
-ic_compiled("4_3_6").


%% Interface functions
-export([pull_structured_event/1, pull_structured_event/2, try_pull_structured_event/1]).
-export([try_pull_structured_event/2, disconnect_structured_pull_supplier/1, disconnect_structured_pull_supplier/2]).

%% Exports from "CosNotifyComm::NotifySubscribe"
-export([subscription_change/3, subscription_change/4]).

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



%%%% Operation: pull_structured_event
%% 
%%   Returns: RetVal
%%   Raises:  CosEventComm::Disconnected
%%
pull_structured_event(OE_THIS) ->
    corba:call(OE_THIS, pull_structured_event, [], ?MODULE).

pull_structured_event(OE_THIS, OE_Options) ->
    corba:call(OE_THIS, pull_structured_event, [], ?MODULE, OE_Options).

%%%% Operation: try_pull_structured_event
%% 
%%   Returns: RetVal, Has_event
%%   Raises:  CosEventComm::Disconnected
%%
try_pull_structured_event(OE_THIS) ->
    corba:call(OE_THIS, try_pull_structured_event, [], ?MODULE).

try_pull_structured_event(OE_THIS, OE_Options) ->
    corba:call(OE_THIS, try_pull_structured_event, [], ?MODULE, OE_Options).

%%%% Operation: disconnect_structured_pull_supplier
%% 
%%   Returns: RetVal
%%
disconnect_structured_pull_supplier(OE_THIS) ->
    corba:call(OE_THIS, disconnect_structured_pull_supplier, [], ?MODULE).

disconnect_structured_pull_supplier(OE_THIS, OE_Options) ->
    corba:call(OE_THIS, disconnect_structured_pull_supplier, [], ?MODULE, OE_Options).

%%%% Operation: subscription_change
%% 
%%   Returns: RetVal
%%   Raises:  CosNotifyComm::InvalidEventType
%%
subscription_change(OE_THIS, Added, Removed) ->
    corba:call(OE_THIS, subscription_change, [Added, Removed], ?MODULE).

subscription_change(OE_THIS, OE_Options, Added, Removed) ->
    corba:call(OE_THIS, subscription_change, [Added, Removed], ?MODULE, OE_Options).

%%------------------------------------------------------------
%%
%% Inherited Interfaces
%%
%%------------------------------------------------------------
oe_is_a("IDL:omg.org/CosNotifyComm/StructuredPullSupplier:1.0") -> true;
oe_is_a("IDL:omg.org/CosNotifyComm/NotifySubscribe:1.0") -> true;
oe_is_a(_) -> false.

%%------------------------------------------------------------
%%
%% Interface TypeCode
%%
%%------------------------------------------------------------
oe_tc(pull_structured_event) -> 
	{{tk_struct,"IDL:omg.org/CosNotification/StructuredEvent:1.0",
             "StructuredEvent",
             [{"header",
               {tk_struct,"IDL:omg.org/CosNotification/EventHeader:1.0",
                   "EventHeader",
                   [{"fixed_header",
                     {tk_struct,
                         "IDL:omg.org/CosNotification/FixedEventHeader:1.0",
                         "FixedEventHeader",
                         [{"event_type",
                           {tk_struct,
                               "IDL:omg.org/CosNotification/EventType:1.0",
                               "EventType",
                               [{"domain_name",{tk_string,0}},
                                {"type_name",{tk_string,0}}]}},
                          {"event_name",{tk_string,0}}]}},
                    {"variable_header",
                     {tk_sequence,
                         {tk_struct,
                             "IDL:omg.org/CosNotification/Property:1.0",
                             "Property",
                             [{"name",{tk_string,0}},{"value",tk_any}]},
                         0}}]}},
              {"filterable_data",
               {tk_sequence,
                   {tk_struct,"IDL:omg.org/CosNotification/Property:1.0",
                       "Property",
                       [{"name",{tk_string,0}},{"value",tk_any}]},
                   0}},
              {"remainder_of_body",tk_any}]},
         [],[]};
oe_tc(try_pull_structured_event) -> 
	{{tk_struct,"IDL:omg.org/CosNotification/StructuredEvent:1.0",
             "StructuredEvent",
             [{"header",
               {tk_struct,"IDL:omg.org/CosNotification/EventHeader:1.0",
                   "EventHeader",
                   [{"fixed_header",
                     {tk_struct,
                         "IDL:omg.org/CosNotification/FixedEventHeader:1.0",
                         "FixedEventHeader",
                         [{"event_type",
                           {tk_struct,
                               "IDL:omg.org/CosNotification/EventType:1.0",
                               "EventType",
                               [{"domain_name",{tk_string,0}},
                                {"type_name",{tk_string,0}}]}},
                          {"event_name",{tk_string,0}}]}},
                    {"variable_header",
                     {tk_sequence,
                         {tk_struct,
                             "IDL:omg.org/CosNotification/Property:1.0",
                             "Property",
                             [{"name",{tk_string,0}},{"value",tk_any}]},
                         0}}]}},
              {"filterable_data",
               {tk_sequence,
                   {tk_struct,"IDL:omg.org/CosNotification/Property:1.0",
                       "Property",
                       [{"name",{tk_string,0}},{"value",tk_any}]},
                   0}},
              {"remainder_of_body",tk_any}]},
         [],
         [tk_boolean]};
oe_tc(disconnect_structured_pull_supplier) -> 
	{tk_void,[],[]};
oe_tc(subscription_change) -> 'CosNotifyComm_NotifySubscribe':oe_tc(subscription_change);
oe_tc(_) -> undefined.

oe_get_interface() -> 
	[{"subscription_change", 'CosNotifyComm_NotifySubscribe':oe_tc(subscription_change)},
	{"disconnect_structured_pull_supplier", oe_tc(disconnect_structured_pull_supplier)},
	{"try_pull_structured_event", oe_tc(try_pull_structured_event)},
	{"pull_structured_event", oe_tc(pull_structured_event)}].




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
    "IDL:omg.org/CosNotifyComm/StructuredPullSupplier:1.0".


%%------------------------------------------------------------
%%
%% Object creation functions.
%%
%%------------------------------------------------------------

oe_create() ->
    corba:create(?MODULE, "IDL:omg.org/CosNotifyComm/StructuredPullSupplier:1.0").

oe_create_link() ->
    corba:create_link(?MODULE, "IDL:omg.org/CosNotifyComm/StructuredPullSupplier:1.0").

oe_create(Env) ->
    corba:create(?MODULE, "IDL:omg.org/CosNotifyComm/StructuredPullSupplier:1.0", Env).

oe_create_link(Env) ->
    corba:create_link(?MODULE, "IDL:omg.org/CosNotifyComm/StructuredPullSupplier:1.0", Env).

oe_create(Env, RegName) ->
    corba:create(?MODULE, "IDL:omg.org/CosNotifyComm/StructuredPullSupplier:1.0", Env, RegName).

oe_create_link(Env, RegName) ->
    corba:create_link(?MODULE, "IDL:omg.org/CosNotifyComm/StructuredPullSupplier:1.0", Env, RegName).

%%------------------------------------------------------------
%%
%% Init & terminate functions.
%%
%%------------------------------------------------------------

init(Env) ->
%% Call to implementation init
    corba:handle_init('CosNotifyComm_StructuredPullSupplier_impl', Env).

terminate(Reason, State) ->
    corba:handle_terminate('CosNotifyComm_StructuredPullSupplier_impl', Reason, State).


%%%% Operation: pull_structured_event
%% 
%%   Returns: RetVal
%%   Raises:  CosEventComm::Disconnected
%%
handle_call({_, OE_Context, pull_structured_event, []}, _, OE_State) ->
  corba:handle_call('CosNotifyComm_StructuredPullSupplier_impl', pull_structured_event, [], OE_State, OE_Context, false, false);

%%%% Operation: try_pull_structured_event
%% 
%%   Returns: RetVal, Has_event
%%   Raises:  CosEventComm::Disconnected
%%
handle_call({_, OE_Context, try_pull_structured_event, []}, _, OE_State) ->
  corba:handle_call('CosNotifyComm_StructuredPullSupplier_impl', try_pull_structured_event, [], OE_State, OE_Context, false, false);

%%%% Operation: disconnect_structured_pull_supplier
%% 
%%   Returns: RetVal
%%
handle_call({_, OE_Context, disconnect_structured_pull_supplier, []}, _, OE_State) ->
  corba:handle_call('CosNotifyComm_StructuredPullSupplier_impl', disconnect_structured_pull_supplier, [], OE_State, OE_Context, false, false);

%%%% Operation: subscription_change
%% 
%%   Returns: RetVal
%%   Raises:  CosNotifyComm::InvalidEventType
%%
handle_call({_, OE_Context, subscription_change, [Added, Removed]}, _, OE_State) ->
  corba:handle_call('CosNotifyComm_StructuredPullSupplier_impl', subscription_change, [Added, Removed], OE_State, OE_Context, false, false);



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
    corba:handle_code_change('CosNotifyComm_StructuredPullSupplier_impl', OldVsn, State, Extra).

