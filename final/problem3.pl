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

% normalizeNodes([], NewEdges, NewEdges) :-
%     getAllNodes(AllNodes),
%     checkNodesOkay(AllNodes, NewEdges),
%     !.
% normalizeNodes([], NewEdges, Res) :-
%     getAllNodes(AllNodes),
%     normalizeNodes(AllNodes, NewEdges, Res).
% normalizeNodes([Node | AllNodes], AllEdges, Res) :-
%     \+ isNodeOkay(Node, AllEdges),
%     normalize(Node, AllEdges, NewEdges),
%     !,
%     normalizeNodes(AllNodes, NewEdges, Res).
% normalizeNodes([_ | AllNodes], AllEdges, Res) :-
%     normalizeNodes(AllNodes, AllEdges, Res).

normalize(Node, AllEdges, NewEdges) :-
    getNodeFlow(Node, AllEdges, OutFlow, InFlow),
    OutFlow > InFlow,
    !,
    getOutEdgesByNode(Node, AllEdges, OutEdgeList),
    subtractFromNode(Node, AllEdges, OutEdgeList, NewEdges).
normalize(Node, AllEdges, NewEdges) :-
   getNodeFlow(Node, AllEdges, OutFlow, InFlow),
   OutFlow < InFlow,
   % !,
   getInEdgesByNode(Node, AllEdges, OutEdgeList),
   subtractFromNode(Node, AllEdges, OutEdgeList, NewEdges).

subtractFromNode(Node, AllEdges, OutEdgeList, NewEdges) :-
    subtractFromNode(Node, AllEdges, OutEdgeList, [], NewEdges).
subtractFromNode(Node, AllEdges, [Edge | OutEdgeList], _, Res) :-
     \+ isNodeOkay(Node, AllEdges),
     !,
     subtractFromEdge(Edge, NewEdge),
     reconstructEdges(AllEdges, NewEdge, NewEdgeList),
     subtractFromNode(Node, NewEdgeList, OutEdgeList, NewEdgeList, Res).
subtractFromNode(Node, AllEdges, _, NewEdges, NewEdges) :-
     isNodeOkay(Node, AllEdges).

reconstructEdges(AllEdges, edge(Snode, Enode, Weight), NewEdges) :-
    delete(AllEdges, edge(Snode, Enode, _), TempNewEdges),
    append(TempNewEdges, [edge(Snode, Enode, Weight)], NewEdges).

subtractFromEdge(edge(Snode, Enode, Weight), edge(Snode, Enode, NewWeight)) :-
    NewWeight is Weight - 1.

checkNodesOkay([Node | AllNodes], AllEdges) :-
    isNodeOkay(Node, AllEdges),
    checkNodesOkay(AllNodes, AllEdges).

getAllNodes(AllNodes) :-
    findall(OutNode, edge(OutNode, _, _), OutNodes),
    findall(InNode, edge(_, InNode, _), InNodes),
    append(OutNodes, InNodes, TempAllNodes),
    sort(TempAllNodes, AllNodes).

getInEdgesByNode(Node, AllEdges, EdgeList) :-
    getInEdgesByNode(Node, AllEdges, [], EdgeList).
getInEdgesByNode(_, [], Res, Res) :- !.
getInEdgesByNode(Node, [edge(StartNode, Node, Weight) | AllEdges], EdgeList, Res) :-
    !,
    getInEdgesByNode(Node, AllEdges, [edge(StartNode, Node, Weight) | EdgeList], Res).
getInEdgesByNode(Node, [_ | AllEdges], EdgeList, Res) :-
    getInEdgesByNode(Node, AllEdges, EdgeList, Res).

getOutEdgesByNode(Node, AllEdges, EdgeList) :-
    getOutEdgesByNode(Node, AllEdges, [], EdgeList).
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
