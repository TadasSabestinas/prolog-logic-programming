% Tadas Sabestinas
% PS IV kursas, 4 grupė
% Užduotis 4

% 4. Duotas domino kauliukų sarašas. Nustatykite, kaip galima sudėti juos į uždarą grandinę. 
% Svarbu ne tik rasti atsakymą, bet ir gražiai jį pateikti. 

rasti_domino_grandine(DominoKauliukai) :- 
    sudeti_grandine(DominoKauliukai, _, Grandine),
    uzdara_grandine(Grandine), 
    % !, % sustabdo tolimesne paieska jeigu norim tik vieno ats
    spausdinti_grandine(Grandine).

sudeti_grandine([], _, []). 

sudeti_grandine(LikeDominoKauliukai, Pradinis, [Pradinis-Galas | LikusiGrandine]) :-
    pasirinkti_kauliuka(LikeDominoKauliukai, Pradinis-Galas, Likutis),
    sudeti_grandine(Likutis, Galas, LikusiGrandine).

pasirinkti_kauliuka(DominoKauliukai, Pradinis-Galas, Likutis) :-
    select(Pradinis-Galas, DominoKauliukai, Likutis);
    select(Galas-Pradinis, DominoKauliukai, Likutis).

uzdara_grandine([Pirmas-_ | LikusiGrandine]) :- 
    last(LikusiGrandine, _-Paskutinis), 
    Pirmas == Paskutinis.
    
spausdinti_grandine([]).
spausdinti_grandine([Pradinis-Galas | LikusiGrandine]) :-
    format("~d:~d~n", [Pradinis, Galas]),
    spausdinti_grandine(LikusiGrandine).

% rasti_domino_grandine([1-2, 2-3, 3-4, 4-1]).
% 1:2
%2:3
%3:4
%4:1 ir t.t

% rasti_domino_grandine([6-1, 3-1, 4-3, 4-5, 5-2, 2-6]).
%6:1
%1:3
%3:4
%4:5
%5:2
%2:6 ir t.t


% rasti_domino_grandine([6-1, 5-2, 4-3, 2-6, 3-1, 4-5]). (ismaisyti domino skaiciai)
%6:1
%1:3
%3:4
%4:5
%5:2
%2:6 ir t.t

