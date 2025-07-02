%%%-------------------------------------------------------------------
%%% @author eldon
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. Jun 2025 2:03 PM
%%%-------------------------------------------------------------------
-module(facpat).
-author("eldon").

%% API
-export([randint/2]).


randint(Max, Min) ->
  Var = rand:uniform(Max),
  if (Var < Min) ->
    randint(Max, Min);
  true ->
    Var
  end.