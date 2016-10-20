% [H | ArgList] = TempList,
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



                        buildNewState(M, C, B, NewState) :-
                            NewState =.. [state, M, C, B].


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
