%Determine whether a given integer number is prime
%2.01
is_prime(2) :- !.
is_prime(N) :-
     UB is div(N, 2),
     checkPrime(N, UB, 3).
checkPrime(_, N, N) :- !.
checkPrime(N, UB, Inc) :-
     mod(N, Inc) =\= 0,
     IncNew is Inc + 1,
     checkPrime(N, UB, IncNew).
