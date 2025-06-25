%%%-------------------------------------------------------------------
%%% @author Birdh
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 23. Jun 2025 12:04
%%%-------------------------------------------------------------------
-module(monads).
-author("Birdh").

%% API
-export([]).


unit(Value) ->
  {Value, []}.


bind ({Value, Log}, Fun) ->
  {NewVal, NewLog} = Fun (Value),
  {NewVal, Log ++ NewLog}.


add_num(Value) ->
  {Value + 5, ["Add5" ++ [Value]]}.