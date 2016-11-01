
bubbleSort(Lin, Lout) :-
	anyBubble(Lin, Lin1), !,
	bubbleSort(Lin1, Lout).
bubbleSort(L, L).

anyBubble([X,Y | T], [Y,X|T]) :-
	X > Y, !.    % bubble
anyBubble([X | T], [X | T1]) :-
	anyBubble(T, T1).


insertSort([],  []).
insertSort([X | T], L) :-
	insertSort(T, TL),
	insert(X, TL, L).

insert(X, [], [X]).
insert(X, [Y | T], [X, Y | T]) :-
	X =< Y, !.
insert(X, [Y | T], [Y | TL]) :-
	insert(X, T, TL).

quickSort([], []).
quickSort([X | T], SortedL) :-
	divide(X, T, Small, Big),
	quickSort(Small, SSorted),
	quickSort(Big, BigSorted),
	append(SSorted, [X | BigSorted], SortedL).

divide(_, [], [], []).
divide(X, [Y | T], [Y | Small], Big) :-
	Y < X, !,
	divide(X, T, Small, Big).
divide(X, [Y | T], [Y | Small], Big) :-
	Y =:= X,
	random(V),
	V > 0.5, !,
	divide(X, T, Small, Big).
divide(X, [Y | T], Small, [Y | Big]) :-
	divide(X, T, Small, Big).


bTree(void).
bTree( tree(Left, _E, Right) ) :-
	bTree(Left),
	bTree(Right).

tree_member(E, tree(Left, E, Right)) :-
	bTree(Left),
	bTree(Right).
tree_member(E, tree(Left, _, _Right)) :-
	tree_member(E, Left).
tree_member(E, tree(_Left, _, Right)) :-
	tree_member(E, Right).

% substitute(X, Y, OldT, NewT)
substitute(X, X, T, T).
substitute(_X, _Y, void, void).
substitute(X, Y, tree(Left, X, Right), tree(Left1, Y, Right1)) :- !,
	substitute(X, Y, Left, Left1),
	substitute(X, Y, Right, Right1).
substitute(X, Y, tree(Left, Z, Right), tree(Left1, Z, Right1)) :-
	substitute(X, Y, Left, Left1),
	substitute(X, Y, Right, Right1).

preorder(void).
preorder(tree(Left, E, Right)) :-
	writeln(E),
	preorder(Left),
	preorder(Right).

inorder(void).
inorder(tree(Left, E, Right)) :-
	inorder(Left),
	writeln(E),
	inorder(Right).















