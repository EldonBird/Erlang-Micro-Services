%%%-------------------------------------------------------------------
%%% @author eldon
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Jun 2025 12:41 PM
%%%-------------------------------------------------------------------
-module(otp_gen).
-author("eldon").
-behavior(gen_server).

%% API
-export([]).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

add_item(Item)->
  gen_server:cast(?MODULE, {add_item, Item}).

get_dq() ->
  gen_server:call(?MODULE, get_dq).

clear_q() ->
  gen_server:cast(?MODULE, clear_q).



init([]) ->
  {ok, []}.


handle_cast({add_item, Item}, State) ->
  {noreply, [State | Item]}.
handle_cast({clear_1}, _) ->
  {noreply, []}.
  
handle_call(get_dq, _From, State) ->
  [Head | Tail] = State,
  {reply, Head, Tail}.  
  
  
terminate(_Reason, _State) ->
  ok.
