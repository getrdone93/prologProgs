%Most of these problems are from the following URL:
%https://sites.google.com/site/prologsite/prolog-problems/1

%1.01
%find the last element of a list
lastElement([H], H).

lastElement([_ | T], Last) :-
     lastElement(T, Last).

%1.03
%find the Nth element in a list
nthElement([H | _], 1, H).

nthElement([_ | T], N, E) :-
     N1 is N - 1,
     N1 > 0,
     nthElement(T, N1, E).

%1.04
%find the number of elements in a list
numElements([], 0).
numElements([_ | T], N) :-
     numElements(T, N1),
     N is N1 + 1.

%reverse a list
%1.05
reverseList(L1, L2) :-
    revList(L1, L2, []).
revList([], L2, L2) :- !.
revList([H | T], L2, L3) :-
    revList(T, L2, [H | L3]).

%find out whether a list is a palindrome
%1.06
palindrome(L) :-
    reverseList(L, RevL),
    checkMatch(L, RevL).
checkMatch(L, L).

%Eliminate consecutive duplicates of list elements
%1.08
compress(In, CL) :-
    reverseList(In, RevIn),
    comp(RevIn, CL, []).

comp([], CL, CL) :- !.
comp([H | T], CL, [H | Res]) :-
    !,
    comp(T, CL, [H | Res]).
comp([H | T], CL, Res) :-
    !,
    comp(T, CL, [H | Res]).

%Pack consecutive duplicates of list elements into sublists.
%1.09
pack(L, L1) :-
     sublist(L, L1, Res).

sublist([], Res, Res).
sublist([H | T], L1, [[H | T1] | Res]) :-
     removeElement([H | T1], Res, ResTemp),
     addElement(H, [H | T1], TempSub),
     addElement(TempSub, ResTemp, ResNew),
     sublist(T, L1, ResNew).

%Lib
occurance(_, [], 0).
occurance(H, [H | T], N) :-
    !,
    occurance(H, T, N1),
    N is N1 + 1.
occurance(H, [_ | T], N) :-
    occurance(H, T, N1),
    N is N1.

eleExists(E, [E | _]) :- !.
eleExists(E, [_ | T]) :-
    eleExists(E, T).

%remove an element from a list
removeElement(H, [H | T], T).
removeElement(H, [H1 | T], [H1 | T1]) :-
     removeElement(H, T, T1).

addElement(E, [], [E]).
addElement(E, [H | T], [E, H | T]).
