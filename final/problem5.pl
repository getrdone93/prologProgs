pick(4, 1).
pick(44, 2).
pick(0.4, 1).
pick(infinity(0.4), 1).

unary(u(+)).
unary(u(-)).
unary(u(sqrt)).
unary(u(!)).
unary(u(square)).

binary(b(+)).
binary(b(-)).
binary(b(*)).
binary(b(/)).


getFourList(FourList) :-
    getFourList(FourList, 4).

getFourList(_, 1) :- !.
getFourList(FourList, 4) :-
    findall(pick(F, C), pick(F, C), Initial),
    member(H, Initial),
    getFourList([H], FourList, 4).
getFourList(FourList, N) :-
    N =< 3,
    findall(pick(F, C), pick(F, C), TempList),
    member(H, TempList),
    subtract(TempList, [H], EndList),
    getFourList([H | EndList], TempFourList, N),
    permutation(TempFourList, FourList).
getFourList(FourList, N) :-
    N1 is N - 1,
    getFourList(FourList, N1).

getFourList([H | _], FourList, 4) :-
    duplicateNTimes([H], 4, FourList).
getFourList([H | Init], FourList, 3) :-
    duplicateNTimes([H], 3, Temp),
    member(L, Init),
    append(Temp, [L], FourList).
getFourList([H | Init], FourList, 2) :-
    duplicateNTimes([H], 2, Temp),
    getPowerSet(Init, 2, EndList),
    append(Temp, EndList, FourList).

validFourList(FourList) :-
    validFourList(FourList, 0).
validFourList([], 4).
validFourList([pick(_, C) | List], Count) :-
    TempCount is Count + C,
    validFourList(List, TempCount).

duplicateNTimes(L1, N, L2) :-
    duplicateNTimes(L1, N, L2, N).
duplicateNTimes([],_,[],_) :- !.
duplicateNTimes([_ | Xs], N, Ys, 0) :-
    duplicateNTimes(Xs, N, Ys, N),
    !.
duplicateNTimes([X | Xs], N, [X | Ys], K) :-
     K > 0,
     K1 is K - 1,
     duplicateNTimes([X | Xs], N, Ys, K1).

 getPowerSet(List, N, Res) :-
     powerset(List, Res),
     length(Res, Len),
     Len =:= N.

 powerset([], []).
 powerset([_ | T], P) :-
     powerset(T, P).
 powerset([H | T], [H | P]) :-
     powerset(T, P).
