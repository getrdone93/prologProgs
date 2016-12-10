:- [clputility].

schedule([Sun, Mon, Tue, Wed, Thu, Fri, Sat], TotalPayroll) :-
    [Atue, Awed, Athu, Afri, Asat] ins 2..4,
    [Bsun, Bwed, Bthu, Bfri, Bsat] ins 3..5,
    [Csun, Cmon, Cthu, Cfri, Csat] ins 3..5,
    [Dsun, Dmon, Dtue, Dfri, Dsat] ins 2..5,
    [Esun, Emon, Etue, Ewed, Esat] ins 3 \/ 5,
    [Fsun, Fmon, Ftue, Fwed, Fthu] ins 3..5,
    [Gmon, Gtue, Gwed, Gthu, Gfri] ins 3 \/ 4,
    homogeneousList([Atue, Awed, Athu, Afri, Asat], Atue),
    homogeneousList([Bsun, Bwed, Bthu, Bfri, Bsat], Bsun),
    homogeneousList([Csun, Cmon, Cthu, Cfri, Csat], Csun),
    homogeneousList([Dsun, Dmon, Dtue, Dfri, Dsat], Dsun),
    homogeneousList([Esun, Emon, Etue, Ewed, Esat], Esun),
    homogeneousList([Fsun, Fmon, Ftue, Fwed, Fthu], Fsun),
    homogeneousList([Gmon, Gtue, Gwed, Gthu, Gfri], Gmon),
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
    label([Bsun, Csun, Dsun, Esun, Fsun]),
    label([Cmon, Dmon, Emon, Fmon, Gmon]),
    label([Atue, Dtue, Etue, Ftue, Gtue]),
    label([Awed, Bwed, Ewed, Fwed, Gwed]),
    label([Athu, Bthu, Cthu, Fthu, Gthu]),
    label([Afri, Bfri, Cfri, Dfri, Gfri]),
    label([Asat, Bsat, Csat, Dsat, Esat]),
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
