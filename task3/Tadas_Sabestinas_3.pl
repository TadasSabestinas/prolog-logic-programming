% Tadas Sabestinas
% PS IV kursas, 4 grupė
% Užduotys 1.9; 2.6; 3.4; 4.5	

% Apibrėžkite paskirtus keturis predikatus pagal nurodytas sąlygas. Nors kai kurių užduočių
% formulavimas yra procedūrinis, reikia siekti, kiek įmanoma, deklaratyvios programos.
% Nenaudokite Prolog darbo su sąrašais predikatų. Pasiaiškinkite, kaip taikomas atkirtos (!) operatorius
% ir kur jį galima būtų panaudoti Jūsų predikatuose.

% Paprasti predikatai su sveikųjų skaičių sąrašais:
% 1.9 - knelyg(S,K) - skaičių sąrašo S nelyginių elementų kiekis yra K.

knelyg([], 0) :- !. 

knelyg([H|T], K) :-
    H mod 2 =:= 1, !, % Tikrinam ar H nelyginis, jei taip - pereinam, nevykdom lyginio sk atvejo. Jei ne, praleidziam likusius zingsnius ir pereinam prie lyginio sk atvejo
    knelyg(T, K1),
    K is K1 + 1.

knelyg([_|T], K) :-
    knelyg(T, K). % Lyginio sk atvejis vykdomas tik jei pirmas nepavyko.


% ?- knelyg([1,8,3,7,5,2,4,6,13], K).
% K = 5.

% ?- knelyg([2,8,3,7,5,2,4,6,13], K).
% K = 4.

% ?- knelyg([2,4,6], K).
% K = 0.

% ?- knelyg([1,5,7,8,13], 5).
% false, nes K = 4

% ?- knelyg([3,1,5,17,2], 4).
% true



% 2.6 kart(S,K,E) - sąraše S yra K vienas po kito einančių vienodų elementų E.

kart([], _, _) :- !, false.

kart([E|T], K, E) :-
    pradzia_kart([E|T], K, E). % Jei saraso pradzia atitinka E, tikrinam ar K kartu is eiles pasikartoja

kart([_|T], K, E) :- % Jei elementas nera tinkamas tai pereinam prie likusios saraso dalies T ir rekursyviai tikrinam ar like elementai kartojasi vienas po kito K kartu
    kart(T, K, E).

pradzia_kart(_, 0, _) :- !.

pradzia_kart([E|T], K, E) :- % Jei pirmas saraso elementas atitinka E tai mazinam K ir tikrinam likusi sarasa T
    K1 is K - 1,
    pradzia_kart(T, K1, E).

%?- kart([h,a,c,a,b,b,b,b,a,g],4,E).
%E = b.

%?- kart([d,d,c,a,b,f,h,a,g],2,E).
%E = d;

%?- kart([a,a,c,a,b,b,a,g],2,E).
%E = a;
%E = b;

%?- findall(E, kart([a,a,c,a,b,b,a,g],2,E), Rezultatai).
%Rezultatai = [a, b].

% 3.4 kartojasi(S,R) - sąrašas R susideda iš duotojo sąrašo S pasikartojančių elementų. Pavyzdžiui:
%?- kartojasi([a,b,a,d,a,d],R).
%R = [a,d].

kartojasi(S, R) :- kartojasi(S, [], R). % Pridedam tuscia sarasa kuris stebes aplankytus elementus

kartojasi([], _, []) :- !.

kartojasi([H|T], Aplankyti_elementai, [H|R]) :- % Jei H pasikartoja likusiose saraso dalyje T ir dar nebuvo aplankytas tai jis bus pridedamas prie rezultato ir pazymimas kaip aplankytas
    yra_sarase(H, T),
    \+ yra_sarase(H, Aplankyti_elementai), % \+ negacija - tikrinam ar elementas dar nera aplankytu sarase
    !,
    kartojasi(T, [H|Aplankyti_elementai], R).

kartojasi([_|T], Aplankyti_elementai, R) :- % Jei H nebuvo aplankytas tai pereinam prie likusio saraso T
    kartojasi(T, Aplankyti_elementai, R).

yra_sarase(X, [X|_]) :- !. 
yra_sarase(X, [_|T]) :- yra_sarase(X, T).

%?- kartojasi([a,b,a,d,a,d], R).
%R = [a, d].

%?- kartojasi([x,x,x,x], R).
%R = [x].

%?- kartojasi([1,2,3,4,1,5,6,2,7], R).
%R = [1, 2].

%i_baitus(Des,Bait) - Des yra skaičius vaizduojamas dešimtainių skaitmenų sąrašu. Bait - tas pats skaičiaus, vaizduojamas baitų (skaičių nuo 0 iki 255) sąrašu. Pavyzdžiui:
%?- i_baitus([1,2,3,4,5,6,7],Bait).
%Bait = [18,214,135].

i_baitus(Des, Apversti_Baitai) :-
    desimtainiai_i_skaiciu(Des, Number), 
    skaicius_i_baitus(Number, Bait), 
    apversti_sarasa(Bait, [], Apversti_Baitai),
    !.

apversti_sarasa([], Apverstas, Apverstas).

apversti_sarasa([Pirmas|Likusi_Saraso_Dalis], Laikinas, Apverstas) :- 
    apversti_sarasa(Likusi_Saraso_Dalis, [Pirmas|Laikinas], Apverstas).                               

desimtainiai_i_skaiciu(Des, Number) :- 
    kaupiamasis_desimtainiai(Des, 0, Number). % Rekursyviai formuojam skaicius is desimtainiu skaiciu

kaupiamasis_desimtainiai([], Kaupiama_Reiksme, Kaupiama_Reiksme). % Kai visi skaiciai apdoroti, sukaupta reiksme grazinama kaip skaicius

kaupiamasis_desimtainiai([Dabartinis_Desimtainis_Skaicius|Like_Neapdoroti_Desimtainiai_Skaitmenys], Kaupiama_Reiksme, Number) :-
    NewKaupiama_Reiksme is Kaupiama_Reiksme * 10 + Dabartinis_Desimtainis_Skaicius,           
    kaupiamasis_desimtainiai(Like_Neapdoroti_Desimtainiai_Skaitmenys, NewKaupiama_Reiksme, Number).

% Kiekvienas skaicius pridedamas prie sukauptos reiksmes

skaicius_i_baitus(0, []). % Jei skaicius lygus 0, grazinamas tuscias baitu sarasas           

skaicius_i_baitus(Number, [Baitas|Baitu_Sarasas]) :- %Skaicius dalijamas i baitus naudojant dalybos ir mod operacijas
    Likutis is Number // 256,           
    Baitas is Number mod 256,             
    skaicius_i_baitus(Likutis, Baitu_Sarasas).



%?- i_baitus([1,2,3,4,5,6,7],Bait).
%Bait = [18,214,135].

%?- i_baitus([9,8,7,6,5,4], Bait).
%Bait = [15, 18, 6].

% 1. Des = [9, 8, 7, 6, 5, 4].
%    Konvertuojame i viena skaiciu
%    Number = 987654.
% 2. Skaidome 987654 i baitus:
%    987654 mod 256 = 6, Likutis = 987654 // 256 = 3850.
%    3850 mod 256 = 18, Likutis = 3850 // 256 = 15.
%    15 mod 256 = 15, Likutis = 15 // 256 = 0.
%    Gauname baitu sarasa atvirkstine tvarka: [6, 18, 15].
% 3. Apverciam ji:
%    [6, 18, 15] i [15, 18, 6].
% Atsakymas:
% Bait = [15, 18, 6].