%%%-------------------------------------------------------------------
%%% @author eldon
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. May 2025 1:49 PM
%%%-------------------------------------------------------------------
-module(sp).
-author("eldon").

%% API
-export([start_vending_server/0, vending_machine/1, client/0, start_clinet/0]).

%% {Command, Task_name}
%%  ADD = 0, REMOVE = 1, View = 10


start_vending_server() ->
  Pid = spawn(?MODULE, vending_machine, [[]]),
  Pid.

start_clinet() ->

  Pid = spawn(?MODULE, client),
  Pid.

client() ->
  receive {Change} ->

    io:format("Vending ~p~n", Change)
    
  end.


print_out(In) ->
  io:format("~p~n", [In]).


vending_machine(State)->
  
  receive {Money, _} when Money < 10 ->

    io:format("Not Enough Money");
    
    {Money, Drink} ->

      print_out(10 - Money),
      Current = State ++ [{10 - Money, Drink}],
      vending_machine(Current)

  end.