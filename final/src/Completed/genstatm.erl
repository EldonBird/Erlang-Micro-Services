%%%-------------------------------------------------------------------
%%% @author eldon
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Jun 2025 3:42 PM
%%%-------------------------------------------------------------------
-module(genstatm).
-author("eldon").
-behavior(gen_statem).

%% API
-export([callback_mode/0, init/1, idle/3, washing/3, rinsing/3, spinning/3]).

callback_mode() ->
  state_functions.

start_link() ->
  gen_statem:start_link({local, ?MODULE}, ?MODULE, [], []).

start(Pid) ->
  gen_statem:cast(Pid, start).

emergency_stop(Pid) ->
  gen_statem:cast(Pid, emergency_stop).

init([]) ->
  {ok, idle, undefined}.

idle(cast, start, Data) ->
  {next_state, washing, Data, {state_timeout, 2000, timeout}};
idle(cast, emergency_stop, Data) ->
  {keep_state, Data}.


washing(state_timeout, timeout, Data) ->
  {next_state, rinsing, Data, {state_timeout, 2000, timeout}};
washing(cast, emergency_stop, Data) ->
  {next_state, idle, Data}.

rinsing(state_timeout, timeout, Data) ->
  {next_state, spinning, Data, {state_timeout, 2000, timeout}};
rinsing(cast, emergency_stop, Data) ->
  {next_state, idle, Data}.


spinning(state_timeout, timeout, Data) ->
  {next_state, idle, Data, {state_timeout, 2000, timeout}};
spinning(cast, emergency_stop, Data) ->
  {next_state, idle, Data}.

