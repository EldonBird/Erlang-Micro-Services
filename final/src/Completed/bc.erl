%%%-------------------------------------------------------------------
%%% @author eldon
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. May 2025 12:14 PM
%%%-------------------------------------------------------------------
-module(bc).
-author("eldon").

%% API
-export([reverse/1]).


% This code takes an input list and reverses it
reverse([]) -> [];
reverse([Head|Tail]) -> reverse(Tail) ++ [Head].
