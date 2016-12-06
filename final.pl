:- [clputility].

schoolBus(OrderList) :-
    OrderList = [student(DianaPlace, 'Diana', DianaStreet), student(BrucePlace, 'Bruce', BruceStreet),
    student(TracyPlace, 'Tracy', TracyStreet), student(DannyPlace, 'Danny', DannyStreet),
    student(JustinPlace, 'Justin', JustinStreet)],
    %StreetOrder = [MulberryPlace, BlueberryPlace, HuckleberryPlace, CherryPlace, ElderberryPlace],
    StreetOrder = [DianaStreet, BruceStreet, TracyStreet, DannyStreet, JustinStreet],
    StudentOrder = [DianaPlace, BrucePlace, TracyPlace, DannyPlace, JustinPlace],
    StudentOrder ins 1..5,
    % StreetList ins 1..5,
    StreetOrder ins 1..5,
    all_different(StudentOrder),
    all_different(StreetOrder),
    % all_different(StreetList),
    DannyPlace #< JustinPlace,
    DannyPlace #< TracyPlace,
    JustinPlace #< DianaPlace,
    TracyPlace #> BrucePlace,
    DianaStreet #\= 1,
    DianaStreet #\= 3,
    label(StudentOrder),
    label(StreetOrder),

    %whoever has huckleberry as street gets off before whoever has blueberry as street
    getStudentByStreet(OrderList, 3, student(StudentOnHuckleberry, _, _)),
    getStudentByStreet(OrderList, 2, student(StudentOnBlueberry, _, _)),
    getStudentByStreet(OrderList, 1, student(StudentOnMulberry, _, _)),
    StudentOnHuckleberry #< StudentOnBlueberry,
    StudentOnMulberry #< StudentOnBlueberry,
    % HuckleberryPlace #< BlueberryPlace,
    % MulberryPlace #< BlueberryPlace,

    getStudentByStreet(OrderList, 4, student(StudentOnCherry, _, _)),
    % HuckleberryPlace #> CherryPlace,
    StudentOnHuckleberry #> StudentOnCherry,

    getStudentByStreet(OrderList, 5, student(ElderberryPlace, _, _)),
    % HuckleberryPlace #< ElderberryPlace,
    StudentOnHuckleberry #< ElderberryPlace,
    % label(StreetList),
    %name of second person off bus doesnt begin with D
    checkNameOfSecondPerson(OrderList),
    checkSecondToLastPerson(OrderList).
getStudentByStreet([student(Place, _, Street]) | _], Street, student(Place, _, Street)).
getStudentByStreet([_ | T], Street, Student]) :-
     getStudentByStreet(T, Street, Student).
mapNumToStreet(1, 'Mulberry').
mapNumToStreet(2, 'Blueberry').
mapNumToStreet(3, 'Huckleberry').
mapNumToStreet(4, 'Cherry').
mapNumToStreet(5, 'Elderberry').
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
