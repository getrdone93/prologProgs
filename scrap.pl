StreetTerms = [street(MulberryPlace, 'Mulberry'), street(BlueberryPlace, 'Blueberry'),
street(HuckleberryPlace, 'Huckleberry'), street(CherryPlace, 'Cherry'),
street(ElderberryPlace, 'Elderberry')],

all_different(StreetList),
display(StudentOnMulberry),display(' '),
display(StudentOnBlueberry),display(' '),
display(StudentOnHuckleberry),display(' '),
display(StudentOnCherry),display(' '),
display(StudentOnElderberryPlace),display(' '),nl,

getAllNodes(AllNodes) :-
    findall(edge(X, Y), edge(X, Y), AllNodes).
