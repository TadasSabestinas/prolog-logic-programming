% Tadas Sabestinas
% PS IV kursas, 4 grupė
% Užduotys 2.3, 3

% Duomenų bazėje saugomi duomenys apie studentus faktais: 
% studentas(Vardas, Kursas); yraVyresnis(StudentoVardas1, StudentoVardas2). 
% Sąryšis „būti vyresniu“ yra tranzityvus, todėl į faktų aibę neįtraukiami tie faktai, 
% kurie seka iš tranzityvumo sąryšio. Tai reiškia, kad, jeigu Jonas vyresnis už Miglę, o 
% Miglė už Ritą, tai faktų aibėje yra predikatai yraVyresnis(jonas, migle) ir yraVyresnis(migle, rita), 
% bet nėra predikato yraVyresnis(jonas, rita). Taip pat sąryšis „būti vyresniu“ yra pilnai sutvarkantis 
% studentų aibę. Tai reiškia, kad, kokius bepaimsime du skirtingus studentus Studentas1 ir Studentas2, 
% arba Studentas1 bus vyresnis už Studentas2, arba Studentas2 bus vyresnis už Studentas1. Taigi, pavyzdžiui, 
% tokia faktų aibė yra negalima: 
% yraVyresnis(jonas, migle), yraVyresnis(migle, rita), yraVyresnis(jonas, tadas) ir yraVyresnis(tadas, rita). 
% Apibrėžkite predikatą:

% 2.3: studentas A yra vyresnis už kito kurso studentą B.

studentas(jonas, 1).
studentas(migle, 2).
studentas(rita, 3).
studentas(tadas, 4).
studentas(agne, 1).
studentas(domas, 2).
studentas(laura, 4).
studentas(karolis, 4).

yraVyresnis(jonas, migle).
yraVyresnis(migle, rita).
yraVyresnis(rita, tadas).
yraVyresnis(tadas, agne).
yraVyresnis(agne, domas).
yraVyresnis(domas, laura).
yraVyresnis(laura, karolis).

skirtingiKursai(StudA, StudB) :- studentas(StudA, KursasA), studentas(StudB, KursasB), KursasA \= KursasB.

vyresnis(StudA, StudB) :- yraVyresnis(StudA, StudB).
vyresnis(StudA, StudC) :- yraVyresnis(StudA, StudB), vyresnis(StudB, StudC).

vyresnisIrIsSkirtinguKursu(StudA, StudB) :- skirtingiKursai(StudA, StudB), vyresnis(StudA, StudB).

% ?- vyresnisIrIsSkirtinguKursu(jonas, rita). % true
% ?- vyresnisIrIsSkirtinguKursu(agne, karolis).  % true
% ?- vyresnisIrIsSkirtinguKursu(karolis, domas). % false nors is skirtingu kursu, bet karolis jaunesnis
% ?- vyresnisIrIsSkirtinguKursu(tadas, karolis). % false nors tadas vyresnis, bet jie is to pacio kurso


% 3: Duoti du natūriniai skaičiai. Raskite jų bendrą didžiausią daliklį pagal Euklido algoritmą. Pavyzdžiui:
% ?- bdd(36,60,Bdd).
% Bdd = 12.

bdd(X, 0, X) :- X > 0. 
bdd(X, Y, Bdd) :- Y > 0, R is X mod Y, bdd(Y, R, Bdd).

% ?- bdd(36,60,Bdd). % Bdd = 12
% ?- bdd(164, 28, Bdd). % Bdd = 4