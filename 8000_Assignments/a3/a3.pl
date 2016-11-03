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
    },
    !.

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
