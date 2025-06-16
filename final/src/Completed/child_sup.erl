%%%-------------------------------------------------------------------
%%% @author eldon
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Jun 2025 2:54 PM
%%%-------------------------------------------------------------------
-module(child_sup).
-author("eldon").

%% API
-export([start_link/0]).
-behavior(supervisor).

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

start_worker() ->
  supervisor:start_child(?MODULE, []).

init([]) ->
  {ok, {
    {one_for_one, 1, 60},
    [
      {child_worker, {child_worker, start_link, []},
        permanent, 5000, worker, [child_worker]}

    ]
  }}.