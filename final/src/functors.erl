%%%-------------------------------------------------------------------
%%% @author eldon
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. Jun 2025 2:10 PM
%%%-------------------------------------------------------------------
-module(functors).
-author("eldon").

%% API
-export([better_work/3]).

better_work(Fun, ok, Value) ->
  {ok, Fun(Value)};
better_work(_, error, Reason) ->
  {error, Reason}.



