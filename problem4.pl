:- [clputility].

schedule([Sun, Mon, Tue, Wed, Thu, Fri, Sat], TotalPayroll) :-
    [Bsun, Csun, Dsun, Esun, Fsun] ins 4..5,
    [Cmon, Dmon, Emon, Fmon, Gmon] ins 3..4,
    [Atue, Dtue, Etue, Ftue, Gtue] ins 2..3,
    [Awed, Bwed, Ewed, Fwed, Gwed] ins 2..3,
    [Athu, Bthu, Cthu, Fthu, Gthu] ins 3,
    [Afri, Bfri, Cfri, Dfri, Gfri] ins 3..4,
    [Asat, Bsat, Csat, Dsat, Esat] ins 4..5,
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
