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



validState(M, C) :-
    validMAndC(M, C),
    M =:= 0,
    !.
validState(M, C) :-
    validMAndC(M, C),
    M =:= 3,
    !.
validState(M, C) :-
    validMAndC(M, C),
    MRight is 3 - M,
    CRight is 3 - C,
    MRight >= CRight,
    M >= C.
validMAndC(M, C) :-
    M >= 0,
    M =< 3,
    C >= 0,
    C =< 3.

    % display(MOnRight),display(' '),display(COnRight),display(' '),
    % display(RightVal),display(' '),display(LeftVal),display(' ')
