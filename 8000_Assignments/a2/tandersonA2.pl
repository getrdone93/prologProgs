%1
cross([H1, H2], 1) :-
    H1 * H2 < 0.

cross([H1, H2], 0) :-
    H1 * H2 >= 0.

cross([H1, H2 | T], N) :-
    H1 * H2 < 0,
    cross([H2 | T], N1),
    N is N1 + 1.

cross([H1, H2 | T], N) :-
    H1 * H2 >= 0,
    cross([H2 | T], N1),
    N is N1.
    
%2.
add(X, L, [X|L]).


findSub([], _).

findSub([H], [H1 | T]) :-
    cross([H, H1], 1),
    add(H, [H1 | T], L),
    display(L).

findSub([H1, H2 | T], L) :-
    cross([H1, H2], 1),
    add(H1, L, L1),
%   display(L1),
    findSub([H2 | T], L1).


main([H | T], L) :-
    findSub([H | T], L1),       %find longest cross over sub list
    compareList(L, L1, L2),     %check if L1 sublist is greater than current
    main(T, L2).                %loop with current greatest list
