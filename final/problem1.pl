edge(d, a).
edge(d, b).
edge(d, c).
edge(d, e).
edge(a, x).

vertexCover(K, Vertices) :-
    findall(TempVertices, vertexCover(K, 1, TempVertices), Res),
    [FirstList | _] = Res,
    length(FirstList, FLen),
    Diff is K - FLen,
    member(Vertices, Res),
    length(Vertices, VertLen),
    CurrentListDiff is K - VertLen,
    CurrentListDiff =:= Diff.

vertexCover(K, N, Vertices) :-
    N =< K,
    getAllNodes(AllNodes),
    getGraph(EdgeList),
    getNodeList(AllNodes, N, Vertices),
    cover(Vertices, EdgeList).
vertexCover(K, N, Vertices) :-
    N1 is N + 1,
    N1 =< K,
    vertexCover(K, N1, Vertices).

cover(NodeList, EdgeList) :-
    getCoveredEdges(NodeList, EdgeList, TempCoveredEdges),
    sort(TempCoveredEdges, CoveredEdges),
    subtract(EdgeList, CoveredEdges, []).

getCoveredEdges(NodeList, EdgeList, CoveredEdges) :-
    getCoveredEdges(NodeList, EdgeList, [], CoveredEdges).
getCoveredEdges([], _, CoveredEdges, CoveredEdges).
getCoveredEdges([Node | NodeList], EdgeList, CoveredEdges, Res) :-
    getEdges(Node, EdgeList, CoveredEdgesByNode),
    append(CoveredEdges, CoveredEdgesByNode, TempCoveredEdges),
    getCoveredEdges(NodeList, EdgeList, TempCoveredEdges, Res).

getEdges(Node, EdgeList, CoveredEdgesByNode) :-
    getEdges(Node, EdgeList, CoveredEdgesByNode, []).
getEdges(_, [], Res, Res).
getEdges(Node, [edge(Node, Y) | T], [edge(Node, Y) | Res], Result) :-
    getEdges(Node, T, Res, Result),
    !.
getEdges(Node, [edge(X, Node) | T], [edge(X, Node) | Res], Result) :-
    getEdges(Node, T, Res, Result),
    !.
getEdges(Node, [_ | T], Res, Result) :-
    getEdges(Node, T, Res, Result).

getGraph(Graph) :-
    findall(edge(X, Y), edge(X, Y), Graph).

getAllNodes(AllNodes) :-
    findall(X, edge(X, Y), Xs),
    findall(Y, edge(X, Y), Ys),
    append(Xs, Ys, TempAllNodes),
    sort(TempAllNodes, AllNodes).

getNodeList(AllNodes, N, NodeList) :-
    powerset(AllNodes, NodeList),
    length(NodeList, Len),
    Len =:= N.

powerset([], []).
powerset([_ | T], P) :-
    powerset(T, P).
powerset([H | T], [H | P]) :-
    powerset(T, P).
