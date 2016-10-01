%author: Trever Anderson
%a
natural_number(0).
natural_number(s(X)) :-
	natural_number(X).
    
%b
less(0, X) :-
	natural_number(X).
less(s(X), s(Y)) :-
    s(X) \= s(Y),
	less(X, Y).
    
%c
plus(0, X, X) :-
	natural_number(X).
plus(s(X), 0, s(X)).
plus(s(X), s(Y), s(Z)) :-
	plus(X, s(Y), Z).
    
    
%d
times(0, Y, 0) :-
	natural_number(Y).
times(s(X), Y, Z) :-
	times(X, Y, Z1),
	plus(Z1, Y, Z).
    
%e
exp(0, s(Y), s(0)) :-
	natural_number(Y).
exp(s(N), Y, Z) :-
	exp(N, Y, Z1),
	times(Z1, Y, Z).
    
%f
mod(0, _, 0).   
mod(_, s(0), 0).
mod(X, X, 0) :- 
    natural_number(X).
mod(X, Y, X) :-
    less(X, Y).    
%X must be greater than Y
mod(X, Y, Z) :-
    plus(Y, Z1, X),                       
    mod(Z1, Y, Z).
    
%g
intDiv(X, s(0), X) :-
    natural_number(X).   
intDiv(0, _, 0).
intDiv(X, X, s(0)) :-
    natural_number(X).
intDiv(X, Y, 0) :-
    less(X, Y).
%X must be greater than Y
intDiv(X, Y, Z) :-
    mod(X, Y, 0), %divide evenly
    times(Y, Z, X). 
%X must be greater than Y and do not divide evenly
intDiv(X, Y, Z) :-
    mod(X, Y, Z1),
    plus(Z1, Z2, X),
    times(Y, Z, Z2).

    
%2    
printSpaces(0).
printSpaces(N) :-
    N1 is N - 1,
    display(' '),
    printSpaces(N1).
  
printStars(0).  
printStars(N) :-
    N1 is N - 1,
    display('* '),
    printStars(N1).

starTree(0).
starTree(N) :-
    N1 is N - 1,
    starTree(N1),
    printStars(N),
    display('\n').    
  


