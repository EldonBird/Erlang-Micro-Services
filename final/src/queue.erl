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

head({[], []}) ->
  null;
head({[], Rear}) ->
  [H | _] = lists:reverse(Rear),
  H;
head({[H | _], _}) ->
  H.

tail({[], []}) ->
  null;
tail({[], [H | _]}) ->
  H.


toList({Front, Rear}) ->
  Front ++ lists:reverse(Rear).


fromList(List) ->
  {List, []}.