%P01
%find the last element of a list
lastElement([H], H).

lastElement([_ | T], Last) :-
     lastElement(T, Last).

%P03
%find the Nth element in a list
nthElement([H | _], 1, H).

nthElement([_ | T], N, E) :-
     N1 is N - 1,
     N1 > 0,
     nthElement(T, N1, E).

%P04
%find the number of elements in a list
numElements([], 0).

numElements([_ | T], N) :-
     numElements(T, N1),
     N is N1 + 1.

%remove an element from a list
remove(H, [H | T], T).
remove(H, [H1 | T], [H1 | T1]) :-
     remove(H, T, T1).

addElement(E, [], [E]).
addElement(E, [H | T], [E, H | T]).

%reverse a list
reverseList(L1, L2) :-
    revList(L1, L2, []).
revList([], L2, L2) :- !.
revList([H | T], L2, L3) :-
    revList(T, L2, [H | L3]).

%cut example
match([_ | T]) :-
    display(T).

match([H | _]) :-
    !,
    display(H).

match([_ | _]) :-
    display('I get cut!\n').
