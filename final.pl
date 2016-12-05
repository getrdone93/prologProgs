:- [clputility].

schoolBus(OrderList) :-
    OrderList = [student(DianaPlace, 'Diana', DianaStreet), student(BrucePlace, 'Bruce', BruceStreet),
    student(TracyPlace, 'Tracy', TracyStreet), student(DannyPlace, 'Danny', DannyStreet),
    student(JustinPlace, 'Justin', JustinStreet)],
    StreetOrder = [MulberryPlace, BlueberryPlace, HuckleberryPlace, CherryPlace, ElderberryPlace],
    StreetList = [DianaStreet, BruceStreet, TracyStreet, DannyStreet, JustinStreet],
    StudentOrder = [DianaPlace, BrucePlace, TracyPlace, DannyPlace, JustinPlace],
    StudentOrder ins 1..5,
    StreetList ins 1..5,
    StreetOrder ins 1..5,
    all_different(StudentOrder),
    all_different(StreetOrder),
    all_different(StreetList),
    DannyPlace #< JustinPlace,
    DannyPlace #< TracyPlace,
    JustinPlace #< DianaPlace,
    HuckleberryPlace #> CherryPlace,
    HuckleberryPlace #< ElderberryPlace,
    TracyPlace #> BrucePlace,
    DianaStreet #\= 1,
    DianaStreet #\= 3,
    HuckleberryPlace #< BlueberryPlace,
    MulberryPlace #< BlueberryPlace,
    label(StudentOrder),
    label(StreetOrder),
    label(StreetList),
    %name of second person off bus doesnt begin with D
    checkNameOfSecondPerson(OrderList),
    checkSecondToLastPerson(OrderList).
checkSecondToLastPerson([student(4, _, Street) | _]) :-
    Street #\= 2,
    Street #\= 5.
checkSecondToLastPerson([_ | T]) :-
    checkSecondToLastPerson(T).
checkNameOfSecondPerson([student(2, Name, _) | _]) :-
    string_chars(Name, [FirstLetter | _]),
    FirstLetter \== 'D',
    !.
checkNameOfSecondPerson([_ | T]) :-
    checkNameOfSecondPerson(T).
mapNumToStreet(1, 'Mulberry').
mapNumToStreet(2, 'Blueberry').
mapNumToStreet(3, 'Huckleberry').
mapNumToStreet(4, 'Cherry').
mapNumToStreet(5, 'Elderberry').
