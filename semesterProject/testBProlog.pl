% membchk(X,[X|_]) => true.
% membchk(X,[_|Ys]) => membchk(X,Ys).

memberCheck(X,Ys):-
    $internal_match([Y|_],Ys),
    X==Y,
    !.
memberCheck(X,Ys):-
    $internal_match([_|Ys1],Ys),
    memberCheck(X,Ys1).

% append([],Ys,Zs) => Zs=Xs.
% append([X|Xs],Ys,Zs) => Zs=[X|Zs1],append(Xs,Ys,Zs1).
