getDomainForRegion(RelationList, H, AdjacentRegions),
adjacentRegions(H, AdjacentRegions),

getDomainForRegion(RelationList, Region, DomainList) :-
getDomainForRegion(RelationList, Region, DomainList, []).
getDomainForRegion([], _, L, L).
getDomainForRegion([(R1, R2) | TRelation], R1, Res, DomainList) :-
getDomainForRegion(TRelation, R1, Res, [R2 | DomainList]).
getDomainForRegion([_ | TRelation], R1, Res, DomainList) :-
getDomainForRegion(TRelation, R1, Res, DomainList).
%

generateValidMoves(_, [], []).
generateValidMoves(State, [H | AllStates], [H | ValidMoves]) :-
    validMove(State, H),
    generateValidMoves(State, AllStates, ValidMoves).
generateValidMoves(State, [_ | AllStates], ValidMoves) :-
    generateValidMoves(State, AllStates, ValidMoves).

    loopThrough([]).
    loopThrough([H | T]) :-
        display(H),
        nl,
        loopThrough(T).
%[H | ArgList] = TempList,
% reverseList(ArgList, RevArgList)
%
% revArgs(ArgList, RevTerm).
% revArgs([H | T], Term, L) :-
% revArgs(H, Term, HL),
% revArgs(T, Term, TL).
% revArgs([H | _], Term, L) :-
%     compound(H),
%     !,
%     H =.. ArgList,
%     revArgs(ArgList, Term, L).
% revArgs([H | _], Term, L) :-


p --> [].
p --> [0].
p --> [1].
p --> [0], p, [0].
p --> [1], p, [1].

p2([], []).
p2(L1, L2) :-
    L1 = [0 | L3],
    matchLast0(L3, TempL),
    p2(TempL, L2).
p2(L1, L2) :-
    L1 = [1 | L3],
    matchLast1(L3, TempL),
    p2(TempL, L2).

matchLast0(L, L1) :-
    matchLast0(L, [], L1).
matchLast0([1], L, L).
matchLast0([H | T], L, Res) :-
    matchLast0(T, [H | L], Res).

matchLast0(L, L1) :-
    matchLast0(L, [], L1).
matchLast0([0], L, L).
matchLast0([H | T], L, Res) :-
    matchLast0(T, [H | L], Res).


netChange(X, Y, Z) :-
    X >= Y,
    Z is X - Y,
    !.
netChange(X, Y, Z) :-
    X < Y,
    Z is Y - X.

getM(State, M) :-
    arg(1, State, M).
getC(State, C) :-
    arg(2, State, C).
getB(State, B) :-
    arg(3, State, B).

    reverseArgs([H | T], RevTerm) :-
        \+ containCompound([H | T]),
        reverseList(T, RevT),
        RevTerm =.. [H | RevT].
    reverseArgs(Term, RevTerm) :-
        \+ Term = [_ | _],
        Term =.. [H | T], %passed a functor
        reverseArgs([H | T], RevTerm).
    reverseArgs([H | T], RevTerm) :- %passed a list
        reverseArgs(H, HeadTerm),
        reverseArgs(T, TailTerm),
        append([TailTerm], [HeadTerm], RevList),
        RevTerm =.. RevList.

    %
    % reverseArgs(Term, RevTerm) :-
    %     [H | T] = Term,
    %     reverseArgs(H, HL),
    %     reverseArgs(T, TL).
    % reverseArgs(Term, RevTerm) :-
    %     Term =.. [H | T],
    %     reverseArgs(H, HL),
    %     reverseArgs(T, TL).



    reverseArgs(Term, RevTerm) :-
        \+ Term = [_ | _],
        Term =.. [H | T], %passed a functor
        reverseFunctor(H, HeadTerm),
        reverseFunctor(T, TailTerm),
        append([TailTerm], [HeadTerm], RevList),
        RevTerm =.. RevList.
    reverseArgs([H | T], RevTerm) :- %passed a list
        reverseL(H, HeadTerm),
        reverseL(T, TailTerm),
        append([TailTerm], [HeadTerm], RevList),
        RevTerm =.. RevList.


        % reverseL([H | T], RevTerm) %reverse a list
        %     \+ containCompound([H | T]),
        %      reverseList([H | T], RevT),
        %      RevTerm =.. RevT.
        % reverseL([H | T], RevTerm) :-
        %     reverseArgs([H | T], RevTerm).

        reverseFunctor([H | T], RevTerm) :-
            % \+ containCompound(T),
            reverseList(T, RevT),
            RevTerm =.. [H | RevT].
        % reverseFunctor([H | T], RevTerm) :-
        %     NewTerm =.. T,
        %     revArgs(NewTerm, RevTerm).


        reverseArgs(Term, RevTerm) :-
            revArgs(Term, RevTerm, []).
        revArgs([], RevTerm, RevTerm).
        revArgs(Term, RevTerm, L) :-
            \+ Term = [_ | _],
            Term =.. [H | T],
            reverseFunctor([H | T], TempTerm),
            revArgs(T, RevTerm, [TempTerm | L]).

        % revArgs(Term, RevTerm, L) :-
        %     reverseL(Term, RevTerm).


        generateAllStates([state(0, 0, right) | AllStates], [state(0, 0, right) | AllStates]).
        generateAllStates(State, [State | AllStates]) :-
            getM(State, CurrM),
            getC(State, CurrC),
            getB(State, CurrB),
            NewM is CurrM - 1,
            buildNewState(NewM, CurrC, CurrB, NewState),
            generateAllStates(NewState, AllStates).


            validState(M, C) :-
                validMAndC(M, C),
                M =:= 0,
                !.
            vvalidState(M, C) :-
                validMAndC(M, C),
                M =:= 3,
                !.vldRightToLeft(RightM, RightC, right, NewRightM, NewRightC, left) :-
    netChange(RightM, NewRightM, NetM),
    netChange(RightC, NewRightC, NetC),
    RightM =:= 0,
    NetC >= 1,
    NetC =< 2,
    !.
vldRightToLeft(RightM, RightC, right, NewRightM, NewRightC, left) :-
    netChange(RightM, NewRightM, NetM),
    netChange(RightC, NewRightC, NetC),
    RightC =:= 0,
    NetM >= 1,
    NetM =< 2,
    !.
vldRightToLeft(RightM, RightC, right, NewRightM, NewRightC, left) :-
    netChange(RightM, NewRightM, NetM),
    netChange(RightC, NewRightC, NetC),
    NetM =:= 1,
    NetC >= 0,
    NetC =< 1,
    !.
vldRightToLeft(RightM, RightC, right, NewRightM, NewRightC, left) :-
    netChange(RightM, NewRightM, NetM),
    netChange(RightC, NewRightC, NetC),
    NetC =:= 1,
    NetM >= 0,
    NetM =< 1.

vldLeftToRight(LeftM, LeftC, left, NewLeftM, NewLeftC, right) :-
    netChange(LeftM, NewLeftM, NetM),
    netChange(LeftC, NewLeftC, NetC),
    LeftM =:= 0,
    NetC >= 1,
    NetC =< 2,
    !.
vldLeftToRight(LeftM, LeftC, left, NewLeftM, NewLeftC, right) :-
    netChange(LeftM, NewLeftM, NetM),
    netChange(LeftC, NewLeftC, NetC),
    LeftC =:= 0,
    NetM >= 1,
    NetM =< 2,
    !.
vldLeftToRight(LeftM, LeftC, left, NewLeftM, NewLeftC, right) :-
    netChange(LeftM, NewLeftM, NetM),
    netChange(LeftC, NewLeftC, NetC),
    NetM =:= 1,
    NetC >= 0,
    NetC =< 1,
    !.
vldLeftToRight(LeftM, LeftC, left, NewLeftM, NewLeftC, right) :-
    netChange(LeftM, NewLeftM, NetM),
    netChange(LeftC, NewLeftC, NetC),
    NetC =:= 1,
    NetM >= 0,
    NetM =< 1.
            validState(M, C) :-
                validMAndC(M, C),
                MRight is 3 - M,
                CRight is 3 - C,
                MRight >= CRight,
                M >= C.
            validMAndC(M, C) :-
                M >= 0,
                M =< 3,
                C >= 0,
                C =< 3.


                validState(State) :-
                    getAllStates(AllStates),
                    validSt(State, AllStates).
                validSt(State, [State | _]) :- !.
                validSt(State, [_ | T]) :-
                    validSt(State, T).


                    sc([CurrentState | PriorStates], [CurrentState | PriorStates]) :-
                        !,
                        getAllStates(AllStates),
                        diffList(AllStates, [CurrentState | PriorStates], UnmarkedStates),
                        generateValidMoves(CurrentState, UnmarkedStates, NextStates),
                        sc(NextStates, PriorStates).



                        validMove(State, NewState) :-
                            getM(State, LeftM),
                            getC(State, LeftC),
                            getB(State, CurrB),
                            getM(NewState, NewLeftM),
                            getC(NewState, NewLeftC),
                            getB(NewState, NewB),
                            ChangeM is LeftM - NewLeftM,
                            ChangeC is LeftC - NewLeftC,
                            vldLeftToRight(LeftM, LeftC, CurrB, ChangeM, ChangeC, NewB),
                            !.
                        validMove(State, NewState) :-
                            getM(State, LeftM),
                            getC(State, LeftC),
                            getB(State, CurrB),
                            getM(NewState, NewLeftM),
                            getC(NewState, NewLeftC),
                            getB(NewState, NewB),
                            RightM is 3 - LeftM,
                            RightC is 3 - LeftC,
                            NewRightM is 3 - NewLeftM,
                            NewRightC is 3 - NewLeftC,
                            ChangeM is RightM - NewRightM,
                            ChangeC is RightC - NewRightC,
                            vldRightToLeft(RightM, RightC, CurrB, ChangeM, ChangeC, NewB).


                            vldRightToLeft(RightM, RightC, right, NewRightM, NewRightC, left) :-
                                netChange(RightM, NewRightM, NetM),
                                netChange(RightC, NewRightC, NetC),
                                RightM =:= 0,
                                NetC >= 1,
                                NetC =< 2,
                                !.
                            vldRightToLeft(RightM, RightC, right, NewRightM, NewRightC, left) :-
                                netChange(RightM, NewRightM, NetM),
                                netChange(RightC, NewRightC, NetC),
                                RightC =:= 0,
                                NetM >= 1,
                                NetM =< 2,
                                !.
                            vldRightToLeft(RightM, RightC, right, NewRightM, NewRightC, left) :-
                                netChange(RightM, NewRightM, NetM),
                                netChange(RightC, NewRightC, NetC),
                                NetM =:= 1,
                                NetC >= 0,
                                NetC =< 1,
                                !.
                            vldRightToLeft(RightM, RightC, right, NewRightM, NewRightC, left) :-
                                netChange(RightM, NewRightM, NetM),
                                netChange(RightC, NewRightC, NetC),
                                NetC =:= 1,
                                NetM >= 0,
                                NetM =< 1.

                            vldLeftToRight(LeftM, LeftC, left, NewLeftM, NewLeftC, right) :-
                                netChange(LeftM, NewLeftM, NetM),
                                netChange(LeftC, NewLeftC, NetC),
                                LeftM =:= 0,
                                NetC >= 1,
                                NetC =< 2,
                                !.
                            vldLeftToRight(LeftM, LeftC, left, NewLeftM, NewLeftC, right) :-
                                netChange(LeftM, NewLeftM, NetM),
                                netChange(LeftC, NewLeftC, NetC),
                                LeftC =:= 0,
                                NetM >= 1,
                                NetM =< 2,
                                !.
                            vldLeftToRight(LeftM, LeftC, left, NewLeftM, NewLeftC, right) :-
                                netChange(LeftM, NewLeftM, NetM),
                                netChange(LeftC, NewLeftC, NetC),
                                NetM =:= 1,
                                NetC >= 0,
                                NetC =< 1,
                                !.
                            vldLeftToRight(LeftM, LeftC, left, NewLeftM, NewLeftC, right) :-
                                netChange(LeftM, NewLeftM, NetM),
                                netChange(LeftC, NewLeftC, NetC),
                                NetC =:= 1,
                                NetM >= 0,
                                NetM =< 1.


                                vldLeftToRight(LeftM, LeftC, left, NetM, NetC, right) :-
                                    NetChange is NetM + NetC,
                                    (LeftM =:= 0, LeftC \= 0, NetC >= 1, NetC =< 2 -> true
                                    ; (LeftC =:= 0, LeftM \= 0, NetM >= 1, NetM =< 2 -> true
                                    ; (LeftM > 0, LeftC > 0, NetChange >= 1, NetChange =< 2 -> true))).





                                    vldLeftToRight(LeftM, LeftC, left, ChangeM, ChangeC, right) :-
                                        NetChange is ChangeM + ChangeC,
                                        (LeftM =:= 0, LeftC \= 0, ChangeC >= 1, ChangeC =< 2 -> true
                                        ; (LeftC =:= 0, LeftM \= 0, ChangeM >= 1, ChangeM =< 2 -> true
                                        ; (LeftM > 0, LeftC > 0, NetChange >= 1, NetChange =< 2 -> true))).

                                    vldRightToLeft(RightM, RightC, right, ChangeM, ChangeC, left) :-
                                        NetChange is ChangeM + ChangeC,
                                        (RightM =:= 0, RightC \= 0, ChangeC >= 1, ChangeC =< 2 -> true
                                        ; (RightC =:= 0, RightM \= 0, ChangeM >= 1, ChangeM =< 2 -> true
                                        ; (RightM > 0, RightC > 0, NetChange >= 1, NetChange =< 2 -> true))).
