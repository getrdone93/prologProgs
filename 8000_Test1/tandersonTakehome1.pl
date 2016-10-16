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
