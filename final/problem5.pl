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


validFourList(FourList) :-
    validFourList(FourList, 0).
validFourList([], 4).
validFourList([pick(_, C) | List], Count) :-
    TempCount is Count + C,
    validFourList(List, TempCount).
