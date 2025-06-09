%%%-------------------------------------------------------------------
%%% @author eldon
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 19. May 2025 1:20 PM
%%%-------------------------------------------------------------------
-module(statproc).
-author("eldon").

  
%% API
-export([start/0, proc/0, start_output/0, output/0]).



start() ->
  Pid = spawn(?MODULE, proc, []),
  Pid.

start_output() ->
  Pid = spawn(?MODULE, output, []),
  Pid.
  
print_out(In) ->
  io:format("~p~n", [In]).

proc() ->
  receive
    {Sender, Msg} ->
      F = (Msg * (9/5)) + 32,
      Sender ! {F},
      print_out(F),
      proc()
  end.

output() ->
  receive 
    {Msg} ->
      print_out(Msg),
      output()
  end.

