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
