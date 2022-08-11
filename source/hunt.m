function [cur_point,prev_point] = hunt(navstivene, all_sousedi)
% funkce pro hunt fazi

% vstupy - navstivene, all_sousedi
% vystup - current point nenavstiveny a prev_point je sousedni navstivena

s_radky = size(navstivene,1);
s_sloupce = size(navstivene,2);

for i = 1:2:s_radky
    for y = 1:2:s_sloupce        
        if isempty(navstivene{i,y})
            sousedi = all_sousedi{i,y};
            for x = 1:size(sousedi,1)
%                 hledani jiz navstiveneho souseda
                cur_soused = sousedi(x,:);
                if navstivene{cur_soused(1),cur_soused(2)} == 1
                    cur_point = [i,y];
                    prev_point = [cur_soused(1),cur_soused(2)];
                    break;
                end
            end
        end
    end
end

end