:- [clputility].

schedule([Sun, Mon, Tue, Wed, Thu, Fri, Sat], TotalPayroll) :-
    Sun #= 22,
    Mon #= 17,
    Tue #= 13,
    Wed #= 14,
    Thu #= 15,
    Fri #= 18,
    Sat #= 24,
    [Bsun, Csun, Dsun, Esun, Fsun] ins 0..Sun, sum([Bsun, Csun, Dsun, Esun, Fsun], #>=, Sun),
    [Cmon, Dmon, Emon, Fmon, Gmon] ins 0..Mon, sum([Cmon, Dmon, Emon, Fmon, Gmon], #>=, Mon),
    [Atue, Dtue, Etue, Ftue, Gtue] ins 0..Tue, sum([Atue, Dtue, Etue, Ftue, Gtue], #>=, Tue),
    [Awed, Bwed, Ewed, Fwed, Gwed] ins 0..Wed, sum([Awed, Bwed, Ewed, Fwed, Gwed], #>=, Wed),
    [Athu, Bthu, Cthu, Fthu, Gthu] ins 0..Thu, sum([Athu, Bthu, Cthu, Fthu, Gthu], #>=, Thu),
    [Afri, Bfri, Cfri, Dfri, Gfri] ins 0..Fri, sum([Afri, Bfri, Cfri, Dfri, Gfri], #>=, Fri),
    [Asat, Bsat, Csat, Dsat, Esat] ins 0..Sat, sum([Asat, Bsat, Csat, Dsat, Esat], #>=, Sat),
    label([Bsun, Csun, Dsun, Esun, Fsun]),
    label([Cmon, Dmon, Emon, Fmon, Gmon]),
    label([Atue, Dtue, Etue, Ftue, Gtue]),
    label([Awed, Bwed, Ewed, Fwed, Gwed]),
    label([Athu, Bthu, Cthu, Fthu, Gthu]),
    label([Afri, Bfri, Cfri, Dfri, Gfri]),
    label([Asat, Bsat, Csat, Dsat, Esat]),
    TotalPayroll #= (Bsun + Csun + Dsun + Esun + Fsun) * 40
    + (Cmon + Dmon + Emon + Fmon + Gmon) * 40
    + (Atue + Dtue + Etue + Ftue + Gtue) * 40
    + (Awed + Bwed + Ewed + Fwed + Gwed) * 40
    + (Athu + Bthu + Cthu + Fthu + Gthu) * 40
    + (Afri + Bfri + Cfri + Dfri + Gfri) * 40
    + (Asat + Bsat + Csat + Dsat + Esat) * 40.
