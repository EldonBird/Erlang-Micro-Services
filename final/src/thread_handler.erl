%%%-------------------------------------------------------------------
%%% @author Birdh
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. Jun 2025 20:34
%%%-------------------------------------------------------------------
-module(thread_handler).
-author("Birdh").

%% API
-export([]).













thread(UserID) when not is_list(UserID) ->
  % Initial Setup
  thread([] ++ [{UserID, create_thread, "Server Has Started Thread", "01/01/25/00/00"}]);
thread(State) ->
  receive {Sender, {User_id, Command, Message, Time}} ->
    
    % You would add user checking and verification here i think.
    
    % perform the command
    
    if(Command == "comment") ->
      
    

    thread(State)
  end.
  
  



find_thread([], _) ->
  "DNE";
find_thread([{Current_PID, Current_Thread_Id} | _], Thread_ID) when Current_Thread_Id == Thread_ID ->
  Current_PID;
find_thread([_ | Remainder], Thread_ID) ->
  find_thread(Remainder, Thread_ID).


thread_registry(Registry) ->
    receive { Sender, Command, Args} ->
        
        result = Command(Args),
        
        thread_registry(Registry)
        
      
      end.
  

% Registry Commands


% First ever time creating this thread
create_thread(User_ID) ->
  spawn(fun() -> thread(#{[]}) end).
.

% Try to start up an old thread...?
start_thread(Registry, Thread_ID) ->
  result = find_thread(Registry, Thread_ID),
  if(result == "DNE") ->
    
    
    find_thread([{Current_PID, Current_Thread_Id} | _], Thread_ID) when Current_Thread_Id == Thread_ID ->
  Current_PID;
find_thread([_ | Remainder], Thread_ID) ->
  find_thread(Remainder, Thread_ID).
    .
    
    
get_thread_history(Thread_ID) ->



% Thread Commands




% MSG -> {User_id, "Command", Comment, TimeStamp}
post_comment(Thread, MSG) ->

  
  
  
  
.

get_thread_data() ->

.
  