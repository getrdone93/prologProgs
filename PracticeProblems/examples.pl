%cut example
match([_ | T]) :-
    display(T).

match([H | _]) :-
    !,
    display(H).

match([_ | _]) :-
    display('I get cut!\n').

%simple bottom up
bottomUpCopy([], []).
bottomUpCopy([H | T], [H | T1]) :-
    bottomUpCopy(T, T1),
    display(T1),nl.

%Add this as top most rule to goldbach(2.05) problem on
%arithmetic.pl. This is an example for fail.
goldbach(N, _) :-
    N mod 2 =:= 1,
    !,
    fail.

test(N) :-
    (N >= 1, N =< 5 -> true
    ; (N =:= 57 -> true
    ; fail)).
