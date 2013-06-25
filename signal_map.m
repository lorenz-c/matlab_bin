function A = signal_map(inpt, indx_vec, id_map)
% The function assigns a value (an element in the inpt-vector) to an area
% of a map refferenced by the id_map. 
%--------------------------------------------------------------------------
% Input:        inpt      [n x 1]   Vector which contains the values to be
%                                   assigned to a map
%               indx_vec  [n x 1]   Vector which contains the ids of the
%                                   areas
%               id_map    [r x c]   Map which contains the ids for each
%                                   area
%                                        
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   August 2012
%--------------------------------------------------------------------------
% Uses: 
if length(inpt) ~= length(indx_vec)
    error('Inpt and indx_vec must have the same length!')
end

A = zeros(size(id_map)).*NaN;
for i = 1:length(indx_vec)
    A(id_map == indx_vec(i)) = inpt(i);
end

% plotglbl(A)

