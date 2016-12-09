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
