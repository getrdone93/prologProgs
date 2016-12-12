% normalizeNodes(AllNodes, AllEdges) :-
%     member(Node, AllNodes),
%     \+ isNodeOkay(Node, AllEdges),
%     normalize(Node, AllEdges),
display('NewEdge: '),display(NewEdge),nl,

findall(edge(OutNode, InNode, EdgeWeight), edge(OutNode, InNode, EdgeWeight), AllEdges),


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

fourPicker(FourList, AllFours, N) :-
    powerset(AllFours, FourList),
    length(FourList, Len),
    Len =:= N.
equationBuilder(Answer, 1) :-
    fourPicker(FourList, 1),
    buildEquationOneFour(FourList, Answer).
buildEquationOneFour([Four], Answer) :-
    findall(Operation, unary(u(Operation)), UnaryOps),
    execute(Four, UnaryOps, AnswerList),
    member(Answer, AnswerList).

execute(Four, [+, -, sqrt, !, square], AnswerList) :-
    PlusAnswer is 0 + Four,
    MinusAnswer is 0 - Four,
    SqrtAnswer is sqrt(Four),
    factorialWrapper(Four, FactorialAnswer),
    SquareAnswer is Four ** 2,
    AnswerList = [PlusAnswer, MinusAnswer, SqrtAnswer, FactorialAnswer, SquareAnswer].

execute(Four, UnaryOps, AnswerList) :-
    execute(Four, UnaryOps, [], AnswerList).
execute(_, _, AnswerList, AnswerList).
execute(Four, [+ | UnaryOps], AnswerList, Res) :-
    Answer is 0 + Four,
    execute(Four, UnaryOps, [Answer | AnswerList], Res).
execute(Four, [- | UnaryOps], AnswerList, Res) :-
    Answer is 0 - Four,
    execute(Four, UnaryOps, [Answer | AnswerList], Res).
execute(Four, [sqrt | UnaryOps], AnswerList, Res) :-
    Answer is sqrt(Four),
    execute(Four, UnaryOps, [Answer | AnswerList], Res).
execute(Four, [! | UnaryOps], AnswerList, Res) :-
    factorial(Four, Answer),
    execute(Four, UnaryOps, [Answer | AnswerList], Res).
execute(Four, [square | UnaryOps], AnswerList, Res) :-
    Answer is Four ** 2,
    execute(Four, UnaryOps, [Answer | AnswerList], Res).








StreetTerms = [street(MulberryPlace, 'Mulberry'), street(BlueberryPlace, 'Blueberry'),
street(HuckleberryPlace, 'Huckleberry'), street(CherryPlace, 'Cherry'),
street(ElderberryPlace, 'Elderberry')],

all_different(StreetList),
display(StudentOnMulberry),display(' '),
display(StudentOnBlueberry),display(' '),
display(StudentOnHuckleberry),display(' '),
display(StudentOnCherry),display(' '),
display(StudentOnElderberryPlace),display(' '),nl,

getNodeList(AllNodes, NodeList, N) :-
    getNodeList(AllNodes, NodeList, [], N, 0).
getNodeList(_, NodeList, NodeList, N, N).
getNodeList([Node | AllNodes], [Node | NodeList], Res, N, C) :-
    C1 is C + 1,
    getNodeList(AllNodes, NodeList, Res, N, C1).
    label(SchedA),
    label(SchedB),
    label(SchedC),
    label(SchedD),
    label(SchedE),
    label(SchedF),
    label(SchedG),

    SunWork #>= Sun,


    Cmon + Dmon + Emon + Fmon + Gmon #= MonWork,
    MonWork #>= Mon,
    Atue + Dtue + Etue + Ftue + Gtue #= TueWork,
    TueWork #>= Tue,
    Awed + Bwed + Ewed + Fwed + Gwed #= WedWork,
    WedWork #>= Wed,
    Athu + Bthu + Cthu + Fthu + Gthu #= ThuWork,
    ThuWork #>= Thu,
    Afri + Bfri + Cfri + Dfri + Gfri #= FriWork,
    FriWork #>= Fri,
    Asat + Bsat + Csat + Dsat + Esat #= SatWork,
    SatWork #>= Sat,

    SchedA = [Atue, Awed, Athu, Afri, Asat],
    SchedB = [Bsun, Bwed, Bthu, Bfri, Bsat],
    SchedC = [Csun, Cmon, Cthu, Cfri, Csat],
    SchedD = [Dsun, Dmon, Dtue, Dfri, Dsat],
    SchedE = [Esun, Emon, Etue, Ewed, Esat],
    SchedF = [Fsun, Fmon, Ftue, Fwed, Fthu],
    SchedG = [Gmon, Gtue, Gwed, Gthu, Gfri],




    Atue #= Awed #= Athu #= Afri #= Asat,
    SchedA ins 2..4,
    % Bsun #= Bwed #= Bthu #= Bfri #= Bsat,
    % SchedB ins 3..5,
    % Csun #= Cmon #= Cthu #= Cfri #= Csat,
    % SchedC ins 3..5,
    % Dsun #= Dmon #= Dtue #= Dfri #= Dsat,
    % SchedD ins 2..5,
    % Esun #= Emon #= Etue #= Ewed #= Esat,
    % SchedE ins [3 \/ 5],
    % Fsun #= Fmon #= Ftue #= Fwed #= Fthu,
    % SchedF ins 3..5,
    % Gmon #= Gtue #= Gwed #= Gthu #= Gfri,
    % SchedG ins 3..4,
    label(SchedA),
    label(SchedB),
    label(SchedC),
    label(SchedD),
    label(SchedE),
    label(SchedF),
    label(SchedG),

    % display(Atue),nl,
    % display(Awed),nl,
    % display(Athu),nl,
    % display(Afri),nl,
    % display(Fsun),nl,
    % homogeneousList([E], E) :- !.
    % homogeneousList([E | T], E) :-
    %     homogeneousList(T, E).
    label([Bsun, Csun, Dsun, Esun, Fsun]),
    label([Cmon, Dmon, Emon, Fmon, Gmon]),
    label([Atue, Dtue, Etue, Ftue, Gtue]),
    label([Awed, Bwed, Ewed, Fwed, Gwed]),
    label([Athu, Bthu, Cthu, Fthu, Gthu]),
    label([Afri, Bfri, Cfri, Dfri, Gfri]),
    label([Asat, Bsat, Csat, Dsat, Esat]),
    label(SunWork),
    label(MonWork),
    label(TueWork),
    label(WedWork),
    label(ThuWork),
    label(FriWork),
    label(SatWork),
    display(Bsun),nl,
    display(Csun),nl,
    display(Dsun),nl,
    display(Esun),nl,
    display(Fsun),nl,
    % nl,display([Atue, Awed, Athu, Afri, Asat]),nl,
    % nl,display([Bsun, Bwed, Bthu, Bfri, Bsat]),nl,
    % nl,display([Csun, Cmon, Cthu, Cfri, Csat]),nl,
    % nl,display([Dsun, Dmon, Dtue, Dfri, Dsat]),nl,
    % nl,display([Esun, Emon, Etue, Ewed, Esat]),nl,
    % nl,display([Fsun, Fmon, Ftue, Fwed, Fthu]),nl,
    % nl,display([Gmon, Gtue, Gwed, Gthu, Gfri]),nl,
    SunWork = [Bsun, Csun, Dsun, Esun, Fsun],
    MonWork = [Cmon, Dmon, Emon, Fmon, Gmon],
    TueWork = [Atue, Dtue, Etue, Ftue, Gtue],
    WedWork = [Awed, Bwed, Ewed, Fwed, Gwed],
    ThuWork = [Athu, Bthu, Cthu, Fthu, Gthu],
    FriWork = [Afri, Bfri, Cfri, Dfri, Gfri],
    SatWork = [Asat, Bsat, Csat, Dsat, Esat],
    display('Sunday: '),display([Bsun, Csun, Dsun, Esun, Fsun]),nl,
    display('Monday: '),display([Cmon, Dmon, Emon, Fmon, Gmon]),nl,
    display('Tuesday: '),nl,display([Atue, Dtue, Etue, Ftue, Gtue]),nl,
    display('Wednesday: '),display([Awed, Bwed, Ewed, Fwed, Gwed]),nl,
    display('Thursday: '),display([Athu, Bthu, Cthu, Fthu, Gthu]),nl,
    display('Friday: '),display([Afri, Bfri, Cfri, Dfri, Gfri]),nl,
    display('Saturday: '),display([Asat, Bsat, Csat, Dsat, Esat]),nl.
    homogeneousList([Atue, Awed, Athu, Afri, Asat], Atue),
    homogeneousList([Bsun, Bwed, Bthu, Bfri, Bsat], Bsun),
    homogeneousList([Csun, Cmon, Cthu, Cfri, Csat], Csun),
    homogeneousList([Dsun, Dmon, Dtue, Dfri, Dsat], Dsun),
    homogeneousList([Esun, Emon, Etue, Ewed, Esat], Esun),
    homogeneousList([Fsun, Fmon, Ftue, Fwed, Fthu], Fsun),
    homogeneousList([Gmon, Gtue, Gwed, Gthu, Gfri], Gmon),
    [Bsun, Csun, Dsun, Esun, Fsun] ins 4..5,
    [Cmon, Dmon, Emon, Fmon, Gmon] ins 3..4,
    [Atue, Dtue, Etue, Ftue, Gtue] ins 2..3,
    [Awed, Bwed, Ewed, Fwed, Gwed] ins 2..3,
    [Athu, Bthu, Cthu, Fthu, Gthu] ins 3,
    [Afri, Bfri, Cfri, Dfri, Gfri] ins 3..4,
    [Asat, Bsat, Csat, Dsat, Esat] ins 4..5,
    % [Atue, Awed, Athu, Afri, Asat] ins 2..4,
    % [Bsun, Bwed, Bthu, Bfri, Bsat] ins 2..5,
    % [Csun, Cmon, Cthu, Cfri, Csat] ins 3..5,
    % [Dsun, Dmon, Dtue, Dfri, Dsat] ins 2..5,
    % [Esun, Emon, Etue, Ewed, Esat] ins 2 \/ 3 \/ 5,
    % [Fsun, Fmon, Ftue, Fwed, Fthu] ins 2..5,
    % [Gmon, Gtue, Gwed, Gthu, Gfri] ins 1,

    sum([Bsun, Csun, Dsun, Esun, Fsun], #>=, Sun),
sum([Cmon, Dmon, Emon, Fmon, Gmon], #>=, Mon),
sum([Atue, Dtue, Etue, Ftue, Gtue], #>=, Tue),
sum([Awed, Bwed, Ewed, Fwed, Gwed], #>=, Wed),
sum([Athu, Bthu, Cthu, Fthu, Gthu], #>=, Thu),
 sum([Afri, Bfri, Cfri, Dfri, Gfri], #>=, Fri),
 sum([Asat, Bsat, Csat, Dsat, Esat], #>=, Sat),
