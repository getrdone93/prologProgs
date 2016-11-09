
:- use_module(library(clpfd)).

solveSudoku(Rows) :-
       problem(_, Rows),
       sudoku(Rows),
       maplist(writeln, Rows).

sudoku(Rows) :-
        length(Rows, 9), maplist(same_length(Rows), Rows),
        append(Rows, Vs), Vs ins 1..9,
        maplist(all_distinct, Rows),
        transpose(Rows, Columns),
        maplist(all_distinct, Columns),
        Rows = [As,Bs,Cs,Ds,Es,Fs,Gs,Hs,Is],
        blocks(As, Bs, Cs),
        blocks(Ds, Es, Fs),
        blocks(Gs, Hs, Is).

blocks([], [], []).
blocks([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :-
        all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
        blocks(Ns1, Ns2, Ns3).

problem(1, [[_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,3,_,8,5],
            [_,_,1,_,2,_,_,_,_],
            [_,_,_,5,_,7,_,_,_],
            [_,_,4,_,_,_,1,_,_],
            [_,9,_,_,_,_,_,_,_],
            [5,_,_,_,_,_,_,7,3],
            [_,_,2,_,1,_,_,_,_],
            [_,_,_,_,4,_,_,_,9]]).


puzzle(Waterdrinker, ZebraOwner) :-
	Country = [English, Spaniard, Ukrainian, Norwegian, Japanese],
	Animal = [Dog, Snail, Fox, Horse, Zebra],
	Drink = [Coffee, Tea, Orange, Milk, Water],
	Car = [Bmw, Toyota, Ford, Datsun, Honda],
	Color = [Red, Green, Blue, Yellow, Ivory],
	VarList = [Country, Animal, Drink, Car, Color],

	maplist(setDomain(1..5), VarList),
	maplist(all_different, VarList),

	English #= Red,
	Spaniard #= Dog,
	Coffee #= Green,
	Ukrainian #= Tea,
	Ivory + 1 #= Green,
	Bmw #= Snail,
	Yellow #= Toyota,
	Milk #= 3,
	Norwegian #= 1,
	abs(Ford - Fox) #= 1,
	abs(Toyota - Horse) #= 1,
	Honda #= Orange,
	Japanese #= Datsun,
	abs(Norwegian - Blue) #= 1,

	maplist(label, VarList),
	Table = [(English, 'English'), (Spaniard, 'Spaniard'),
		 (Ukrainian, 'Ukrainian'), (Norwegian, 'Norwegian'),
		 (Japanese, 'Japanese')],
	member((Water, Waterdrinker), Table),
	member((Zebra, ZebraOwner), Table).


setDomain(Domain, VarList) :-
	VarList ins Domain.




