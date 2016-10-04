%Determine whether a given integer number is prime
%2.01
is_prime(2).
is_prime(3).
is_prime(P) :-
     integer(P),
     P > 3,
     P mod 2 =\= 0,
     \+ has_factor(P,3).

% has_factor(N,L) :- N has an odd factor F >= L.
%    (integer, integer) (+,+)
has_factor(N,L) :-
     N mod L =:= 0.
has_factor(N,L) :-
     L * L < N,
     L2 is L + 2,
     has_factor(N,L2).

%A list of prime numbers
%2.04
primeNumberList(LB, UB, L) :-
     generateList(LB, UB, L, []).
generateList(UB, UB, Res, Res).
generateList(LB, UB, L, Res) :-
     LB =< UB,
     is_prime(LB),
     LBNew is LB + 1,
     generateList(LBNew, UB, L, [LB | Res]).
generateList(LB, UB, L, Res) :-
     LBNew is LB + 1,
     generateList(LBNew, UB, L, Res).
