%find the last element of a list
lastElement([H], H).

lastElement([_ | T], Last) :-
     lastElement(T, Last).

%find the Nth element in a list
nthElement([H | _], 1, H).

nthElement([_ | T], N, E) :-
     N1 is N - 1,
     N1 > 0,
     nthElement(T, N1, E).

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
reverseList([], ).

reverseList([H | T], L) :-
     addElement(H, L, L1),
%     display(L1),
     reverseList(T, L1).



     %display(ListToReverse),
     %lastElement(ListToReverse, Last),
     %remove(Last, ListToReverse, TempListToRev),
     %RevTemp = [Last | Reverse],
     %display(RevTemp),
