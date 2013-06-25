function [conv_land, conv_ocean] = water_budget(inpt, clms, period);

% The function computes the global water budget of a given input dataset
% over one year. As a rule of thumb, this budget should be closed over a
% long term average, i.e. the convergence of moisture over land (+ P - E) 
% should equal the divergence of moisture over the oceans ( - (P - E))
% (Hagemann et. al., 2005)


sind = find(cell2mat(inpt(:,clms(1))) == ...
                              1  & cell2mat(inpt(:,clms(2))) == period(1));
                          
eind = find(cell2mat(inpt(:,clms(1))) == ...
                              12 & cell2mat(inpt(:,clms(2))) == period(2));
                          
                          
load continents.asc


mask_land = zeros(360, 720);
mask_land(continents > 0) = 1;

mask_ocean = zeros(360, 720);
mask_ocean(continents == -9999) = 1;


