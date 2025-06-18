%%%-------------------------------------------------------------------
%%% @author Birdh
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Jun 2025 21:28
%%%-------------------------------------------------------------------
-module(thread_gen).
-author("Birdh").

-behaviour(gen_server).

%% API
-export([start_link/0]).

%% gen_server callbacks


post_comment(Comment, Thread_id)->
  gen_server:cast(?MODULE, {posting_comment, Comment, Thread_id}).

new_thread(Thread) ->
  gen_server:cast(?MODULE, {creating_thread, Thread}).

update_rank(Vote, Thread_id) ->
  gen_server:cast(?MODULE, {updoot, Vote, Thread_id}).

get_thread(Thread_id) ->
  gen_server:call(?MODULE, {getting_thread, Thread_id}).

get_all_threads() ->
  gen_server:call(?MODULE, getting_all_threads).

-define(SERVER, ?MODULE).
-record().

-spec(start_link() ->
  {ok, Pid :: pid()} | ignore | {error, Reason :: term()}).
start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

% Thread = {Thread_id, Categories[], User_id, ranking, Comments[]}
% Comment = {Comment_id, User_id, time, Comment}

init([]) ->
  {ok, []}.

% Generalized functions for the gen server

add_comment_by_thread_id(_,_, []) ->
  dne;
add_comment_by_thread_id(Comment, Thread_id, [{Current_Thread_id, Categories, User_id, Ranking, Comments} | Rest]) when Current_Thread_id == Thread_id ->
  New_comments = Comments ++ [Comment],
  Update_thread = {Current_Thread_id, Categories, User_id, Ranking, New_comments},
  [Update_thread | Rest];
add_comment_by_thread_id(Comment, Thread_id, [Head | Tail]) ->
  [Head | add_comment_by_thread_id(Comment, Thread_id, Tail)].
  
update_thread_by_id(_, _, []) ->
  dne;
update_thread_by_id(Vote, Thread_id, [{Current_Thread_id, Categories, User_id, Ranking, Comments} | Rest]) when Current_Thread_id == Thread_id ->
  New_rank = Ranking + Vote,
  New_Thread = {Current_Thread_id, Categories, User_id, New_rank, Comments},
  [New_Thread | Rest];
update_thread_by_id(Vote, Thread_id, [Head | Tail]) ->
  [Head | update_thread_by_id(Vote, Thread_id, Tail)].



find_thread(_, []) ->
  dne;
find_thread(Thread_id, [Thread = {Curr_thread_id, _, _, _, _} | _]) when Curr_thread_id == Thread_id ->
  Thread;
find_thread(Thread_id, [_ | Tail]) ->
  find_thread(Thread_id, Tail).


sort_thread_by_rating([Head | Tail], Sorting_State) ->
  

  .
  
  
putting_in_state_by_rank([], Thread) ->
  [Thread];
putting_in_state_by_rank([Head | Tail], Thread) ->
  case Thread of
    {_, _, _, Current_rank, _} = Thread

  
% casting and calling junk

  
  
handle_cast({posting_comment, Comment, Thread_id}, State) ->
  {Com_id, User_id, Time, Comment_data} = Comment,
  ID = uuid:uuid_to_string(uuid:get_v4()),
  New_Comment = {ID, User_id, Time, Comment_data},
  New_state = add_comment_by_thread_id(New_Comment, Thread_id, State),
  case New_state of
    dne ->
      {noreply, State};
    _ ->
      {noreply, New_state}
  end;
handle_cast({creating_thread, Thread}, State) ->
  ID = uuid:uuid_to_string(uuid:get_v4()),
  {_, Categories, User_id, Ranking, Comments} = Thread,
  New_Thread = {ID, Categories, User_id, Ranking, Comments},
  Result = [State | New_Thread],
  {noreply, Result};
handle_cast({updoot, Vote, Thread_id}, State) ->
  New_state = update_thread_by_id(Vote, Thread_id, State),
  case New_state of
    dne ->
      {noreply, State};
    _ ->
      {noreply, New_state}
  end.


handle_call({getting_thread, Thread_id}, State) ->
  Thread = find_thread(Thread_id, State),
  {reply, Thread, State};
handle_call({getting_all_threads}, State) ->
  State,
  {reply, State, State}.

terminate(_Reason, _State) ->
  ok.