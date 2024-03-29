%%
%% %CopyrightBegin%
%% 
%% Copyright Ericsson AB 1999-2012. All Rights Reserved.
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
{application, runtime_tools,
   [{description,  "RUNTIME_TOOLS"},
    {vsn,          "1.8.16"},
    {modules,      [appmon_info, dbg,observer_backend,percept_profile,
		    runtime_tools,runtime_tools_sup,erts_alloc_config,
		    ttb_autostart,dyntrace,system_information]},
    {registered,   [runtime_tools_sup]},
    {applications, [kernel, stdlib]},
    {env,          []},
    {mod,          {runtime_tools, []}},
    {runtime_dependencies, ["stdlib-2.0","mnesia-4.12","kernel-3.0",
			    "erts-6.0"]}]}.


