
:- use_module(library(clpfd)).

scheduleProblem([task(j1, 3, [], m1), task(j2, 8, [], m1),
                 task(j3, 8, [j4,j5], m1),
                 task(j4, 6, [], m2), task(j5, 3, [j1], m2),
                 task(j6, 4, [j1], m2) ]).
% task(JobName, Duration, Depency, Machine)

setDomain(V) :- V in 0..100.

schedule(End, Jobs) :-
        scheduleProblem(Data),
        setDomain(End),
        maplist(transform(End), Data, Jobs),
             % job(JobName, Start, Duration, Machine)
        maplist(setPrecedence(Jobs), Data),
        shareMachine(Jobs),
        maplist(labelVar, Jobs),
        label([End]).

labelVar(job(_, Start, _, _)) :-
        label([Start]).


shareMachine(Jobs) :-
        maplist(getMachine, Jobs, MachList),
        setof(M, member(M, MachList), MList),
        maplist(setMachine(Jobs), MList).

setMachine(Jobs, M) :-
        maplist(job4Cumulate(M), Jobs, TaskList),
        append(TaskList, TL),
        cumulative(TL).

job4Cumulate(M, job(JobName, Start, Dur, M),
             [task(Start, Dur, _, 1, JobName)]) :- !.
job4Cumulate(_M, _, []).


getMachine(job(_, _, _, M), M).


transform(End, task(JobName, Dur, _DepList, Machine),
          job(JobName, Start, Dur, Machine)) :-
        setDomain(Start),
        Start + Dur #=< End.

% old wrong version
%setPrecedence(Jobs, task(_, NextStart, DepList, _)) :-
%        maplist(setDepRelation(NextStart, Jobs), DepList).

setPrecedence(Jobs, task(Job, _, DepList, _)) :-
        member(job(Job, NextStart, _, _), Jobs),
        maplist(setDepRelation(NextStart, Jobs), DepList).


setDepRelation(NextStart, Jobs, PreJob) :-
        member(job(PreJob, Start, Duration, _), Jobs),
        Start + Duration #=< NextStart.






prefer( 1, [3,2,1,4,6,5,8,9,10,7]).
prefer( 2, [5,3,2,6,1,7,9,8,4,10]).
prefer( 3, [10,8,1,9,7,4,3,6,2,5]).
prefer( 4, [7,3,2,9,5,4,8,6,1,10]).
prefer( 5, [1,3,6,8,5,2,9,10,7,4]).
prefer( 6, [4,9,1,5,6,8,2,7,10,3]).
prefer( 7, [2,1,10,9,5,3,6,8,4,7]).
prefer( 8, [6,5,1,3,2,4,7,8,9,10]).
prefer( 9, [8,9,10,5,4,3,2,1,6,7]).
prefer(10, [9,10,3,2,5,4,1,7,8,6]).
prefer(11, [7,3,5,2,9,8,1,10,4,6]).
prefer(12, [6,5,1,9,10,2,3,4,7,8]).
prefer(13, [6,8,10,9,1,2,3,4,5,7]).
prefer(14, [6,3,5,9,1,2,10,4,8,7]).

officeSize([1,1,1,1,2,1,2,2,2,1]).

assign(AL, PTotal) :-
        PTotal in 1..1000,
        length(AL, 14),
        AL ins 1..10,
        getNumList(10, L),   % [1,2,3,4,...,10]
        officeSize(SL),
        maplist(pair, L, SL, PairList),
        global_cardinality(AL, PairList),
        getNumList(14, EL),
        maplist(getPrefer, EL, AL, PList),
        sum(PList, #=, PTotal),
        label(AL).




getPrefer(Ei, Sel, PV) :-
        prefer(Ei, PTable),
        element(Sel, PTable, PV).


pair(Key, Num, Key-Num).

getNumList(N, L) :-   % [1,2,3,...,N]
        length(L, N),
        L ins 1..N,
        chain(L, #<).

