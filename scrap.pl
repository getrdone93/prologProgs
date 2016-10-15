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
