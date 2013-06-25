function S = spat_agg(inpt, mask, mval, cell_area, fac)
% The function aggregates an input field over an area which is defined by
% the mask. If there are any missing values in the input field, the
% function does not consider these values. Furthermore, the output can be
% weighted with the cell area. If cell_area is a matrix containing the
% areas of the cells, the output S is the area weighted mean of the input.
% Otherwise, S is simply the mean value of inpt.
% If furthermore fac is defined, the output is divided by this value (e.g.
% conversion from mm/month to mm/day)
% -------------------------------------------------------------------------
% INPUT:   inpt        [n x m]    Matrix/Vector containing the input field
%          mask        [n x m]    Matrix/Vector defining the area of interest
%          mval        scalar     Defines missing values in the input field
%          cell_area   [n x m]    Matrix/Vector containing the area of the
%                                 respective grid-cell
%          fac         scalar     A scalar by which the output is divided
% -------------------------------------------------------------------------
% OUTPUT   S           scalar     Aggregated value 
% -------------------------------------------------------------------------
% Author: Christof Lorenz, IMK-IFU Garmisch-Partenkirchen
% Date: May 2011
% -------------------------------------------------------------------------


if nargin < 5
    fac = 1;
end

if nargin < 4
    cell_area = ones(size(inpt));
end

if nargin < 3
    mval = -9999;
end

if nargin < 2
    mask = ones(size(inpt));
end

% Setting the grid-cells with missing values to zero
mask(inpt == mval) = 0;   

% Multiplying the mask with the area of the pixels (if provided)
mask = cell_area.*mask;

% Computing the aggregated area of all valid grid cells
ar   = sum(sum(mask));

% Multiplicating the input field with the grid-cell area
tmp = mask.*inpt;

% Computing the output as the weighted mean (by considering the factor fac)
S = sum(sum(tmp))/(ar*fac);

