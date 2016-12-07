:- [clputility].

schoolBus(OrderList) :-
    OrderList = [student(DianaPlace, 'Diana', DianaStreet), student(BrucePlace, 'Bruce', BruceStreet),
    student(TracyPlace, 'Tracy', TracyStreet), student(DannyPlace, 'Danny', DannyStreet),
    student(JustinPlace, 'Justin', JustinStreet)],
    StreetOrder = [DianaStreet, BruceStreet, TracyStreet, DannyStreet, JustinStreet],
    StudentOrder = [DianaPlace, BrucePlace, TracyPlace, DannyPlace, JustinPlace],
    StudentOrder ins 1..5,
    StreetOrder ins 1..5,
    all_different(StudentOrder),
    all_different(StreetOrder),
    DannyPlace #< JustinPlace,
    DannyPlace #< TracyPlace,
    JustinPlace #< DianaPlace,
    TracyPlace #> BrucePlace,
    label(StudentOrder),
    label(StreetOrder),
    getStudentByStreet(OrderList, student(StudentOnMulberry, _, 1)),
    getStudentByStreet(OrderList, student(StudentOnBlueberry, _, 2)),
    getStudentByStreet(OrderList, student(StudentOnHuckleberry, _, 3)),
    getStudentByStreet(OrderList, student(StudentOnCherry, _, 4)),
    getStudentByStreet(OrderList, student(StudentOnElderberryPlace, _, 5)),
    StudentOnHuckleberry #< StudentOnBlueberry,
    StudentOnMulberry #< StudentOnBlueberry,
    StudentOnHuckleberry #> StudentOnCherry,
    StudentOnHuckleberry #< StudentOnElderberryPlace,
    DianaPlace #> StudentOnHuckleberry,
    DianaPlace #< StudentOnMulberry,
    checkNameOfSecondPerson(OrderList),     %name of second person off bus doesnt begin with D
    4 #> StudentOnElderberryPlace,
    4 #< StudentOnBlueberry.
getStudentByName([student(Place, Name, _) | _], student(Place, Name, _)).
getStudentByName([_ | T], Student) :-
     getStudentByName(T, Student).
getStudentByStreet([student(Place, _, Street) | _], student(Place, _, Street)).
getStudentByStreet([_ | T], Student) :-
     getStudentByStreet(T, Student).
mapNumToStreet(1, 'Mulberry').
mapNumToStreet(2, 'Blueberry').
mapNumToStreet(3, 'Huckleberry').
mapNumToStreet(4, 'Cherry').
mapNumToStreet(5, 'Elderberry').
checkNameOfSecondPerson([student(2, Name, _) | _]) :-
    string_chars(Name, [FirstLetter | _]),
    FirstLetter \== 'D',
    !.
checkNameOfSecondPerson([_ | T]) :-
    checkNameOfSecondPerson(T).
