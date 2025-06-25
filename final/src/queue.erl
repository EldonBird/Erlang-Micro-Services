%%%-------------------------------------------------------------------
%%% @author Birdh
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. Jun 2025 11:47
%%%-------------------------------------------------------------------
-module(queue).
-author("Birdh").

%% API
-export([]).


empty({[], []}) ->
    true;
empty(_) ->
    false.


enqueue({Front, Rear}, New) ->
  {Front, [New | Rear]}.


dequeue({[], []}) ->
  {[], []};
dequeue({[], Rear}) ->
  dequeue({lists:reverse(Rear), []});
dequeue({[_H | T], Rear}) ->
  {T, Rear}.


head({[], []}) -> nil;
head({[], Rear}) ->
  case lists:reverse(Rear) of
    [] -> nil;
    [H | _] -> H
  end;
head({[H | _], _}) -> H.


tail({[], []}) -> nil;
tail({[], Rear}) ->
  case Rear of
    [] -> nil;
    [H | _] -> H
  end;
tail({Front, []}) ->
  case lists:reverse(Front) of
    [] -> nil;
    [H | _] -> H
  end;
tail({_, [H | _]}) -> H.


toList({Front, Rear}) ->
  Front ++ lists:reverse(Rear).


fromList(List) ->
  {List, []}.