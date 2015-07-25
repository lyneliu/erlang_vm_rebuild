%%
%% %CopyrightBegin%
%% 
%% Copyright Ericsson AB 1998-2009. All Rights Reserved.
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
-module(bad_record_use2).
-export([test/0]).

-record(bad_use, {a=undefined,
		  b=undefined,
		  c=undefined}).

test() ->
    R=#bad_use{a=1, b=2},
    R2=R#bad_use{a=1, b=2, a=2},
    ok.
