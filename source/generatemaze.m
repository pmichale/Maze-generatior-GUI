function [maze] = generatemaze(radky,sloupce)
% rozsireni rozmeru o sloupce a radky pro zdi
s_radky = radky*2-1;
s_sloupce = sloupce*2-1;
s_velikost = [s_radky, s_sloupce];
% pocet vsech bunek
c_bunky = sloupce*radky;


liche_radky = 1:2:s_radky;
liche_sloupce = 1:2:s_sloupce;
steny_radky = 2:2:s_radky;
steny_sloupce = 2:2:s_sloupce;
% random starting point
starting_radek = liche_radky(randi(length(liche_radky), 1, 1));
starting_sloupec = liche_sloupce(randi(length(liche_sloupce), 1, 1));
starting_point = [starting_radek,starting_sloupec];
% prealokace cell arraye pro seznamy sousedu
neighbors = cell(s_radky,s_sloupce);
% naplneni cell arraye souradnicemi sousedu
for i = 1:length(liche_radky)
    for y = 1:length(liche_sloupce)
        neighbors{liche_radky(i),liche_sloupce(y)} = urcisousedy([liche_radky(i),liche_sloupce(y)],s_velikost);
    end
end
% prealokace cell arraye s navstivenymi bunkami a stenami
navstivene = cell(s_radky,s_sloupce);
% navstiven starting point
navstivene{starting_radek,starting_sloupec} = 1;
%% staveni vsech sten
for i = 1:s_radky
    for y = 1:length(steny_sloupce)
        navstivene{i,steny_sloupce(y)} = 2;
    end
end

for i = 1:s_sloupce
    for y = 1:length(steny_radky)
        navstivene{steny_radky(y),i} = 2;
    end
end
%% init
current_point = starting_point;
pocet_projitych = 1;
% ulozeni vsech moznych sousedu
all_sousedi = neighbors;
% smazani startovaciho bodu ze sousedu
neighbors = vymazsousedy(current_point,neighbors,all_sousedi);
% prealokace
posloupnost = zeros(c_bunky,2);
posloupnost(pocet_projitych,:) = starting_point;
%% hlavni cyklus
while 1
    moznosti_pohybu = neighbors{current_point(1),current_point(2)};
    % hunt cyklus
    while isempty(moznosti_pohybu)
        % ukonceni generovani
        if pocet_projitych == c_bunky
            break;
        end
        % hunt fce
        [current_point,previous_point] = hunt(navstivene, all_sousedi);
        navstivene{current_point(1),current_point(2)} = 1;
        % mazani zdi
        navstivene = smazzed(previous_point,current_point,navstivene);
        % mazani ze sousedu
        neighbors = vymazsousedy(current_point,neighbors,all_sousedi);
        
        moznosti_pohybu = neighbors{current_point(1),current_point(2)};
        pocet_projitych = pocet_projitych + 1;
        posloupnost(pocet_projitych,:) = current_point;
    end
    % ukonceni generovani
    if pocet_projitych == c_bunky
            break;
    end
    rand_walk = randi([1,size(moznosti_pohybu,1)]);
    previous_point = current_point;
    current_point = moznosti_pohybu(rand_walk,:);
    navstivene{current_point(1),current_point(2)} = 1;
    pocet_projitych = pocet_projitych + 1;
    posloupnost(pocet_projitych,:) = current_point;
    % mazani zdi
    navstivene = smazzed(previous_point,current_point,navstivene);
    % mazani ze sousedu
    neighbors = vymazsousedy(current_point,neighbors,all_sousedi);
end

maze = navstivene;
% prevod na binarni matici
for i = 1:size(maze,1)
    for y = 1:size(maze,2)
        if isempty(maze{i,y})
            maze{i,y} = 0;
        elseif maze{i,y} == 1
            maze{i,y} = 0;
        elseif maze{i,y} == 2
            maze{i,y} = 1;
        end
    end
end
maze = cell2mat(maze);
% cerny ramecek
maze = padarray(maze,[1 1],1);
end