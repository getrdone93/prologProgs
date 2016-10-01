%cut example
match([_ | T]) :-
    display(T).

match([H | _]) :-
    !,
    display(H).

match([_ | _]) :-
    display('I get cut!\n').
