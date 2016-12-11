edge(s, a, 4).
edge(s, b, 2).
edge(a, c, 2).
edge(a, b, 1).
edge(a, d, 4).
edge(c, t, 3).
edge(b, d, 2).
edge(d, t, 3).

%edge(Outgoing, Incoming)



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
