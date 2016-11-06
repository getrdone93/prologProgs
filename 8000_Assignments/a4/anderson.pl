%1
donald([D,O,N,A,L,D] +
		 [G,E,R,A,L,D] =
		[R,O,B,E,R,T]) :-
	[D,O,N,A,L,G,E,R,B,T] ins 0..9,
     all_different([D,O,N,A,L,G,E,R,B,T]),
     100000*D + 10000*O + 1000*N + 100*A + 10*L + D +
     100000*G + 10000*E + 1000*R + 100*A + 10*L + D
     #= 100000*R + 10000*O + 1000*B + 100*E + 10*R + T,
     label([D,O,N,A,L,G,E,R,B,T]).

%2
