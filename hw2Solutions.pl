
% homework 2
% question 1: totalCrossOver

totalCO2(L, N) :- totalCO(L, 0, N).

totalCO([], N, N).
totalCO([H1,H2|T], Nin, Nout) :-
        crossover(H1,H2), !,
        N1 is Nin + 1,
        totalCO([H2|T], N1, Nout).
totalCO([_|T], Nin, Nout) :-
        totalCO(T, Nin, Nout).

totalCrossOver([], 0).
totalCrossOver([_], 0).
totalCrossOver([H1,H2|T], N) :-
        crossover(H1,H2), !,
        totalCrossOver([H2|T], N1),
        N is N1 + 1.
totalCrossOver([_,H2|T], N) :-
        totalCrossOver([H2|T], N).

crossover(X, Y) :-
        X * Y < 0.

% question 2
% longestSubList(NumList, CList)

longestSubList([], []).
longestSubList([H|T], CL) :-
        findCOS([H|T], CL1, Tail),
        longestSubList(Tail, CL2),
        greater(CL1, CL2, CL).

findCOS([H1,H2|T], [H1 | Cos], Tail) :-
        crossover(H1,H2), !,
        findCOS([H2|T], Cos, Tail).
findCOS([H|Tail], [H], Tail).

greater(L1, L2, L) :-
        length(L1, N1),
        length(L2, N2),
        ( N1 < N2
             ->  L = L2
             ;  (N1 > N2
                    ->  L = L1
                    ;  member(L, [L1, L2])
                )
        ).


% question 3

flatten(T, [T]) :-
        var(T), !.
flatten([], []) :-!.
flatten([H|T], L) :- !,
        flatten(H, HL),
        flatten(T, TL),
        append(HL, TL, L).
flatten(T, L) :-
        compound(T), !,
        T =.. TL,
        flatten(TL, L).
flatten(A, [A]).

% question 4

findAges(AnimalList, AgeList, AgePairs) :-
        permutation(AgeList, AL),
        pairup(AnimalList, AL, AgePairs),
        check(AgePairs).

pairup([], [], []).
pairup([H1|T1], [H2|T2], [(H1,H2)|T]) :-
        pairup(T1,T2,T).

check(PairList) :-
        getAge(otter, OA, PairList),
        getAge(leopard, LA, PairList),
        getAge(emu, EA, PairList),
        getAge(hippo, HA, PairList),
        getAge(lion, IA, PairList),
        OA > LA,
        EA < OA,
        LA > HA,
        HA > EA,
        HA > IA,
        IA > EA.

getAge(Animal, Age, PairList) :-
        member((Animal, Age), PairList).

% question 5

allConnected(EdgeList) :-
        allNodes(EdgeList, [FN|TNL]),
        mark(TNL, [FN], EdgeList).

mark([], _, _) :- !.
mark(TNL, CNL, EdgeList) :-
        member(N, TNL),
        connected(N, N1, EdgeList),
        member(N1, CNL), !,
        remove(N, TNL, TNL1),
        mark(TNL1, [N | CNL], EdgeList).

remove(N, [N|L], L) :- !.
remove(N, [H|L], [H|L1]) :-
        remove(N, L, L1).


allNodes(EdgeList, L) :-
        setof(N, N1^connected(N, N1, EdgeList), L), !.

connected(X, Y, EdgeList) :-
        member(edge(X, Y), EdgeList).
connected(X, Y, EdgeList) :-
        member(edge(Y, X), EdgeList).

edgeList([edge(a,e), edge(b,e), edge(e,f), edge(f,d), edge(f,c)]).


% unify(T1, T2)

unify(T1, T2) :-
        var(T1), var(T2), !, T1 = T2.
unify(T1, T2) :-
        var(T1), !,
        \+ occurCheck(T1, T2), !,
        T1 = T2.
unify(T1, T2) :-
        var(T2), !,
        unify(T2, T1).
unify(T1, T2) :-
        atomic(T1), !,
        T1 = T2.
unify(T1, T2) :-
        atomic(T2), !,
        T1 = T2.
unify(T1, T2) :-
        T1 =.. L1,
        T2 =.. L2,
        unifyEach(L1, L2).

unifyEach([], []).
unifyEach([H1|T1], [H2|T2]) :-
        unify(H1, H2),
        unifyEach(T1, T2).

occurCheck(X, T) :-
     var(T), !, X == T.
occurCheck(_, T) :-
    atomic(T), !, fail.
occurCheck(X, T) :-
    T =.. [_|Args],
    anyOccurCheck(X, Args).
anyOccurCheck(X, [H|_T]) :-
    occurCheck(X, H), !.
anyOccurCheck(X, [_|T]) :-
    anyOccurCheck(X, T).
