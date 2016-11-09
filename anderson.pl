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

getLists([(r1,r2), (r1,r4), (r1,r5), (r1,r6), (r2,r3), (r2,r4), (r2,r9),
(r3,r4), (r3,r5), (r3,r9), (r4,r5), (r5,r6), (r5,r7), (r5,r9),
(r6,r7), (r6,r8), (r7,r8), (r7,r9), (r8,r9)], [r1,r2,r3,r4,r5,r6,r7,r8,r9]).

threeColor(L) :-
	getLists(RelationList, [_,H | _]),
	getDomainForRegion(RelationList, H, L).
getDomainForRegion(RelationList, Region, DomainList) :-
	getDomainForRegion(RelationList, Region, DomainList, []).
getDomainForRegion([], _, L, L).
getDomainForRegion([(R1, R2) | TRelation], R1, Res, DomainList) :-
	getDomainForRegion(TRelation, R1, Res, [R2 | DomainList]).
getDomainForRegion([_ | TRelation], R1, Res, DomainList) :-
	getDomainForRegion(TRelation, R1, Res, DomainList).





%3
assign(Profit, [W1, W2, W3, W4]):-
	[W1, W2, W3, W4] ins 1..6, %4 workers, 6 tasks
	all_different([W1, W2, W3, W4]),
	element(W1,[7,4,3,6,5,4],C1),
	element(W2,[3,2,3,2,3,1],C2),
	element(W3,[7,5,6,4,4,2],C3),
	element(W4,[4,2,1,3,3,1],C4),
	C1 + C2 + C3 + C4 #= Profit,
    maximize(Profit, [W1, W2, W3, W4]).
