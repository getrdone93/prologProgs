pick(4, 1).
pick(44, 2).
pick(0.4, 1).
% pick(infinity(0.4), 1).

unary(u(+)).
unary(u(-)).
unary(u(sqrt)).
unary(u(!)).
unary(u(square)).

binary(b(+)).
binary(b(-)).
binary(b(*)).
binary(b(/)).

evaluator(Equation, Result) :-
    evaluator(Equation, 0, Result).
evaluator([])

builderFourElements(FourList, Equation) :-
    findall(Op, binary(b(Op)), BinaryOps),
    member(Function, BinaryOps),
    constructEquation(Function, FourList, Equation).
constructEquation(Function, [F1, F2, F3, F4], Equation) :-
    Equation = [F1, Function, F2, Function, F3, Function, F4].

fourPicker(FourList, 4) :-
    findall((Four, Count), pick(Four, Count), AllFours),
    member(Four, AllFours),
    repeatElement(Four, TempFourList, 4),
    validFourList(TempFourList),
    getFours(TempFourList, FourList).

getFours(FourList) :-
    getFours(FourList, []).
getFours([], []).
getFours([(Four, _) | FourList], [Four | Result]) :-
    getFours(FourList, Result).

validFourList(FourList) :-
    validFourList(FourList, 0).
validFourList([], Count) :-
    Count >= 1,
    Count =< 4.
validFourList([(_, Count) | FourList], TotalCount) :-
    TempTotalCount is TotalCount + Count,
    validFourList(FourList, TempTotalCount).

repeatElement(E, List, N) :-
    repeatElement(E, [], List, N, 0).
repeatElement(_, Res, Res, N, N) :- !.
repeatElement(E, List, Res, N, C) :-
    C =< N,
    C1 is C + 1,
    repeatElement(E, [E | List], Res, N, C1).

factorialWrapper(N, F) :-
    N1 is floor(N),
    factorial(N1, F).
factorial(0,1) :- !.
factorial(N,F) :-
   N > 0,
   N1 is N - 1,
   factorial(N1, F1),
   F is N * F1.

powerset([], []).
powerset([_ | T], P) :-
    powerset(T, P).
powerset([H | T], [H | P]) :-
    powerset(T, P).
