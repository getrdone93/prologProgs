%1.
reverseArgs(Term, RevTerm) :- %type is list here
    isList(Term),
    !,
    revArgs(Term, List),
    reverseList(List, RevTerm).
reverseArgs(Term, RevTerm) :- %type functor here
    Term =.. [H | T],
    revArgs(T, List), %keep the head because it cannot be shuffled to the end
    reverseList(List, RevList),
    RevTerm =.. [H | RevList].
revArgs([], []).
revArgs([H | T], [H | L]) :-
    \+ compound(H),
    !,
    revArgs(T, L).
revArgs([H | T], [TermH | L]) :-
    reverseArgs(H, TermH),
    revArgs(T, L).

isList(Term) :-
    Term = [_ | _].

reverseList(L1, L2) :-
    revList(L1, L2, []).
revList([], L2, L2) :- !.
revList([H | T], L2, L3) :-
    revList(T, L2, [H | L3]).

%3
cannibal :-
    sc([state(3, 3, left)], Solution),
    reverseList(Solution, RevSol),
    show_states(RevSol). %needs to be show states
sc([state(0, 0, right) | PriorStates], [state(0, 0, right) | PriorStates]).
sc([CurrentState | PriorStates], Solution) :-
    getPossibleMoves([CurrentState | PriorStates], PossibleMoves),
    moveState(PossibleMoves, [CurrentState | PriorStates], Solution).

moveState([], [CurrentState,PreviousState | PriorStates], Solution) :-
    getPossibleMoves([PreviousState,CurrentState | PriorStates], TempPossibleMoves),
    moveState(TempPossibleMoves, [PreviousState | PriorStates], Solution).

moveState([NextMove | _], PriorStates, Solution) :-
    sc([NextMove | PriorStates], Solution).

getPossibleMoves([CurrentState | PriorStates], PossibleMoves) :-
    getAllStates(AllStates),
    subtract(AllStates, [CurrentState | PriorStates], UnmarkedStates),
    generateValidMoves(CurrentState, UnmarkedStates, PossibleMoves).

generateValidMoves(State, GivenStates, ValidMoves) :-
    validMove(State, TheoreticalMoves),
    intersection(GivenStates, TheoreticalMoves, ValidMoves).

show_states([]).
show_states(state(M, C, B)) :-
    showM(M),
    showC(C),
    showBoat(B),
    RightM is 3 - M,
    RightC is 3 - C,
    showM(RightM),
    showC(RightC),
    nl.
show_states([state(M, C, B) | T]) :-
    show_states(state(M, C, B)),
    show_states(T).
showM(0).
showM(M) :-
    M1 is M - 1,
    display('M'),
    showM(M1).
showC(0).
showC(C) :-
    C1 is C - 1,
    display('C'),
    showC(C1).
showBoat(left) :-
    display(' (____)   ').
showBoat(right) :-
    display('     (____) ').

getAllStates(AllStates) :-
    AllStates = [state(3, 3, left),
    state(3, 2, left), state(3, 2, right),
    state(3, 1, left), state(3, 1, right),
    state(3, 0, left), state(3, 0, right),
    state(2, 2, left), state(2, 2, right),
    state(1, 1, left), state(1, 1, right),
    state(0, 3, left), state(0, 3, right),
    state(0, 2, left), state(0, 2, right),
    state(0, 1, left), state(0, 1, right),
    state(0, 0, right)].

validMove(state(M, C, left), ValidMoves) :-
    M1 is M - 1,
    C1 is C - 1,
    M2 is M - 2,
    C2 is C - 2,
    buildNewState(M1, C, right, OneMissionary),
    buildNewState(M, C1, right, OneCannibal),
    buildNewState(M1, C1, right, OneMissionaryOneCannibal),
    buildNewState(M2, C, right, TwoMissionary),
    buildNewState(M, C2, right, TwoCannibal),
    [OneMissionary, OneCannibal, OneMissionaryOneCannibal, TwoMissionary
    , TwoCannibal] = ValidMoves.
validMove(state(M, C, right), ValidMoves) :-
    M1 is M + 1,
    C1 is C + 1,
    M2 is M + 2,
    C2 is C + 2,
    buildNewState(M1, C, left, OneMissionary),
    buildNewState(M, C1, left, OneCannibal),
    buildNewState(M1, C1, left, OneMissionaryOneCannibal),
    buildNewState(M2, C, left, TwoMissionary),
    buildNewState(M, C2, left, TwoCannibal),
    [OneMissionary, OneCannibal, OneMissionaryOneCannibal, TwoMissionary
    , TwoCannibal] = ValidMoves.

buildNewState(M, C, B, NewState) :-
    NewState =.. [state, M, C, B].
