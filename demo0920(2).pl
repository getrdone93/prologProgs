
% natural(X) is true is X is in of the following formats:
% 0, s(0), s(s(0)), ..., s^n(0), ....
natural(0).
natural(s(X)) :-
	natural(X).

% leq(X, Y)
leq(0, X) :-
	natural(X).
leq(s(X), s(Y)) :-
	leq(X, Y).

% plus(X, Y, Z) s.t. Z = X + Y
plus(0, X, X) :-
	natural(X).
plus(s(X), 0, s(X)).
plus(s(X), s(Y), s(Z)) :-
	plus(X, s(Y), Z).


times(0, Y, 0) :-
	natural(Y).
times(s(X), Y, Z) :-
	times(X, Y, Z1),
	plus(Z1, Y, Z).

% exp(N, X, Y) => X^N = Y
exp(0, s(Y), s(0)) :-
	natural(Y).
exp(s(N), Y, Z) :-
	exp(N, Y, Z1),
	times(Z1, Y, Z).



% member(X, L) to see whether X is in L
% []
% [H | T]
member(X, [X | _]).
member(X, [_H | T]) :-
	member(X, T).

mod(X, Y, X) :-
	less(X, Y).
mod(X, X, 0).
mod(X, Y, Z) :-
	less(Y, X),
	plus(Y, X1, X),
	mod(X1, Y, Z).


starTree(N) :-
	N >= 3,
	printTriangle(N),
	printRoot(N).

printTriangle(N) :-
	printDelta(0, N).

printDelta(_, 0).
printDelta(Bn, N) :-
	N > 0,
	N1 is N - 1,
	Bn1 is Bn + 1,
	printDelta(Bn1, N1),
	blank(Bn),
	star(N), nl.

blank(0).
blank(N) :-
	N > 0,
	write(' '),
	N1 is N - 1,
	blank(N1).

star(0).
star(N) :-
	N > 0,
	write('* '),
	N1 is N - 1,
	star(N1).

printRoot(N) :-
	N1 is N - 1,
	printDelta(N1, 1),
	printDelta(N1, 1).


reach(X, Y) :- reach(X, Z), arc(Z, Y).
reach(X, Y) :- arc(X, Y).
arc(a, b).
arc(b, c).






