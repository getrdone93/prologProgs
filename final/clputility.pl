:- use_module(library(clpfd)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following predicates can be used to run the goal and display the runtime.
% runtime(G) is to run G and get the runtime.
% runAll(V,G,L) is to find all solutions of V as a resulting list L such that G is true,
%   and display the total runtime.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

runtime(G) :-
   cputime(A),
   call(G),
   cputime(B),
   write('The running time is '),
   Time is (B - A) / 1000,
   write(Time),
   writeln(' seconds.').

cputime(T) :-
     statistics(runtime, [T,_]).

runAll(V,G,L) :-
   cputime(A),
   findall(V,G,L),
   cputime(B),
   length(L, N),
   write('The total number of solutions is '),
   writeln(N),
   write('The running time is '),
   Time is (B - A) / 1000,
   write(Time),
   writeln(' seconds.').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following predicates can be used to find the optimal solutions.
% minimize(Obj, Vars) is used to find solutions of Vars when Obj is minimized.
% maximize(Obj, Vars) is used to find solutions of Vars when Obj is maximized.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maximize(M0, Vs0) :-
    maximize1(M0, Vs0, M0, Vs0).

maximize1(M0, Vs0, Max, Vs) :-
    copy_term(M0-Vs0, M1-Vs1),
    once(label(Vs1)),
    maximize1(M0-Vs0, M1-Vs1, Max-Vs).

maximize1(M0Vs0, M1-_Vs1, Max-Vs) :-
    copy_term(M0Vs0, M2-Vs2),
    (   M2 #> M1, label(Vs2) ->
        maximize1(M0Vs0, M2-Vs2, Max-Vs)
    ;   copy_term(M0Vs0, Max-Vs),
        Max #= M1, label(Vs)
    ).

minimize(M0, Vs0) :-
    minimize1(M0, Vs0, M0, Vs0).

minimize1(M0, Vs0, Max, Vs) :-
    copy_term(M0-Vs0, M1-Vs1),
    once(label(Vs1)),
    minimize1(M0-Vs0, M1-Vs1, Max-Vs).

minimize1(M0Vs0, M1-_Vs1, Max-Vs) :-
    copy_term(M0Vs0, M2-Vs2),
    (   M2 #< M1, label(Vs2) ->
        minimize1(M0Vs0, M2-Vs2, Max-Vs)
    ;   copy_term(M0Vs0, Max-Vs),
        Max #= M1, label(Vs)
    ).


fd_minimize(Goal, Obj) :-
    copy_term(Goal-Obj, GoalCopy-ObjCopy),
    once(call(GoalCopy)),
    fd_min(Goal-Obj, ObjCopy, Obj).
    
fd_min(Goal-Obj, BestObjSoFar, Obj) :-
    copy_term(Goal-Obj, GoalCopy-ObjCopy),
    ( ObjCopy #< BestObjSoFar, call(GoalCopy)
        -> fd_min(Goal-Obj, ObjCopy, Obj)
        ;  Obj #= BestObjSoFar,
           call(Goal)
    ).

