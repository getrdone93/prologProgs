

/* e.g., str2list('abc', L) returns L = [a, b, c]
         str2list(abc, L) returns L = [a, b, c]
         str2list(2435, L) returns L = [2,4,3,5]
*/
str2list(Str, List) :-
     name(Str, L),
     listAscii2Char(L, List).
     
listAscii2Char([], []).
listAscii2Char([A|T1], [C|T2]) :-
     ascii2char(A, C),
     listAscii2Char(T1, T2).
     
ascii2char(A, C) :-
     name(C, [A]).
     
     
/* e.g., exp2list('23+56*3', L) returns L = [23, +, 56, *, 3]
*/
exp2list(Exp, List) :-
    str2list(Exp, CharList),
    expTokenizer(CharList, List).
    
expTokenizer([], []).
expTokenizer([' ' | L1], L2) :- !,
        expTokenizer(L1, L2).
expTokenizer([C | L1], [ C | L2 ]) :-
        member(C, ['+', '*', '/', '-', '^', '(', ')']), !,
        expTokenizer(L1, L2).
expTokenizer([C | L1], [N | L2]) :-
        isDigitChar(C), !,
        char2Digit(C, D),
        scannerInt(D, L1, N, L3),
        expTokenizer(L3, L2).
expTokenizer([C|_], _) :-
        write('Warning: unrecognized keyword '),
        write(C),
        writeln(' in session!').

     
     

/* File is a file name, e.g., 'session1.txt'
   L will return a list of tokens.
*/
readfile(File, L) :-
        see(File),
        readfile1([], L1),
        seen,
        reverse(L1, [], L2),
        scanner(L2, L).

readfile1(In, Out) :-
        get_char(N),
        ( N = end_of_file
                -> In = Out
                 ; readfile2(N, In, Out)
        ).

readfile2('\t', In, Out) :- !,
        readfile2(' ', In, Out).
readfile2('\n', In, Out) :- !,
        readfile2(' ', In, Out).
readfile2(C, In, Out)
        :- readfile1([C | In], Out).

reverse([], L, L).
reverse([F | R], L1, L) :-
        reverse(R, [F | L1], L).

scanner([], []).

% all the key words
scanner([o,n | L1], [ on | L2 ]) :- !,
        scanner(L1, L2).
scanner([o,f,f | L1], [ off | L2 ]) :- !,
        scanner(L1, L2).
scanner([t, o, t, a, l | L1], [ total | L2 ]) :- !,
        scanner(L1, L2).
scanner([l,a,s,t,a,n,s,w,e,r | L1], [ lastanswer | L2 ]) :- !,
        scanner(L1, L2).
scanner([' ' | L1], L2) :- !,
        scanner(L1, L2).
scanner([i,f | L1], [ if | L2 ]) :- !,
        scanner(L1, L2).
scanner([C | L1], [ C | L2 ]) :-
        member(C, ['+', '*', ',', '(', ')']), !,
        scanner(L1, L2).
scanner([C | L1], [N | L2]) :-
        isDigitChar(C), !,
        char2Digit(C, D),
        scannerInt(D, L1, N, L3),
        scanner(L3, L2).
scanner([C|_], _) :-
        write('Warning: unrecognized keyword '),
        write(C),
        writeln(' in session!').
        

isDigitChar(C) :-
        member(C, ['0','1','2','3','4','5','6','7','8','9']), !.
isDigitChar(C) :-
        member(C, [0,1,2,3,4,5,6,7,8,9]).

% scannerInt(Nin, Lin, Nout, Lout) :-
scannerInt(Nin, [C | Lin], Nout, Lout) :-
        isDigitChar(C), !,
        char2Digit(C, D),
        Nin1 is Nin * 10 + D,
        scannerInt(Nin1, Lin, Nout, Lout).
scannerInt(N, L, N, L).

char2Digit(C, D) :-
        name(C, [A]),
        name(D, [A]).



