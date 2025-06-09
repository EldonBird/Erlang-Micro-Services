%%%-------------------------------------------------------------------
%%% @author eldon
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. Jun 2025 1:54 PM
%%%-------------------------------------------------------------------
-module(functors).
-author("eldon").


%% API
-export([map/2, test/0]).

% Define the binary tree structure using tagged tuples
% tree() = empty | {node, Value, LeftTree, RightTree}

% Map function: applies Fun to each node's Value
map(empty, _Fun) ->
  empty;
map({node, Value, Left, Right}, Fun) ->
  NewLeft = map(Left, Fun),
  NewRight = map(Right, Fun),
  {node, Fun(Value), NewLeft, NewRight}.

% Test function to demonstrate the map
test() ->
  % Create a sample binary tree
  Tree = {node, 1,
    {node, 2, empty, empty},
    {node, 3, empty, empty}},

  % Define a fun to double the node's value
  DoubleFun = fun(X) -> X * 2 end,

  % Apply map
  NewTree = map(Tree, DoubleFun),

  % Print original and new trees
  io:format("Original Tree: ~p~n", [Tree]),
  io:format("Mapped Tree: ~p~n", [NewTree]).
