
% reverseL([H | T], RevTerm) %reverse a list
%     \+ containCompound([H | T]),
%      reverseList([H | T], RevT),
%      RevTerm =.. RevT.
% reverseL([H | T], RevTerm) :-
%     reverseArgs([H | T], RevTerm).

reverseFunctor([H | T], RevTerm) :- %reverse a functor
    \+ containCompound([H | T]),
    reverseList(T, RevT),
    RevTerm =.. [H | RevT].

reverseFunctor(Term, RevTerm) :-
    Term =.. [H | T], %passed a functor
    reverseFunctor([H | T], RevTerm).

reverseArgs(Term, RevTerm) :-
    revArgs(Term, RevTerm).
revArgs(Term, RevTerm) :-
    reverseFunctor(Term, RevTerm),
    !.
revArgs(Term, RevTerm) :-
    reverseL(Term, RevTerm).





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
