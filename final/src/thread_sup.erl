%%%-------------------------------------------------------------------
%%% @author Birdh
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Jun 2025 21:41
%%%-------------------------------------------------------------------
-module(thread_sup).
-author("Birdh").

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).


%% @doc Starts the supervisor

start_link() ->
  supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init([]) ->
  {ok, {
    {one_for_one, 1, 60},
    [
      {thread_gen, 
        {thread_gen, start_link, []},
        permanent, 
        5000, 
        worker, 
        [thread_gen]}

    ]
  }}.