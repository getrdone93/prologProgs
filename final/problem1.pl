edge(d, a).
edge(d, b).
edge(d, c).
edge(d, e).
edge(a, x).

% vertexCover. :-
%     getAllNodes(AllNodes).
getGraph(Graph) :-
    findall(edge(X, Y), edge(X, Y), Graph).

getAllNodes(AllNodes) :-
    findall(X, edge(X, Y), Xs),
    findall(Y, edge(X, Y), Ys),
    append(Xs, Ys, TempAllNodes),
    sort(TempAllNodes, AllNodes).
