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

equationBuilder(Equation, N) :-
    N =:= 1,
    fourPicker(FourList, N),
    buildEquation(FourList, Equation).
buildEquation(FourList, Equation) :-
    //

fourPicker(FourList, N) :-
    findall(pick(Four, Count), pick(Four, Count), AllFours),
    fourPicker(FourList, AllFours, N).
fourPicker(FourList, AllFours, N) :-
    powerset(AllFours, FourList),
    length(FourList, Len),
    Len =:= N.

powerset([], []).
powerset([_ | T], P) :-
    powerset(T, P).
powerset([H | T], [H | P]) :-
    powerset(T, P).
