function F = catchmat2cell(flds, cindx, rws, cls, mval, arr);
% The function re-arranges the elements of the matrix flds into a
% cell array, where each cell contains one "map". The locations on
% these maps must be referenced by the vector cindx. The output
% maps have the dimension [rws x cls], where undefined values
% are set to mval. 
% Normally, the flds-matrix is arranged longitude-wise. In the
% case of latitude-ordering, arr must be set to 2.
%--------------------------------------------------------------------------
% Input:    flds     [m x n]    Matrix which contains maps for m number
%                               of timesteps and n pixels
%           cindx    [n x 1]    Referencing vector which contains the
%                               ondices of the elements of flds in a large 
%                               "map".
%           rws, cls [1 x 1]    Number of rows and columns of the output
%                               maps.
%           mval     [1 x 1]    Value of undefined elements                
%                               Default: -9999
%           arr     1 or 2      arr = 1: Longitude ordering
%                               arr = 2: Latitude ordering
%                               Detault: arr = 1;             
% Output:   F       {m x 1}     Cell array which has a number of elements 
%                               equal to the number of time-steps (i.e.
%                               the rows) of flds.
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   July 2011
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------

if nargin < 5, mval = -9999; end
if nargin < 6, arr  = 1; end

[n, p] = size(flds);

if n == 1
    tmp         = ones(rws*cls, 1)*mval;
    tmp(cindx)  = flds;
    if arr == 2
        F = reshape(tmp, cls, rws);
        F = F';
    else
        F = reshape(tmp, rws, cls);
    end
    
else
    F = cell(n, 1);
    for i = 1:n
        F{i} = zeros(rws, cls);
        
        tmp = ones(rws*cls, 1)*mval;
        tmp(cindx) = flds(i,:);
        if arr == 2
             F{i,1} = reshape(tmp, cls, rws);
             F{i,1} = F{i,1}';
        else      
             F{i,1} = reshape(tmp, rws, cls);
        end
    end
end

