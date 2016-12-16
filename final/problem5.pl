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

%take unary ops and wrap them around fours
% applyUnaryOps([4 | List]) :-

evalEquation([Four1, Op, Four2], Result) :-
    !,
    eval(Four1, Op, Four2, Result).

evalEquation([Four1, Op1, Four2, Op2, Four3], Result) :-
    eval(Four1, Op1, Four2, TempResult),
    eval(TempResult, Op2, Four3, Result).
evalEquation([Four1, Op1, Four2, Op2, Four3], Result) :-
    eval(Four2, Op2, Four3, TempResult),
    eval(Four1, Op1, TempResult, Result),
    !.

evalEquation([Four1, Op1, Four2, Op2, Four3, Op3, Four4], Result) :-
    permutation([[Four1, Op1, Four2], [Four2, Op2, Four3], [Four3, Op3, Four4]]
    , [L1, L2, L3]),
    [FourL1, OpL1, Four2L1] = L1,
    [_, OpL2, Four2L2] = L2,
    [_, OpL3, Four2L3] = L3,
    display(L1),display(' '),
    display(L2),display(' '),
    display(L3),display(' '),nl,
    eval(FourL1, OpL1, Four2L1, TempRes),
    eval(TempRes, OpL2, Four2L2, TempRes2),
    eval(TempRes2, OpL3, Four2L3, Result).

eval(Op1, +, Op2, Result) :-
    Result is Op1 + Op2,
    !.
eval(Op1, -, Op2, Result) :-
    Result is Op1 - Op2,
    !.
eval(Op1, *, Op2, Result) :-
    Result is Op1 * Op2,
    !.
eval(Op1, /, Op2, Result) :-
    Op2 > 0,
    Result is Op1 / Op2,
    !.

buildEquation([Four1, Four2, Four3, Four4], [Four1, Op1, Four2, Op2, Four3, Op3, Four4]) :-
    findall(O, binary(b(O)), OpList),
    reverse(OpList, RevOpList),
    member(Op1, OpList),
    member(Op2, RevOpList),
    member(Op3, OpList).
buildEquation([Four1, Four2, Four3], [Four1, Op1, Four2, Op2, Four3]) :-
    findall(O, binary(b(O)), OpList),
    reverse(OpList, RevOpList),
    member(Op1, OpList),
    member(Op2, RevOpList).
buildEquation([Four1, Four2], [Four1, Op, Four2]) :-
    findall(O, binary(b(O)), OpList),
    member(Op, OpList).

listOfFours([], []).
listOfFours([pick(infinity(_), _) | FourTerms], [0.44444444 | L]) :-
    !,
    listOfFours(FourTerms, L).
listOfFours([pick(Four, _) | FourTerms], [Four | L]) :-
    listOfFours(FourTerms, L).

generateFours(FourList) :-
    getFourList(FourTerms),
    validFourList(FourTerms),
    listOfFours(FourTerms, FourList).

getFourList(FourList) :-
    getFourList(FourList, 4).

getFourList([pick(44, 2), pick(44, 2)], 0) :- !.
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
getFourList([H | Init], FourList, 1) :-
    getPowerSet(Init, 2, EndList),
    append([H], EndList, FourList).

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
