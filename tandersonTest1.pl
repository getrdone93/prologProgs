%1
%generate the nth iteration of fib
fib(N, F) :-
     fib(N, 0, F).
fib(N, N, 0).



%2
merge([], L, L).
merge(L, [], L).
merge([H], [H1], [H, H1]) :-
     H =< H1.
merge([H1], [H], [H1, H]) :-
     H1 > H.
merge([H | T], [H1 | T1], [H | L]) :-
     H =< H1,
     merge(T, T1, L).
merge([H1 | T1], [H | T], [H1 | L]) :-
     H1 > H,
     merge(T, T1, L).

%3
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

%4
% ld(L1, L2) :-
     % findSublist(L1, [], Res),
findSublist([H], [H1 | L], Res) :-
     H > H1,
     addElement(H, L, Res).
findSublist([H, H1 | T], L, Res) :-
     H > H1,
     addElement(H, L, L1),
     findSublist([H1 | T], L1, Res).
