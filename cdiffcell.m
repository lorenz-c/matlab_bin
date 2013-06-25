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
pp.addOptional('clms', [3 4 8],  @(x) isnumeric(x));  % Columns of m/y/flds
pp.addOptional('time', 0, @(x) isnumeric(x));         % start and end time
pp.addOptional('domweight', 1, @(x) isnumeric(x));    % Apply days of month weighting
pp.parse(inpt, varargin{:})

clms      = pp.Results.clms;
time      = pp.Results.time;
domweight = pp.Results.domweight;



if size(clms) == [1 1]                 % No time information is available
    if domweight == 1
        warning('No time infomration provided!!! Skipping dom weighting')
    end
    indx_c = (1:length(inpt))';
    indx_b = [1; indx_c(1:end-1)];
    indx_f = [indx_c(2:end); indx_c(end)];
    
    div    = [1; ones(length(indx_c)-2,1)*2; 1];
    
else
    
    mnth   = cell2mat(inpt(:, clms(1)));
    yr     = cell2mat(inpt(:, clms(2)));
    dom    = eomday(yr, mnth);
    flds   = inpt(:,clms(3));
    
    if time == 0
        sind = 1;
        eind = length(flds);
    else
        sind = find((mnth) == 1 & yr == time(1));
        eind = find((mnth) == 12 & yr == time(2));
    end
    
    indx_c = (sind:1:eind)';
    div    = zeros(length(indx_c),1);
    
   
%     if sind == 1
%         indx_b = [1; indx_c(1:end-1-1)];
%         div(1) = [1; ones(length(indx_c)-2,1)*2; 1];
%     else
%         indx_b = [sind-1; indx_c(1:end-1-1)];
%     end
%     
%     if eind == numel(flds)
%         indx_f = [indx_c(2:end); indx_c(end)];
%     else
%         indx_f = [indx_c(2:end); eind+1];
%     end
        
end

    
    
    
fields = inpt(sind:eind, clms);
n = length(fields);

keyboard
for i = 1:n
    ddt{i,1} = fields{i,1};
    ddt{i,2} = fields{i,2};
    if i == 1
        ddt{i,3} = (dom(i+1)*fields{i+1,3} - dom(i)*fields{i,3})/(dom(i+1) + dom(i));
    elseif i == n
        ddt{i,3} = (dom(i)*fields{i,3} - dom(i-1)*fields{i-1,3})/(dom(i) + dom(i-1));
    else
        ddt{i,3} = (dom(i+1)*fields{i+1,3} - dom(i-1)*fields{i-1,3})/(dom(i+1)/2 + dom(i) + dom(i-1)/2);
    end
end




