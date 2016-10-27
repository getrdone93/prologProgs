:- [utility].
%'/home/tanderson/graduateWork/prologProgs/8000_Assignments/a3/session1.txt'
parser(SessionProgram, Tree) :-
    readfile(SessionProgram, TokenList),
    syntaxCheck(TokenList, []),
    parse(TokenList, Tree).






% p( palindrome(e) ) --> [].
% p( palindrome(0) ) --> [0].
% p( palindrome(1) ) --> [1].
% p( palindrome(0, T, 0) ) -->
%  [0], p( T ), [0].
% p( palindrome(1, T, 1) ) --> [1], p( T ), [1].

% s --> [].
% s --> [a], s, [b].

p --> [].
p --> [0].
p --> [1].
p --> [0], p, [0].
p --> [1], p, [1].

p2([], []).
p2(L1, L2) :-
    L1 = [1 | L3],
    p2(L3, L2).


% syntaxCheck -->
%
% s --> sa, sb, sc.
% sa --> [].
% sa --> [a], sa.
% sb --> [].
% sb --> [b], sb.
% sc --> [].
% sc --> [c], sc.

% s(L1, L2) :- sa(L1, L3),
% 	     sb(L3, L4),
% 	     sc(L4, L2).
% sa(L, L).
% sa(L1, L2) :-
%     L1 = [a | L3],
%     sa(L3, L2).
% sb(L, L).
% sb(L1, L2) :-
%     L1 = [b | L3],
%     sb(L3, L2).
% sc(L, L).
% sc(L1, L2) :-
%     L1 = [c | L3],
%     sc(L3, L2).
