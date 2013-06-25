function [F, cindx] = cell2catchmat(flds, mask, mval, arr)
% The function rearranges the elements in an cell-array (e.g. an array of
% maps) to a big matrix, which has a number of rows equal to the number of
% time-steps in flds and a number of columns equal to the pixels of a
% single field. The function allows the consideration of a mask to reduce
% the size of a matrix, if e.g. large parts of the input fields contain
% missing values or if further computations are needed for a specific area
% only. 
%--------------------------------------------------------------------------
% Input:    flds    {m x 1}     Cell array (or single matrix) which contains 
%                               the input fields.                
%           mask    [r x c]     Binary mask for removing undesired pixels from 
%                               the flds-cells
%           mval    [1 x 1]     If mval is set, the function also searches for 
%                               missing values in flds and removes these 
%                               elements
%                               Default: -9999
%           arr     1 or 2      arr = 1: Longitude ordering
%                               arr = 2: Latitude ordering
%                               Detault: arr = 1;             
% Output:   F       [m x n]     Matrix which has a number of rows equal to
%                               the number of timesteps in flds (i.e. m)
%                               and a number of columns equal to the number
%                               of ones (and the number of missing values)
%                               in mask
%           cindx   [n x 1]     Column-vector which contains the positions
%                               of the valid elements in flds
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   July 2011
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------

if nargin < 4, arr = 1; end
if nargin < 3, mval = -9999; end

if isnumeric(flds)
    
    if nargin < 2, mask = ones(flds); end
    if isnan(mval)
        mask(isnan(flds)) = 0;
    else
        mask(flds == mval) = 0;
    end
    
    % Store the 2D-mask in a long column-vector
    if arr == 2, mask = mask'; end
    mask_vec = mask(:);
    
    % Find the positions of the elements which are ~= 0 
    cindx = find(mask_vec == 1);
    
    if arr == 2, flds == flds'; end
    tmp = flds(:);
    F(1, :) = tmp(cindx);
    
    
elseif iscell(flds)
    
    nts = length(flds);

    if nargin < 2, mask = ones(flds{1}); end
    if isnan(mval)
        mask(isnan(flds{1})) = 0;
    else
        mask(flds{1} == mval) = 0;
    end
    
    
    % Store the 2D-mask in a long column-vector
    if arr == 2, mask = mask'; end
    mask_vec = mask(:);
    
    % Find the positions of the elements which are ~= 0 
    cindx = find(mask_vec == 1);
    
    % Create the matrix F...
    F = zeros(nts, sum(sum(mask)));
    
    for i = 1:length(flds)
        if arr == 2, flds{i} = flds{i}'; end
        tmp = flds{i}(:);
        F(i,:) = tmp(cindx);
    end
end
    
    












