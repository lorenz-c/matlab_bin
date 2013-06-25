function mask = gen_mask(cswitch)
% The function generates a mask of 360x720 gridpoints containing elements
% of 0 and 1. 
% -------------------------------------------------------------------------
% INPUT:   cswitch      scalar    Defines the desired regions. See the
%                                 table below for possible selectins:
%                                 1: Only Landmasses
%                                 2: Only oceans
%                                 3: Landmasses without polar caps
%                                 4: Landmasses, NH
%                                 5: Landmasses, SH
%                                 6: Landmasses, 15°N - 15°S       
%                                 7: Global, NH
%                                 8: Global, SH
%                                 9: Global, 15°N - 15°S 
%                                10: North America
%                                11: South America
%                                12: Europe
%                                13: Africa
%                                14: Asia
%                                15: Australia
% -------------------------------------------------------------------------
% OUTPUT   mask       [360x720]   matrix with elements of 0 and 1 where all
%                                 undesired gridpoints are set to 0
% -------------------------------------------------------------------------
% Author: Christof Lorenz, IMK-IFU Garmisch-Partenkirchen
% Date: May 2011
% -------------------------------------------------------------------------


load continents.asc
mask = ones(360, 720);

% Generate a mask of 360x720 gridpoints according to the parameter cswitch
if cswitch == 1                         % Only Landmasses
    mask(continents == -9999) = 0;      %  Remove oceans   
    mask(continents == 4)     = 0;      %  Remove ice-shelf
elseif cswitch == 2                     % Only oceans
    mask(continents ~= -9999) = 0;      %  Remove landmasses
    mask(continents == 4)     = 1;      %  Add ice-shelf
elseif cswitch == 3                     % Landmasses without polar caps
    mask(continents == -9999) = 0;      %  Remove oceans   
    mask(continents == 0)     = 0;      %  Remove polar caps
	mask(continents == 4)     = 0;      %  Remove ice-shelf
elseif cswitch == 4                     % Landmasses, NH
    mask(continents == -9999) = 0;      %  Remove oceans
    mask(continents == 4)     = 0;      %  Remove ice-shelf
    mask(181:end,:)           = 0;      %  Remove the SH-gridpoints
elseif cswitch == 5                     % Landmasses, SH
    mask(continents == -9999) = 0;      %  Remove oceans
    mask(continents == 4)     = 0;      %  Remove ice-shelf
    mask(1:180,:)             = 0;      %  Remove the NH-gridpoints
elseif cswitch == 55                    % Landmasses, SH
    mask(continents == -9999) = 0;      %  Remove oceans
    mask(continents == 4)     = 0;      %  Remove ice-shelf
    mask(1:180,:)             = 0;      %  Remove the NH-gridpoints
    mask(continents == 0)     = 0;      % Remove Sout-Pole
elseif cswitch == 6                     % Landmasses, 15°N - 15°S           
    mask(continents == -9999) = 0;      %  Remove oceans
    mask(continents == 4)     = 0;      %  Remove ice-shelf
    mask(1:149, :)            = 0;      %  Remove all gridpoints > 15°N
    mask(212:end, :)          = 0;      %  Remove all gridpoints > 15°S
elseif cswitch == 7                     % Global, NH
    mask(1:180,:)             = 0;      %  Remove the SH-gridpoints       
elseif cswitch == 8                     % Global, SH
    mask(1:180,:)             = 0;      %  Remove the NH-gridpoints 
elseif cswitch == 9                     %  Global, 15°N - 15°S           
    mask(1:149, :)            = 0;      %  Remove all gridpoints > 15°N
    mask(212:end, :)          = 0;      %  Remove all gridpoints > 15°S
elseif cswitch == 10
    mask(continents ~= 7)     = 0;
elseif cswitch == 11
    mask(continents ~= 6)     = 0;
elseif cswitch == 12
    mask(continents ~= 3)     = 0;
elseif cswitch == 13
    mask(continents ~= 8)     = 0;
elseif cswitch == 14
    mask(continents ~= 9)     = 0;
elseif cswitch == 15
    mask(continents ~= 1)     = 0;
end