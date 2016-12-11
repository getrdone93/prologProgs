:- [clputility].

schedule([Sun, Mon, Tue, Wed, Thu, Fri, Sat], TotalPayroll) :-
    [Atue, Awed, Athu, Afri, Asat] ins 3,
    [Bsun, Bwed, Bthu, Bfri, Bsat] ins 5,
    [Csun, Cmon, Cthu, Cfri, Csat] ins 6,
    [Dsun, Dmon, Dtue, Dfri, Dsat] ins 4 \/ 5,
    [Esun, Emon, Etue, Ewed, Esat] ins 5 \/ 6,
    [Fsun, Fmon, Ftue, Fwed, Fthu] ins 1,
    [Gmon, Gtue, Gwed, Gthu, Gfri] ins 0,
    homogeneousList([Dsun, Dmon, Dtue, Dfri, Dsat], Dsun),
    homogeneousList([Esun, Emon, Etue, Ewed, Esat], Esun),
    Sun #= Bsun + Csun + Dsun + Esun + Fsun,
    Mon #= Cmon + Dmon + Emon + Fmon + Gmon,
    Tue #= Atue + Dtue + Etue + Ftue + Gtue,
    Wed #= Awed + Bwed + Ewed + Fwed + Gwed,
    Thu #= Athu + Bthu + Cthu + Fthu + Gthu,
    Fri #= Afri + Bfri + Cfri + Dfri + Gfri,
    Sat #= Asat + Bsat + Csat + Dsat + Esat,
    Sun #>= 22,
    Mon #>= 17,
    Tue #>= 13,
    Wed #>= 14,
    Thu #>= 15,
    Fri #>= 18,
    Sat #>= 24,
    minimize(Sun, [Bsun, Csun, Dsun, Esun, Fsun]),
    minimize(Mon, [Cmon, Dmon, Emon, Fmon, Gmon]),
    minimize(Tue, [Atue, Dtue, Etue, Ftue, Gtue]),
    minimize(Wed, [Awed, Bwed, Ewed, Fwed, Gwed]),
    minimize(Thu, [Athu, Bthu, Cthu, Fthu, Gthu]),
    minimize(Fri, [Afri, Bfri, Cfri, Dfri, Gfri]),
    minimize(Sat, [Asat, Bsat, Csat, Dsat, Esat]),
    label([Atue, Awed, Athu, Afri, Asat]),
    label([Bsun, Bwed, Bthu, Bfri, Bsat]),
    label([Csun, Cmon, Cthu, Cfri, Csat]),
    label([Dsun, Dmon, Dtue, Dfri, Dsat]),
    label([Esun, Emon, Etue, Ewed, Esat]),
    label([Fsun, Fmon, Ftue, Fwed, Fthu]),
    label([Gmon, Gtue, Gwed, Gthu, Gfri]),
    TotalPayroll #= Sun * 40
    + Mon * 40
    + Tue * 40
    + Wed * 40
    + Thu * 40
    + Fri * 40
    + Sat * 40.
homogeneousList([H], E) :-
    H #= E,
    !.
homogeneousList([H | T], E) :-
    H #= E,
    homogeneousList(T, E).
