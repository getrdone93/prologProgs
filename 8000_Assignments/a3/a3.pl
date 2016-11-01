:- [utility].
%'/home/tanderson/graduateWork/prologProgs/8000_Assignments/a3/session1.txt'
parser(SessionProgram, Tree) :-
    readfile(SessionProgram, TokenList),
    parse(Tree, TokenList, []).





parse(tree(Left, Element, Right)) -->
    expSeq(tree(Left, Element, Right)).
expSeq(tree(Left, Element, Right)) -->
    exp(tree(Left, Element, Right)).

exp(tree(1, 1, 1)) --> [1].

expression( tree(Left, Element, Right) ) -->
    [Left, Element, Right],
    {
        number(Left),
        operator(Element),
        number(Right)
    }.

expression( tree(Left, Element, Right) ) -->
    ['(', Left, Element, Right, ')'],
    {
        number(Left),
        operator(Element),
        number(Right)
    }.

operator(+).
operator(-).
operator(*).
operator(/).


on --> [on | _].
off --> [off].
total --> [total].


test( func(0) ) --> [1].
test( func(1) ) --> [0].


p( palindrome(e) ) --> [].
p( palindrome(0) ) --> [0].
p( palindrome(1) ) --> [1].
p( palindrome(0, T, 0) ) -->
 [0], p( T ), [0].
p( palindrome(1, T, 1) ) -->
    [1], p( T ), [1].

% s --> [].
% s --> [a], s, [b].




% syntaxCheck -->
%
% s --> sa, sb, sc.
% sa --> [].
% sa --> [a], sa.
% sb --> [].
% sb --> [b], sb.
% sc --> [].
% sc --> [c], sc.
%
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
