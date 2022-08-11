function [navstivene_out] = smazzed(from,to,navstivene)

%% Funkce boura zdi

from_radek = from(1);
from_sloupec = from(2);

to_radek = to(1);
to_sloupec = to(2);

% vypocet souradnic odebirane steny
odebrat_radek = to_radek+((from_radek-to_radek)/2);
odebrat_sloupec = to_sloupec+((from_sloupec-to_sloupec)/2);
% odebrani
navstivene{odebrat_radek,odebrat_sloupec} = [];
% vystup
navstivene_out = navstivene;
end