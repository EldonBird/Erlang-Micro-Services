%%%-------------------------------------------------------------------
%%% @author Birdh
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Jun 2025 23:05
%%%-------------------------------------------------------------------
-module(thread_gen_tests).
-include_lib("eunit/include/eunit.hrl").

%%% Test Data Setup and Teardown
setup_() ->
  meck:new(undefined, [non_strict]),  % Placeholder for future mocks if needed
  {ok, #{}}.

teardown_(_) ->
  meck:unload_all().

%%% Happy Path: Thread ID is found and comment is appended
add_comment_happy_test_() ->
  {
    setup,
    fun setup_/0,
    fun teardown_/1,
    fun() ->
      Comment = "New comment",
      ThreadID = 1,
      Threads = [
        {1, [cat1], user1, 5, ["old comment"]},
        {2, [cat2], user2, 3, ["another"]}
      ],
      Expected = [
        {1, [cat1], user1, 5, ["old comment", "New comment"]},
        {2, [cat2], user2, 3, ["another"]}
      ],
      [
        ?_assertEqual(Expected, add_comment_by_thread_id(Comment, ThreadID, Threads))
      ]
    end
  }.

%%% Edge Case: Empty thread list
add_comment_empty_list_test_() ->
  {
    setup,
    fun setup_/0,
    fun teardown_/1,
    fun() ->
      [
        ?_assertEqual("DNE", add_comment_by_thread_id("Test", 123, []))
      ]
    end
  }.

%%% Edge Case: Thread ID not found
add_comment_no_match_test_() ->
  {
    setup,
    fun setup_/0,
    fun teardown_/1,
    fun() ->
      Threads = [
        {1, [], user1, 1, []},
        {2, [], user2, 2, []}
      ],
      [
        ?_assertEqual("DNE", add_comment_by_thread_id("Hello", 999, Threads))
      ]
    end
  }.

%%% Edge Case: Multiple matching structure types but incorrect thread_id
add_comment_similar_structs_test_() ->
  {
    setup,
    fun setup_/0,
    fun teardown_/1,
    fun() ->
      Threads = [
        {3, [cat], u1, 10, ["c1"]},
        {4, [cat], u2, 20, ["c2"]}
      ],
      [
        ?_assertEqual("DNE", add_comment_by_thread_id("irrelevant", 5, Threads))
      ]
    end
  }.

update_thread_test() -> ok.

%%% Happy Path: Vote applied to matching thread
update_thread_happy_test_() ->
  {
    setup,
    fun setup_/0,
    fun teardown_/1,
    fun() ->
      Vote = 3,
      ThreadID = 10,
      Threads = [
        {10, [cat], user1, 5, ["comment"]},
        {20, [cat2], user2, 8, ["other"]}
      ],
      Expected = [
        {10, [cat], user1, 8, ["comment"]},
        {20, [cat2], user2, 8, ["other"]}
      ],
      [
        ?_assertEqual(Expected, update_thread_by_id(Vote, ThreadID, Threads))
      ]
    end
  }.

%%% Edge Case: Thread list is empty
update_thread_empty_list_test_() ->
  {
    setup,
    fun setup_/0,
    fun teardown_/1,
    fun() ->
      [
        ?_assertEqual(dne, update_thread_by_id(2, 1, []))
      ]
    end
  }.

%%% Edge Case: No matching thread ID
update_thread_no_match_test_() ->
  {
    setup,
    fun setup_/0,
    fun teardown_/1,
    fun() ->
      Threads = [
        {3, [], u1, 0, []},
        {4, [], u2, 1, []}
      ],
      [
        ?_assertEqual(dne, update_thread_by_id(1, 5, Threads))
      ]
    end
  }.

%%% Edge Case: Negative vote
update_thread_negative_vote_test_() ->
  {
    setup,
    fun setup_/0,
    fun teardown_/1,
    fun() ->
      Vote = -2,
      ThreadID = 3,
      Threads = [
        {3, [], u1, 10, []}
      ],
      Expected = [
        {3, [], u1, 8, []}
      ],
      [
        ?_assertEqual(Expected, update_thread_by_id(Vote, ThreadID, Threads))
      ]
    end
  }.


%%% Happy Path: Matching thread ID found
find_thread_happy_test_() ->
  {
    setup,
    fun setup_/0,
    fun teardown_/1,
    fun() ->
      ThreadID = 2,
      Threads = [
        {1, [cat1], u1, 5, []},
        {2, [cat2], u2, 3, ["hello"]},
        {3, [cat3], u3, 0, []}
      ],
      Expected = {2, [cat2], u2, 3, ["hello"]},
      [
        ?_assertEqual(Expected, find_thread(ThreadID, Threads))
      ]
    end
  }.

%%% Edge Case: Empty thread list
find_thread_empty_test_() ->
  {
    setup,
    fun setup_/0,
    fun teardown_/1,
    fun() ->
      [
        ?_assertEqual(dne, find_thread(5, []))
      ]
    end
  }.

%%% Edge Case: No matching thread ID
find_thread_no_match_test_() ->
  {
    setup,
    fun setup_/0,
    fun teardown_/1,
    fun() ->
      Threads = [
        {1, [], u1, 1, []},
        {4, [], u2, 2, []}
      ],
      [
        ?_assertEqual(dne, find_thread(99, Threads))
      ]
    end
  }.

