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
