
s(L) :- append(L4, L3, L),
	append(L1, L2, L4),
	sa(L1), sb(L2), sc(L3).
sa([]).
sa([a | L]) :- sa(L).
sb([]).
sb([b | L]) :- sb(L).
sc([]).
sc([c | L]) :- sc(L).

s1(L1, L2) :- sa1(L1, L3),
	     sb1(L3, L4),
	     sc1(L4, L2).
sa1(L, L).
sa1(L1, L2) :- L1 = [a | L3], sa1(L3, L2).
sb1(L, L).
sb1(L1, L2) :- L1 = [b | L3], sb1(L3, L2).
sc1(L, L).
sc1(L1, L2) :- L1 = [c | L3], sc1(L3, L2).

sRecognizer(L) :-
	s2(L, []).

s2 --> sa2, sb2, sc2.
sa2 --> [].
sa2 --> [a], sa2.
sb2 --> [].
sb2 --> [b], sb2.
sc2 --> [].
sc2 --> [c], sc2.

% P -> e
% P -> 1
% P -> 0
% P -> 0 P 0
% P -> 1 P 1

p --> [].
p --> [1].
p --> [0].
p --> [0], p, [0].
p --> [1], p, [1].


s --> as(N), bs(N).
as(0) --> [].
as(N1) --> [a], as(N),
	   { N1 is N + 1 }.
bs(0) --> [].
bs(N1) --> {N is N1 - 1},
	[b], bs(N).

pparser(L, Tree) :-
	p(Tree, L, []).

p( palindrome(e) ) --> [].
p( palindrome(0) ) --> [0].
p( palindrome(1) ) --> [1].
p( palindrome(0, T, 0) ) --> [0], p( T ), [0].
p( palindrome(1, T, 1) ) --> [1], p( T ), [1].

