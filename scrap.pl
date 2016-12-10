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

    SunWork = [Bsun, Csun, Dsun, Esun, Fsun],
    MonWork = [Cmon, Dmon, Emon, Fmon, Gmon],
    TueWork = [Atue, Dtue, Etue, Ftue, Gtue],
    WedWork = [Awed, Bwed, Ewed, Fwed, Gwed],
    ThuWork = [Athu, Bthu, Cthu, Fthu, Gthu],
    FriWork = [Afri, Bfri, Cfri, Dfri, Gfri],
    SatWork = [Asat, Bsat, Csat, Dsat, Esat],


    [Bsun, Csun, Dsun, Esun, Fsun] ins 4..5,
    [Cmon, Dmon, Emon, Fmon, Gmon] ins 3..4,
    [Atue, Dtue, Etue, Ftue, Gtue] ins 2..3,
    [Awed, Bwed, Ewed, Fwed, Gwed] ins 2..3,
    [Athu, Bthu, Cthu, Fthu, Gthu] ins 3,
    [Afri, Bfri, Cfri, Dfri, Gfri] ins 3..4,
    [Asat, Bsat, Csat, Dsat, Esat] ins 4..5,


    sum([Bsun, Csun, Dsun, Esun, Fsun], #>=, Sun),
sum([Cmon, Dmon, Emon, Fmon, Gmon], #>=, Mon),
sum([Atue, Dtue, Etue, Ftue, Gtue], #>=, Tue),
sum([Awed, Bwed, Ewed, Fwed, Gwed], #>=, Wed),
sum([Athu, Bthu, Cthu, Fthu, Gthu], #>=, Thu),
 sum([Afri, Bfri, Cfri, Dfri, Gfri], #>=, Fri),
 sum([Asat, Bsat, Csat, Dsat, Esat], #>=, Sat),
