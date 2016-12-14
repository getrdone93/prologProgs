edge(s, a, 4).
edge(s, b, 2).
edge(a, c, 2).
edge(a, b, 1).
edge(a, d, 4).
edge(c, t, 3).
edge(b, d, 2).
edge(d, t, 3).

%[edge(s,a,4),edge(s,b,1),edge(a,c,2),edge(a,b,1),edge(a,d,1),edge(c,t,2),edge(b,d,2),edge(d,t,3)]
%edge(Outgoing, Incoming)
 maxflow(NewEdges) :-
    findall(edge(OutNode, InNode, EdgeWeight), edge(OutNode, InNode, EdgeWeight), AllEdges),
    getAllNodes(AllNodes),
    normalizeNodes(AllNodes, AllEdges, NewEdges).

normalizeNodes([], NewEdges, NewEdges) :-
    getAllNodesWithoutSAndT(AllNodes),
    updateGoodList(NewEdges, AllNodes, NewGoodList),
    subtract(AllNodes, NewGoodList, []),
    !.
normalizeNodes([Node | _], AllEdges, _) :-
    subtractFromNode(Node, AllEdges, NewEdges),
    getAllNodes(AllNodes),
    updateGoodList(NewEdges, AllNodes, NewGoodList),
    getAllNodesWithoutSAndT(CheckNodes),
    subtract(CheckNodes, NewGoodList, NewBadList),
    normalizeNodes(NewBadList, NewEdges, _).

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
     getOutEdgesByNode(Node, AllEdges, Edge),
     getNewEdgeList(AllEdges, Edge, NewEdges).
subtractFromNode(Node, AllEdges, NewEdges) :-
     \+ isNodeOkay(Node, AllEdges),
     getNodeFlow(Node, AllEdges, OutFlow, InFlow),
     OutFlow < InFlow,
     !,
     getInEdgesByNode(Node, AllEdges, Edge),
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
    sort(Temp, AllNodes).

getAllNodesWithoutSAndT(AllNodes) :-
    getAllNodes(TempAll),
    delete(TempAll, s, TempAll2),
    delete(TempAll2, t, AllNodes).

getNumList(EdgeList, NumList) :-
    getNumList(EdgeList, [], NumList).
getNumList([], Res, Res).
getNumList([edge(_, _, Weight) | T], NumList, Res) :-
    getNumList(T, [Weight | NumList], Res).

getMaxEdge(EdgeList, Edge) :-
    getNumList(EdgeList, NumList),
    max_member(Max, NumList),
    getMax(EdgeList, Max, Edge).

getMax([edge(S, E, Weight) | _], Weight, edge(S, E, Weight)) :- !.
getMax([_ | T], MaxWeight, Edge) :-
    getMax(T, MaxWeight, Edge).

getInEdgesByNode(Node, AllEdges, EdgeList) :-
    getInEdgesByNode(Node, AllEdges, [], EList),
    getMaxEdge(EList, EdgeList).
getInEdgesByNode(_, [], Res, Res) :- !.
getInEdgesByNode(Node, [edge(StartNode, Node, Weight) | AllEdges], EdgeList, Res) :-
    Weight > 0,
    !,
    getInEdgesByNode(Node, AllEdges, [edge(StartNode, Node, Weight) | EdgeList], Res).
getInEdgesByNode(Node, [_ | AllEdges], EdgeList, Res) :-
    getInEdgesByNode(Node, AllEdges, EdgeList, Res).

getOutEdgesByNode(Node, AllEdges, EdgeList) :-
    getOutEdgesByNode(Node, AllEdges, [], EList),
    getMaxEdge(EList, EdgeList).
getOutEdgesByNode(_, [], Res, Res) :- !.
getOutEdgesByNode(Node, [edge(Node, EndNode, Weight) | AllEdges], EdgeList, Res) :-
    Weight > 0,
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
