reverseArgs(Term, RevTerm) :-
    Term = [_ | _],
    !,
    revArgs(Term, RevTerm).
reverseArgs(Term, RevTerm) :-
    Term =.. [H | T], %Term is of type functor here
    revArgs(T, RevList), %keep the head because it cannot be shuffled to the end
    RevTerm =.. [H | RevList].
revArgs([H | T], L) :-
    \+ containCompound([H | T]),
    reverseList([H | T], L).





containCompound([H | _]) :-
    compound(H),
    !.
containCompound([_ | T]) :-
    containCompound(T).

reverseList(L1, L2) :-
    revList(L1, L2, []).
revList([], L2, L2) :- !.
revList([H | T], L2, L3) :-
    revList(T, L2, [H | L3]).
