%%%-------------------------------------------------------------------
%%% @author eldon
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Jun 2025 12:41 PM
%%%-------------------------------------------------------------------
-module(otp_sup).
-author("eldon").
-behavior(supervisor).

%% API
-export([start_link/0]).

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

start_worker() ->
  supervisor:start_child(?MODULE, []).

init([]) ->
  {ok, {
    {one_for_all, 1, 60},
    [
      {child_sup, {child_sup, start_link, []},
        permanent, 5000, supervisor, [child_sup]},
      
      {child_sup, {child_sup, start_link, []},
      permanent, 5000, supervisor, [child_sup]}
    ]
  }}.


