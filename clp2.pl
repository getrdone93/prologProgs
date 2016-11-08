
factorial(0, 1).
factorial(N, F) :-
	N #> 0,
	N1 #= N - 1,
	F #= N * F1,
	factorial(N1, F1).





start(Setup, M1, M2, M3):-
	[M1, M2, M3] ins 1..5, %3 machines,5 jobs
	all_different([M1,M2,M3]),
	element(M1,[3,2,6,8,9],C1),
	element(M2,[4,6,2,3,2],C2),
	element(M3,[6,3,2,5,2],C3),
	C1 + C2 + C3 #= Setup,
	Setup #=<9.
%	label([M1, M2, M3]).   % labeling([], [M1,M2,M3])


sendmory([S,E,N,D] +
		 [M,O,R,E] =
		[M,O,N,E,Y]) :-
	[S,E,N,D,M,O,R,Y] ins 0..9,
	all_different([S,E,N,D,M,O,R,Y]),
	S #\= 0,
	M #\= 0,
	1000*S + 100*E + 10*N + D +
	1000*M + 100*O + 10*R + E
	#= 10000*M + 1000*O + 100*N + 10*E + Y,
	label([S,E,N,D,M,O,R,Y]).


queens(L,N) :-
	length(L,N),
	generate1(L,N),
	test(L).

generate1(L, N) :-
	genList(L1, N),
	permutation(L1, L).

genList([], 0).
genList([N | L], N) :-
	N > 0,
	N1 is N - 1,
	genList(L, N1).


generate([], _).
generate([First|Rest], N) :-
	getValue(First, N),
	generate(Rest, N).

getValue(N, N) :-
	N > 0.
getValue(V, N) :-
	N > 0,
	N1 is N - 1,
	getValue(V, N1).


test([]).
test([F|Others]) :-
	noattack(F,  Others, 1),
	test(Others).

noattack(_F, [], _Distance).
noattack(F, [Next|Others], Distance) :-
	checknoattack(F, Next, Distance),
	NewDistance is Distance + 1,
	noattack(F, Others, NewDistance).

checknoattack(X, Y, D) :-
	X =\= Y,
	Y =\= X + D,
	X =\= Y + D.


queens_clp(L, N) :-
	length(L, N),
	L ins 1..N,
	safe(L),
	L = [V1 | _],
	indomain(V1).
%	label(L).

queens_ff(L, N) :-
	length(L, N),
	L ins 1..N,
	safe(L),
	labeling([ff], L).

safe([]).
safe([F|T]) :-
  noAttack(F,T,1),
  safe(T).

noAttack(_, [], _).
noAttack(X, [Y|Ys], Nb) :-
	X #\= Y,
	Y #\= X + Nb,
	X #\= Y + Nb,
	Nb1 is Nb + 1,
	noAttack(X, Ys, Nb1).




