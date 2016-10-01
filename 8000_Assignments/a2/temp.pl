
mainSub([_, _], L) :-
     sub([], L).
    
mainSub([H1 | T], L) :-
    sub([H1 | T], L1),
    longestList(L, L1, L2),
    display(L),display('  '),display(L1),display('  '),display(L2),
display('\n'),
    mainSub(T, L2).
    
 
sub([], _).
    
sub([H1, H2], [H1, H2 | _]) :-
    cross([H1, H2], 1).
    
sub([H1, H2 | T], L) :-    
    cross([H1, H2], 1),
    add(H1, L, L1),
    sub([H2 | T], L1).
    
sub([H1, H2 | _], L) :-    
    cross([H1, H2], 0),
    add(H1, L, L1),
    sub([], L1).

 add(X, L, [X|L]). 
 conc([], L, L).
conc([H|T], L, [H|L1]) :-
    conc(T, L, L1).
 
 sub([H1, H2], L) :-
    cross([H1, H2], 0),
    sub([], L).   
    
  
member(X, [X | _]).
member(X, [_H | T]) :-
	member(X, T).
    
    
lengthOfList([], 0).
lengthOfList([_ | T], N) :-
    lengthOfList(T, N1),
    N is N1 + 1.  
    
longestList(L, L1, L1) :-
    lengthOfList(L, Len),
    lengthOfList(L1, Len1),
    Len < Len1.
    
longestList(L, L1, L) :-
    lengthOfList(L, Len),
    lengthOfList(L1, Len1),
    Len >= Len1.