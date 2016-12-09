edge(d, a).
edge(d, b).
edge(d, c).
edge(d, e).
edge(a, x).

vertexCover(K, Vertices) :-
    vertexCover(K, 1, Vertices).
vertexCover(K, N, Vertices) :-
    N =< K,
    getAllNodes(AllNodes),
    getNodeList(AllNodes, NodeList, N),
    getGraph(EdgeList),
    cover(NodeList, EdgeList, Vertices).
vertexCover(K, N, Vertices) :-
    N1 is N + 1,
    vertexCover(K, N1, Vertices).
cover(NodeList, EdgeList, Vertices) :-
    getCoveredEdges(NodeList, EdgeList, Vertices),
    subtract(EdgeList, Vertices, []).
getCoveredEdges(NodeList, EdgeList, CoveredEdges) :-
    getCoveredEdges(NodeList, EdgeList, CoveredEdges, []).
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
getNodeList(AllNodes, NodeList, N) :-
    getNodeList(AllNodes, NodeList, [], N, 0).
getNodeList(_, NodeList, NodeList, N, N).
getNodeList([Node | AllNodes], [Node | NodeList], Res, N, C) :-
    C1 is C + 1,
    getNodeList(AllNodes, NodeList, Res, N, C1).

getGraph(Graph) :-
    findall(edge(X, Y), edge(X, Y), Graph).
getAllNodes(AllNodes) :-
    findall(X, edge(X, Y), Xs),
    findall(Y, edge(X, Y), Ys),
    append(Xs, Ys, TempAllNodes),
    sort(TempAllNodes, AllNodes).
