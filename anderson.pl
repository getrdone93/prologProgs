:- [clputility].
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

%2.
threeColor(L) :-
	getLists(RelationList, RegionList),
	getColorList(RegionList, TempColorList),
	reverse(TempColorList, ColorList),
	checkSolution(RelationList, ColorList, L).
checkSolution([], L, L).
checkSolution([(R1, R2) | TRel], ColorList, L) :-
	getValue(R1, ColorList, V1),
	getValue(R2, ColorList, V2),
	V1 \= V2,
	checkSolution(TRel, ColorList, L).
getValue(Region, [color(Region, Value) | _], Value) :- !.
getValue(Region, [_ | TCol], Value) :-
	getValue(Region, TCol, Value).
getColorList(RegionList, ColorList) :-
	getColorList(RegionList, ColorList, []).
getColorList([], L, L).
getColorList([H | T], Res, T1) :-
	V in 1..3,
	label([V]),
	getColorList(T, Res, [color(H, V) | T1]).
getLists([(r1,r2), (r1,r4), (r1,r5), (r1,r6), (r2,r3), (r2,r4), (r2,r9),
	(r3,r4), (r3,r5), (r3,r9), (r4,r5), (r5,r6), (r5,r7), (r5,r9),
	(r6,r7), (r6,r8), (r7,r8), (r7,r9), (r8,r9)], [r1,r2,r3,r4,r5,r6,r7,r8,r9]).

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

%4
puzzle(AteMostName, HowMuch, WhatKind) :-
	PersonList = [person('Caleb', NumScoopsCaleb, FlavorCaleb), person('Dakota', NumScoopsDakota, FlavorDakota),
	person('Joey', NumScoopsJoey, FlavorJoey), person('Sara', NumScoopsSara, FlavorSara),
	person('Loren', NumScoopsLoren, FlavorLoren), person('Sydney', NumScoopsSydney, FlavorSydney)],
	NumScoopList = [NumScoopsCaleb, NumScoopsDakota, NumScoopsJoey, NumScoopsSara, NumScoopsLoren,
	NumScoopsSydney],
	FlavorList = [FlavorCaleb, FlavorDakota, FlavorJoey, FlavorSara, FlavorLoren, FlavorSydney],
	FlavorList ins 1..6,
	NumScoopList ins 2..7,
	all_different(NumScoopList),
	NumScoopsCaleb // 2 #= NumScoopsSara,
	FlavorJoey #\= 2,
	FlavorLoren #\= 2,
	NumScoopsJoey #=< NumScoopsSydney,
	FlavorDakota #\= 5,
	NumScoopsSara * 2 #< NumScoopsLoren,
	FlavorSydney #= 5,
	NumScoopsSydney - NumScoopsJoey #= 3,
	NumScoopsLoren - NumScoopsDakota #= 3,
	NumScoopsLoren - NumScoopsSydney #= 2,
	label(NumScoopList),
	label(FlavorList),
	checkFourScoopPerson(PersonList),
	checkChocolateMoreThanVanillaSwirl(PersonList),
	getPersonByFlavor(4, PersonList, person(AteMostName, HowMuch, NumWhatKind)),
	mapNumToFlavor(NumWhatKind, WhatKind).
checkFourScoopPerson([person(_, 4, 3) | _]) :- !.
checkFourScoopPerson([_ | T]) :-
	checkFourScoopPerson(T).
getPersonByFlavor(FlavorNum, [person(Name, NumScoops, FlavorNum) | _], person(Name, NumScoops, FlavorNum)) :- !.
getPersonByFlavor(FlavorNum, [_ | T], Person) :-
	getPersonByFlavor(FlavorNum, T, Person).
checkChocolateMoreThanVanillaSwirl(PersonList) :-
	getPersonByFlavor(6, PersonList, person(_, NumChocoScoops, _)),
	getPersonByFlavor(3, PersonList, person(_, NumVanSwirlScoops, _)),
	NumChocoScoops - NumVanSwirlScoops =:= 2.
mapNumToFlavor(1, 'strawberry').
mapNumToFlavor(2, 'raspberry').
mapNumToFlavor(3, 'vanilla swirl').
mapNumToFlavor(4, 'peach').
mapNumToFlavor(5, 'rocky road').
mapNumToFlavor(6, 'chocolate').
