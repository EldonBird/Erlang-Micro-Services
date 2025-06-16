%%%-------------------------------------------------------------------
%%% @author eldon
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Jun 2025 3:13 PM
%%%-------------------------------------------------------------------
-module(genm).
-author("eldon").
-behavior(gen_statem).

%% API

%% API
-export([start_link/0, check_in/1, check_out/1, start_cleaning/1, finish_cleaning/1]).

%% gen_statem callbacks
-export([init/1, callback_mode/0, terminate/3, code_change/4]).
-export([vacant/3, occupied/3, cleaning/3]).

-module(washer_statem).
-behaviour(gen_statem).

%% API
-export([start_link/0, start/1, emergency_stop/1]).

%% Callbacks
-export([init/1, callback_mode/0, terminate/3, code_change/4]).
-export([idle/3, washing/3, rinsing/3, spinning/3]).

-define(WASH_TIME, 3000).
-define(RINSE_TIME, 2000).
-define(SPIN_TIME, 1000).

%%%===================
%%% API
%%%===================
start_link() ->
  gen_statem:start_link({local, ?MODULE}, ?MODULE, [], []).

start(Pid) ->
  gen_statem:cast(Pid, start).

emergency_stop(Pid) ->
  gen_statem:cast(Pid, emergency_stop).

%%%===================
%%% gen_statem Callbacks
%%%===================
init([]) ->
  io:format("Washer ready in 'idle' state~n"),
  {ok, idle, #{}}.

callback_mode() ->
  state_functions.

terminate(_Reason, _State, _Data) ->
  io:format("Washer terminated~n"),
  ok.

code_change(_OldVsn, State, Data, _Extra) ->
  {ok, State, Data}.

%%%===================
%%% State Definitions
%%%===================

idle(cast, start, Data) ->
  io:format("Starting wash cycle...~n"),
  {next_state, washing, Data, {state_timeout, ?WASH_TIME, timeout}};

idle(cast, emergency_stop, Data) ->
  io:format("Already idle. Nothing to stop.~n"),
  {keep_state, Data};

idle(_Type, _Event, Data) ->
  {keep_state, Data}.

washing(state_timeout, timeout, Data) ->
  io:format("Washing done. Starting rinse.~n"),
  {next_state, rinsing, Data, {state_timeout, ?RINSE_TIME, timeout}};

washing(cast, emergency_stop, Data) ->
  io:format("Emergency stop during washing! Returning to idle.~n"),
  {next_state, idle, Data};

washing(_Type, _Event, Data) ->
  {keep_state, Data}.

rinsing(state_timeout, timeout, Data) ->
  io:format("Rinsing done. Starting spin.~n"),
  {next_state, spinning, Data, {state_timeout, ?SPIN_TIME, timeout}};

rinsing(cast, emergency_stop, Data) ->
  io:format("Emergency stop during rinsing! Returning to idle.~n"),
  {next_state, idle, Data};

rinsing(_Type, _Event, Data) ->
  {keep_state, Data}.

spinning(state_timeout, timeout, Data) ->
  io:format("Spin complete. Cycle finished. Returning to idle.~n"),
  {next_state, idle, Data};

spinning(cast, emergency_stop, Data) ->
  io:format("Emergency stop during spinning! Returning to idle.~n"),
  {next_state, idle, Data};

spinning(_Type, _Event, Data) ->
  {keep_state, Data}.
