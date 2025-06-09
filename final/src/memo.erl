%%%-------------------------------------------------------------------
%%% @author eldon
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. Jun 2025 12:06 PM
%%%-------------------------------------------------------------------
-module(memo).
-author("eldon").

%% API
-export([]).



start_memo() ->
  spawn(fun() -> memos(#{}) end).


% {ad, views}
memos(Cache)->
  receive
    {Sender, Ad} ->
      case maps:get(Ad, Cache, not_found) of
        not_found -> 
          Best = lists:max(Cache),
          Sender ! {Best},
          NewCache = maps:put(Ad, Best, Cache),
          memos(NewCache);
        Cached ->
          Sender ! {Cached},
          memos(Cache)
  end;
    stop ->
      ok
  end.





  