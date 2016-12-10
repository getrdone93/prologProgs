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


    label(SunWork),
    label(MonWork),
    label(TueWork),
    label(WedWork),
    label(ThuWork),
    label(FriWork),
    label(SatWork),
    % SchedA = [Atue, Awed, Athu, Afri, Asat],
    % SchedB = [Bsun, Bwed, Bthu, Bfri, Bsat],
    % SchedC = [Csun, Cmon, Cthu, Cfri, Csat],
    % SchedD = [Dsun, Dmon, Dtue, Dfri, Dsat],
    % SchedE = [Esun, Emon, Etue, Ewed, Esat],
    % SchedF = [Fsun, Fmon, Ftue, Fwed, Fthu],
    % SchedG = [Gmon, Gtue, Gwed, Gthu, Gfri],
    SunWork = [Bsun, Csun, Dsun, Esun, Fsun],
    MonWork = [Cmon, Dmon, Emon, Fmon, Gmon],
    TueWork = [Atue, Dtue, Etue, Ftue, Gtue],
    WedWork = [Awed, Bwed, Ewed, Fwed, Gwed],
    ThuWork = [Athu, Bthu, Cthu, Fthu, Gthu],
    FriWork = [Afri, Bfri, Cfri, Dfri, Gfri],
    SatWork = [Asat, Bsat, Csat, Dsat, Esat],
