%%%-------------------------------------------------------------------
%%% @author eldon
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. May 2025 2:07 PM
%%%-------------------------------------------------------------------
-module(functions).
-export([factorial/1]).


factorial(Comp) when Comp == 1 -> Comp;
factorial(Comp) -> Comp * factorial(Comp - 1).


%% API
