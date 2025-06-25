%%%-------------------------------------------------------------------
%%% @author eldon
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 23. Jun 2025 2:30 PM
%%%-------------------------------------------------------------------
-module(lazy).
-author("eldon").

%% API
-export([]).



lazy_computer(State) ->
    receive {Sender, next} ->
      
        Sender ! State * 2,
        lazy_computer(State * 2)
    
    
    end.