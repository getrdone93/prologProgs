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
    display(Solution). %needs to be show states
sc([state(0, 0, right) | PriorStates], [state(0, 0, right) | PriorStates]).
sc([CurrentState | PriorStates], Solution) :-
    getPossibleMoves([CurrentState | PriorStates], PossibleMoves),
    moveState(PossibleMoves, [CurrentState | PriorStates], Solution).
moveState(PossibleMoves, [_,PreviousState | PriorStates], Solution) :-
    PossibleMoves = [],
    getPossibleMoves([PreviousState | PriorStates], TempPossibleMoves),
    moveState(TempPossibleMoves, [PreviousState | PriorStates], Solution).
moveState([NextMove | _], PriorStates, Solution) :-
    sc([NextMove | PriorStates], Solution).

getPossibleMoves([CurrentState | PriorStates], PossibleMoves) :-
    getAllStates(AllStates),
    diffList(AllStates, [CurrentState | PriorStates], UnmarkedStates),
    generateValidMoves(CurrentState, UnmarkedStates, PossibleMoves).

generateValidMoves(_, [], []).
generateValidMoves(State, [H | AllStates], [H | ValidMoves]) :-
    validMove(State, H),
    generateValidMoves(State, AllStates, ValidMoves).
generateValidMoves(State, [_ | AllStates], ValidMoves) :-
    generateValidMoves(State, AllStates, ValidMoves).

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


    % netChange(CurrM, NewM, NetM),
    % netChange(CurrC, NewC, NetC),
    % NetMoved is NetM + NetC,
    % NetMoved >= 1,
    % NetMoved =< 2,
    %CurrB \== NewB.

validMove(State, NewState) :-
    getM(State, LeftM),
    getC(State, LeftC),
    getB(State, CurrB),
    getM(NewState, NewLeftM),
    getC(NewState, NewLeftC),
    getB(NewState, NewB),
    ChangeM is LeftM - NewLeftM,
    ChangeC is LeftC - NewLeftC,
    vldLeftToRight(LeftM, LeftC, CurrB, ChangeM, ChangeC, NewB),
    !.
validMove(State, NewState) :-
    getM(State, LeftM),
    getC(State, LeftC),
    getB(State, CurrB),
    getM(NewState, NewLeftM),
    getC(NewState, NewLeftC),
    getB(NewState, NewB),
    RightM is 3 - LeftM,
    RightC is 3 - LeftC,
    NewRightM is 3 - NewLeftM,
    NewRightC is 3 - NewLeftC,
    ChangeM is RightM - NewRightM,
    ChangeC is RightC - NewRightC,
    vldRightToLeft(RightM, RightC, CurrB, ChangeM, ChangeC, NewB).

vldLeftToRight(LeftM, LeftC, left, ChangeM, ChangeC, right) :-
    NetChange is ChangeM + ChangeC,
    (LeftM =:= 0, LeftC \= 0, ChangeC >= 1, ChangeC =< 2 -> true
    ; (LeftC =:= 0, LeftM \= 0, ChangeM >= 1, ChangeM =< 2 -> true
    ; (LeftM > 0, LeftC > 0, NetChange >= 1, NetChange =< 2 -> true))).

vldRightToLeft(RightM, RightC, right, ChangeM, ChangeC, left) :-
    NetChange is ChangeM + ChangeC,
    (RightM =:= 0, RightC \= 0, ChangeC >= 1, ChangeC =< 2 -> true
    ; (RightC =:= 0, RightM \= 0, ChangeM >= 1, ChangeM =< 2 -> true
    ; (RightM > 0, RightC > 0, NetChange >= 1, NetChange =< 2 -> true))).

netChange(X, Y, Z) :-
    X >= Y,
    Z is X - Y,
    !.
netChange(X, Y, Z) :-
    X < Y,
    Z is Y - X.

getM(State, M) :-
    arg(1, State, M).
getC(State, C) :-
    arg(2, State, C).
getB(State, B) :-
    arg(3, State, B).

%return eles in L1 but not in L2
diffList(L1, L2, L) :-
     diffList(L1, L2, [], L).
diffList([], _, L, L).
diffList([H | T], L2, L, Res) :-
     eleExists(H, L2),
     diffList(T, L2, L, Res).
diffList([H | T], L2, L, Res) :-
     addElement(H, L, TempL),
     diffList(T, L2, TempL, Res).
addElement(E, [], [E]).
addElement(E, [H | T], [E, H | T]).
eleExists(E, [E | _]) :- !.
eleExists(E, [_ | T]) :-
    eleExists(E, T).

    % nl,nl,display('PS: '),display([CurrentState | PriorStates]),nl,halt,
    % nl,nl,display('CS: '),display(CurrentState),nl,nl,display('PM: '),display(PossibleMoves),nl,

    % nl,nl,display('PS: '),display(PriorStates),nl,nl,display('MS: '),display(MoveSet),nl,halt,
