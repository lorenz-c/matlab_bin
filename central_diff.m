function ddt = cdiffcell(inpt, varargin);
% The function computes the first derivative of a given input dataset inpt
% according to the method of central differences. For the first (last)
% field, the derivative is computed according to forward (backward)
% differences. 
%--------------------------------------------------------------------------
% Input:        inpt      {m x n}   Cell array which contains the input 
%                                   fields. 
%               clms      [1 x 3]   column indices of the input containing 
%                                   month, year and the corresponding field 
%                         [1 x 1]   column index of the input fields
%               miss      [1 x 1]   value of undefined elements in the
%                                   input fields
%               id_map    [i x j]   Map which defines the different areas
%               area_id   [1 x k]   Vector (or scalar) which contains the
%                                   ids of the desired areas
%                                        
% Output:       otpt      [m x k]   matrix containing the area-weighted 
%                                   means      
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   July 2011
%--------------------------------------------------------------------------
% Uses: area_wghts.m
%--------------------------------------------------------------------------


% Checking input arguments and setting default values
pp = inputParser;
pp.addRequired('inpt', @(x)iscell(x));                % Input dataset (cell)
pp.addOptional('clms', [4 5 9],  @(x) isnumeric(x));  % Columns of m/y/flds
pp.addOptional('time', [0 0 0 0], @(x) isnumeric(x)); % start and end time
pp.parse(inpt, varargin{:})

clms = pp.Results.clms;
time = pp.Results.time;

keyboard


if size(clms) == [1 1]                 % No time information is available
    
    indx_c = (1:length(inpt))';
    indx_b = [1; indx_c(1:end-1)];
    indx_f = [indx_c(2:end); indx_c(end)];
    
    div    = [1; ones(length(indx_c)-2,1)*2; 1];
    
else
    
    mnth   = cell2mat(inpt(:, clms(1)));
    yr     = cell2mat(inpt(:, clms(2)));
    flds   = inpt(:,clms(3));
    
    sind = find((mnth) == time(1) & yr == time(2))
    eind = find((mnth) == time(3) & yr == time(4));
    
end
keyboard
    
    
    
   
    
fields = inpt(sind:eind, clms);
n = length(fields);


for i = 1:n
    ddt{i,1} = fields{i,1};
    ddt{i,2} = fields{i,2};
    if i == 1
        ddt{i,3} = fields{i+1,3} - fields{i,3};
    elseif i == n
        ddt{i,3} = fields{i,3} - fields{i-1,3};
    else
        ddt{i,3} = 1/2*(fields{i+1,3} - fields{i-1,3});
    end
end




