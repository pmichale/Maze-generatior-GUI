function [sousedi] = vymazsousedy(aktualnibod,insousedi,all_sousedi)
% funkce pro mazani soucasne bunky jako potencialniho souseda ostatnich

radek = aktualnibod(1);
sloupec = aktualnibod(2);

pocet = size(all_sousedi{radek,sloupec},1);

smazat = all_sousedi{radek,sloupec};

for i = 1:pocet
    soused_radek = smazat(i,1);
    soused_sloupec = smazat(i,2);
    for y = 1:size(insousedi{soused_radek,soused_sloupec},1) 
        akt = insousedi{soused_radek,soused_sloupec};
        if akt(y,:) == [radek,sloupec]
            akt(y,:) = [];
            smazano = akt;
        end
    end
    insousedi{soused_radek,soused_sloupec} = smazano;
end

sousedi = insousedi;

end