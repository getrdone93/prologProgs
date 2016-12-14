edge(s, a, 4).
edge(s, b, 2).
edge(a, c, 2).
edge(a, b, 1).
edge(a, d, 4).
edge(c, t, 3).
edge(b, d, 2).
edge(d, t, 3).

%a normalized: [edge(s, a, 4), edge(s, b, 2), edge(c, t, 3), edge(b, d, 2), edge(d, t, 3), edge(a, d, 3), edge(a, b, 0), edge(a, c, 1)]

%edge(Outgoing, Incoming)
 maxflow(NewEdges) :-
    findall(edge(OutNode, InNode, EdgeWeight), edge(OutNode, InNode, EdgeWeight), AllEdges),
    getAllNodes(AllNodes),
    normalizeNodes(AllNodes, AllEdges, NewEdges).

normalizeNodes([], NewEdges, NewEdges) :-
    getAllNodes(AllNodes),
    updateGoodList(NewEdges, AllNodes, NewGoodList),
    subtract(AllNodes, NewGoodList, []),
    !.
% normalizeNodes([], NewEdges, NumNodes, GoodList, NewEdges) :-
%     getAllNodes(AllNodes),
%     subtract(AllNodes, GoodList, NodeList),
%     normalizeNodes(NodeList, NewEdges, NumNodes, GoodList, NewEdges).
% normalizeNodes([Node | NodeList], AllEdges, NumNodes, GoodList, NewEdges) :-
%     isNodeOkay(Node, AllEdges),
%     !,
%     append([Node], GoodList, NewGoodList),
%     normalizeNodes(NodeList, AllEdges, NumNodes, NewGoodList, NewEdges).
normalizeNodes([Node | _], AllEdges, NewEdges) :-
    subtractFromNode(Node, AllEdges, NewEdges),
    getAllNodes(AllNodes),
    updateGoodList(NewEdges, AllNodes, NewGoodList),
    subtract(AllNodes, NewGoodList, NewBadList),
    normalizeNodes(NewBadList, NewEdges, NewEdges).

updateGoodList(AllEdges, GoodList, NewGoodList) :-
     updateGoodList(AllEdges, GoodList, [], NewGoodList).
updateGoodList(_, [], Res, Res).
updateGoodList(AllEdges, [Node | GList], NewGoodList, Res) :-
     isNodeOkay(Node, AllEdges),
     !,
     updateGoodList(AllEdges, GList, [Node | NewGoodList], Res).
updateGoodList(AllEdges, [_ | GList], NewGoodList, Res) :-
     updateGoodList(AllEdges, GList, NewGoodList, Res).

subtractFromNode(Node, AllEdges, NewEdges) :-
     \+ isNodeOkay(Node, AllEdges),
     getNodeFlow(Node, AllEdges, OutFlow, InFlow),
     OutFlow > InFlow,
     !,
     getOutEdgesByNode(Node, AllEdges, [Edge | _]),
     getNewEdgeList(AllEdges, Edge, NewEdges).
subtractFromNode(Node, AllEdges, NewEdges) :-
     \+ isNodeOkay(Node, AllEdges),
     getNodeFlow(Node, AllEdges, OutFlow, InFlow),
     OutFlow < InFlow,
     !,
     getInEdgesByNode(Node, AllEdges, [Edge | _]),
     getNewEdgeList(AllEdges, Edge, NewEdges).
subtractFromNode(_, AllEdges, AllEdges).

getNewEdgeList(AllEdges, Edge, NewEdgeList) :-
     subtractFromEdge(Edge, NewEdge),
     reconstructEdges(AllEdges, NewEdge, NewEdgeList).

reconstructEdges(AllEdges, edge(Snode, Enode, Weight), NewEdges) :-
    nth0(Index, AllEdges, edge(Snode, Enode, _)),
    delete(AllEdges, edge(Snode, Enode, _), TempNewEdges),
    nth0(Index, NewEdges, edge(Snode, Enode, Weight), TempNewEdges),
    !.

subtractFromEdge(edge(Snode, Enode, Weight), edge(Snode, Enode, NewWeight)) :-
    NewWeight is Weight - 1.

checkNodesOkay([Node | AllNodes], AllEdges) :-
    isNodeOkay(Node, AllEdges),
    checkNodesOkay(AllNodes, AllEdges).

getAllNodes(AllNodes) :-
    findall(OutNode, edge(OutNode, _, _), OutNodes),
    findall(InNode, edge(_, InNode, _), InNodes),
    append(OutNodes, InNodes, Temp),
    delete(Temp, s, Temp2),
    delete(Temp2, t, Temp3),
    sort(Temp3, AllNodes).

%Sort this by largest edge
getInEdgesByNode(Node, AllEdges, EdgeList) :-
    getInEdgesByNode(Node, AllEdges, [], RevEdgeList),
    reverse(RevEdgeList, EdgeList).
getInEdgesByNode(_, [], Res, Res) :- !.
getInEdgesByNode(Node, [edge(StartNode, Node, Weight) | AllEdges], EdgeList, Res) :-
    !,
    getInEdgesByNode(Node, AllEdges, [edge(StartNode, Node, Weight) | EdgeList], Res).
getInEdgesByNode(Node, [_ | AllEdges], EdgeList, Res) :-
    getInEdgesByNode(Node, AllEdges, EdgeList, Res).

%Sort this by largest edge
getOutEdgesByNode(Node, AllEdges, EdgeList) :-
    getOutEdgesByNode(Node, AllEdges, [], RevEdgeList),
    reverse(RevEdgeList, EdgeList).
getOutEdgesByNode(_, [], Res, Res) :- !.
getOutEdgesByNode(Node, [edge(Node, EndNode, Weight) | AllEdges], EdgeList, Res) :-
    !,
    getOutEdgesByNode(Node, AllEdges, [edge(Node, EndNode, Weight) | EdgeList], Res).
getOutEdgesByNode(Node, [_ | AllEdges], EdgeList, Res) :-
    getOutEdgesByNode(Node, AllEdges, EdgeList, Res).

isNodeOkay(Node, AllEdges) :-
    getNodeFlow(Node, AllEdges, OutFlow, InFlow),
    OutFlow =:= InFlow.

getNodeFlow(Node, AllEdges, OutFlow, InFlow) :-
    getOutFlow(Node, AllEdges, 0, OutFlow),
    getInFlow(Node, AllEdges, 0, InFlow).

getOutFlow(_, [], OutFlow, OutFlow) :- !.
getOutFlow(Node, [edge(Node, _, Weight) | NodeList], OutFlow, Res) :-
    !,
    TempOutFlow is OutFlow + Weight,
    getOutFlow(Node, NodeList, TempOutFlow, Res).
getOutFlow(Node, [_ | NodeList], OutFlow, Res) :-
    getOutFlow(Node, NodeList, OutFlow, Res).

getInFlow(_, [], InFlow, InFlow) :- !.
getInFlow(Node, [edge(_, Node, Weight) | NodeList], InFlow, Res) :-
    !,
    TempInFlow is InFlow + Weight,
    getInFlow(Node, NodeList, TempInFlow, Res).
getInFlow(Node, [_ | NodeList], InFlow, Res) :-
    getInFlow(Node, NodeList, InFlow, Res).
