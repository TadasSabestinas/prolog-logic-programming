% Tadas Sabestinas
% PS IV kursas, 4 grupė
% Užduotys 5, 8, 33, 40

% Duomenų bazėje saugomi duomenys apie asmenis ir jų giminystės ryšius faktais:

% asmuo(Vardas, Lytis, Amžius, Pomėgis);
% mama(Mama, Vaikas);
% pora(Vyras, Žmona).
% Kad būtų paprasčiau, faktų aibė sudaroma atsižvelgiant į šias prielaidas:

% Kiekvienas asmuo vienareikšmiškai identifikuojamas vardu;
% Kiekvienoje šeimoje vaikai skirtingo amžiaus;
% Kiekvieno vaiko tėtis yra jo mamos vyras;
% Jeigu vaikas turi mamą, tai jis būtinai turi ir tėtį ir atvirkščiai;
% Detales, neapibrėžtas užduoties sąlygoje, studentas gali interpretuoti savo nuožiūra.
% Pastaba: jeigu parinksite faktus iliustruojančius Jūsų (ar kurį nors kitą Jums gerai žinomą) genealoginį medį, tai Jums patiems bus lengviau tikrinti programos teisingumą. Kita vertus, tai nėra būtina.

% 5. vaikas(Vaikas, TevasMama) - Pirmasis asmuo (Vaikas) yra antrojo (TevasMama) vaikas;
% 8. brolis_ir_sesuo(Brolis, Sesuo) - Pirmasis asmuo (Brolis) yra antrojo (Sesuo) brolis, o antrasis yra pirmojo sesuo;
% 33. daugiavaike(Motina) - Asmuo Motina yra daugiavaikė motina: turi ne mažiau kaip 3 vaikus;
% 40. klaida_duomenyse(Asmuo) - Asmens Asmuo vienas iš tėvų yra už jį jaunesnis;

asmuo(paulina, moteris, 65, krepsinis).
asmuo(mykolas, vyras, 70, siuvimas).

asmuo(jonas, vyras, 45, sachmatai).
asmuo(elzbieta, moteris, 42, piesimas).
asmuo(izabele, moteris, 20, plaukimas).
asmuo(karolis, vyras, 18, futbolas).
asmuo(melita, moteris, 15, knyguskaitymas).
asmuo(deividas, vyras, 10, zaidimaikompiuteriu).

asmuo(janina, moteris, 45, baznycia).
asmuo(vytautas, vyras, 41, tenisas).
asmuo(eimantas, vyras, 19, krepsinis).  
asmuo(deimante, moteris, 16, muzika). 

asmuo(jaunas_tevas, vyras, 16, kompiuteriniaizaidimai).
asmuo(jauna_mama, moteris, 20, muzika).
asmuo(vaikas_jauno_tevo, vyras, 19, zvejyba).

mama(paulina, elzbieta).
mama(paulina, janina).

mama(elzbieta, izabele).
mama(elzbieta, karolis).
mama(elzbieta, melita).
mama(elzbieta, deividas).

mama(janina, eimantas).
mama(janina, deimante).

mama(jauna_mama, vaikas_jauno_tevo).

pora(mykolas, paulina).

pora(jonas, elzbieta).

pora(vytautas, janina).

pora(jaunas_tevas, jauna_mama).

% Prielaida:jeigu mama, tai jos vyras yra tevas

% 5. vaikas(Vaikas, TevasMama) - Pirmasis asmuo (Vaikas) yra antrojo (TevasMama) vaikas;

vaikas(Vaikas, TevasMama) :- mama(TevasMama, Vaikas).
vaikas(Vaikas, TevasMama) :- mama(Mama, Vaikas), pora(TevasMama, Mama).

% ?- vaikas(izabele, elzbieta).      % true
% ?- vaikas(karolis, jonas).         % true
% ?- vaikas(deividas, mykolas).      % false
% ?- vaikas(vaikas_jauno_tevo, jauna_mama). % true

% 8. brolis_ir_sesuo(Brolis, Sesuo) - Pirmasis asmuo (Brolis) yra antrojo (Sesuo) brolis, o antrasis yra pirmojo sesuo;

brolis_ir_sesuo(Brolis, Sesuo) :- asmuo(Brolis, vyras, _, _), asmuo(Sesuo, moteris, _, _), mama(Mama, Brolis), mama(Mama, Sesuo).

% ?- brolis_ir_sesuo(karolis, izabele).    % true
% ?- brolis_ir_sesuo(deividas, melita).    % true
% ?- brolis_ir_sesuo(karolis, deividas).   % false

% 33. daugiavaike(Motina) - Asmuo Motina yra daugiavaikė motina: turi ne mažiau kaip 3 vaikus;

daugiavaike(Motina) :- mama(Motina, PirmasVaikas), mama(Motina, AntrasVaikas), mama(Motina, TreciasVaikas), PirmasVaikas \= AntrasVaikas, AntrasVaikas \= TreciasVaikas, PirmasVaikas \= TreciasVaikas.

% ?- daugiavaike(elzbieta).         % true
% ?- daugiavaike(paulina).          % false
% ?- daugiavaike(janina).          % false

% 40. klaida_duomenyse(Asmuo) - Asmens Asmuo vienas iš tėvų yra už jį jaunesnis;

klaida_duomenyse(Asmuo) :- vaikas(Asmuo, TevasMama), asmuo(Asmuo, _, AmziusAsmuo, _), asmuo(TevasMama, _, AmziusTevasMama, _), AmziusTevasMama < AmziusAsmuo.

% ?- klaida_duomenyse(elzbieta).    % false
% ?- klaida_duomenyse(melita).      % false
% ?- klaida_duomenyse(paulina).     % false
% ?- klaida_duomenyse(vaikas_jauno_tevo). % true