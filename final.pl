:- [clputility].

schoolBus(OrderList) :-
     StudentList = [student(DianaPlace, 'Diana', DianaStreet), student(BrucePlace, 'Bruce', BruceStreet),
     student(TracyPlace, 'Tracy', TracyStreet), student(DannyPlace, 'Danny', DannyStreet),
     student(JustinPlace, 'Justin', JustStreet)],
     StreetTerms = [street(MulberryPlace, 'Mulberry'), street(BlueberryPlace, 'Blueberry'),
     street(HuckleberryPlace, 'Huckleberry'), street(CherryPlace, 'Cherry'),
     street(ElderberryPlace, 'Elderberry')],
     StreetPlaces = [MulberryPlace, BlueberryPlace, HuckleberryPlace, CherryPlace, ElderberryPlace],
     all_different()



     DannyPlace #=< JustinPlace,
     DannyPlace #=< TracyPlace,
     JustinPlace #=< DianaPlace,
