function [sousedi] = urcisousedy(bunka,s_velikost)
% funkce pro urceni vsech potencialnich sousedu bunky

% bunka = starting_point;

limit_radek = s_velikost(1);
limit_sloupec = s_velikost(2);

radek = bunka(1);
sloupec = bunka(2);
% vsechny potencialni souradnice sousedu
potencial_sousedi = [radek-2,sloupec; ...
    radek,sloupec-2;radek,sloupec+2;radek+2,sloupec];

% vyrazeni sousedu co jsou mimo rozsah
for i = 1:size(potencial_sousedi,1)
    if potencial_sousedi(i,1) > limit_radek ||...
            potencial_sousedi(i,2) > limit_sloupec ||...
            potencial_sousedi(i,1) < 1  ||...
            potencial_sousedi(i,2) < 1
        % vymena sousedu mimo rozsah za NaN at se nezmeni size
        potencial_sousedi(i,:) = [NaN,NaN];
    end
end
% smazani vsech NaN hodnot
potencial_sousedi(any(isnan(potencial_sousedi), 2), :) = [];
sousedi = potencial_sousedi;
end