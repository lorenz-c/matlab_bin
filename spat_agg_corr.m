function [R] = spat_agg_corr(inpt1, inpt2, mask, mval, cell_area, fac)
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

if nargin < 6
    fac = 1;
end

if nargin < 5
    cell_area = ones(size(inpt1));
end

if nargin < 4
    mval = -9999;
end

if nargin < 3
    mask = ones(size(inpt));
end

if nargin < 2
    inpt2 = inpt1;
end

% Setting the grid-cells with missing values to zero
mask(inpt1 == mval) = 0;   
mask(inpt2 == mval) = 0;   

% Multiplying the mask with the area of the pixels (if provided)
mask_ar = cell_area.*mask;

% Computing the aggregated area of all valid grid cells
ar      = sum(sum(mask_ar));
mask_ar = mask_ar/ar;

% Computing a vector containing the fracions of the total area
mask_v  = mask_ar(mask == 1);

% Multiplicating the input field with the grid-cell area
tmp1 = inpt1(mask == 1);
tmp2 = inpt2(mask == 1);

% Computing the weighted mean of both input fields
mn1 = mask_v'*tmp1;
mn2 = mask_v'*tmp2;

% Computing the deviation between the actual gridpoint value and the mean
d1  = tmp1 - mn1;
d2  = tmp2 - mn2;

% Computing the standard deviations of both fields
sig1 = sqrt(mask_v'.*d1'*d1);
sig2 = sqrt(mask_v'.*d2'*d2);

% Computing the spatial correlation between both fields
R = (mask_v'.*d1'*d2)/(sig1*sig2);
E = sqrt((mask_v'.*(d2-d1)'*(d2-d1)));



% keyboard




