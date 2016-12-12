edge(s, a, 4).
edge(s, b, 2).
edge(a, c, 2).
edge(a, b, 1).
edge(a, d, 4).
edge(c, t, 3).
edge(b, d, 2).
edge(d, t, 3).

%edge(Outgoing, Incoming)

getDeps(Node, node(Node, OutDeps, InDeps)) :-
    findall(edge(OutNode, InNode, EdgeWeight), edge(OutNode, InNode, EdgeWeight), NodeList),
    getOutDeps(Node, NodeList, OutDeps),
    getInDeps(Node, NodeList, InDeps).

getOutDeps(Node, NodeList, OutDeps) :-
    getOutDeps(Node, NodeList, [], OutDeps).
getOutDeps(_, [], OutDeps, OutDeps) :- !.
getOutDeps(Node, [edge(Node, OutNode, _) | NodeList], OutDeps, Res) :-
    !,
    getOutDeps(Node, NodeList, [OutNode | OutDeps], Res).
getOutDeps(Node, [_ | NodeList], OutDeps, Res) :-
    getOutDeps(Node, NodeList, OutDeps, Res).

getInDeps(Node, NodeList, InDeps) :-
    getInDeps(Node, NodeList, [], InDeps).
getInDeps(_, [], InDeps, InDeps) :- !.
getInDeps(Node, [edge(InNode, Node, _) | NodeList], InDeps, Res) :-
    !,
    getInDeps(Node, NodeList, [InNode | InDeps], Res).
getInDeps(Node, [_ | NodeList], InDeps, Res) :-
    getInDeps(Node, NodeList, InDeps, Res).

getNodeFlow(Node, node(Node, OutFlow, InFlow)) :-
    findall(edge(OutNode, InNode, EdgeWeight), edge(OutNode, InNode, EdgeWeight), NodeList),
    getOutFlow(Node, NodeList, 0, OutFlow),
    getInFlow(Node, NodeList, 0, InFlow).

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
