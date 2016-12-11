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

%must permute four list when n >= 2     permutation(FourList, PermFourList),

equationBuilder(Answer, 1) :-
    fourPicker(FourList, 1),
    buildEquationOneFour(FourList, Answer).
buildEquationOneFour([Four], Answer) :-
    findall(Operation, unary(u(Operation)), UnaryOps),
    execute(Four, UnaryOps, AnswerList).

execute(Four, UnaryOps, AnswerList) :-
    execute(Four, UnaryOps, [], AnswerList).
execute(_, _, AnswerList, AnswerList).
execute(Four, [+ | UnaryOps], AnswerList, Res) :-
    Answer is 0 + Four,
    execute(Four, UnaryOps, [Answer | AnswerList], Res).
execute(Four, [- | UnaryOps], AnswerList, Res) :-
    Answer is 0 - Four,
    execute(Four, UnaryOps, [Answer | AnswerList], Res).
execute(Four, [sqrt | UnaryOps], AnswerList, Res) :-
    Answer is sqrt(Four),
    execute(Four, UnaryOps, [Answer | AnswerList], Res).
execute(Four, [! | UnaryOps], AnswerList, Res) :-
    factorial(Four, Answer),
    execute(Four, UnaryOps, [Answer | AnswerList], Res).
execute(Four, [square | UnaryOps], AnswerList, Res) :-
    Answer is Four ** 2,
    execute(Four, UnaryOps, [Answer | AnswerList], Res).

fourPicker(FourList, N) :-
    findall(pick(Four, Count), pick(Four, Count), AllFours),
    fourPicker(FourList, AllFours, N).
fourPicker(FourList, AllFours, N) :-
    powerset(AllFours, FourList),
    length(FourList, Len),
    Len =:= N.


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
