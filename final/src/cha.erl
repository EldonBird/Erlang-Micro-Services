%%%-------------------------------------------------------------------
%%% @author eldon
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. Jun 2025 12:59 PM
%%%-------------------------------------------------------------------
-module(cha).
-author("eldon").

%% API
-export([chain/2, outputer/1, squarer/1, rooter/1, adder/1]).

chain(Data, []) ->
  Data;
chain(Data, [Functions | Rest]) ->
  chain(Functions(Data), Rest).

squarer(Var) ->
  Var * Var.

rooter(Var) ->
  math:sqrt(Var).

adder(Var) ->
  Var + 5.

outputer(Num) ->
  chain(Num, [fun squarer/1, fun rooter/1, fun adder/1]).
