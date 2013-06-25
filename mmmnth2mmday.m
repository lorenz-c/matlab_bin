function otpt = mmmnth2mmday(inpt, clms, mval, method, datatype);
% The function transforms the data in inpt from mm/month to mm/day and vice
% versa. 

%--------------------------------------------------------------------------
% Input:        inpt       matrix/cell   Input data                                     
%               clms       vector        Columns which contain the time
%                                        information
%               mval       scalar        Missing value identifier
%               method     1,2           1: mm/month -> mm/day
%                                        2: mm/day   -> mm/month
%               datatype   char          Full dataset contains area indices
%                                        in the first row.                                        
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   July 2012
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------

if nargin < 5, datatype = 'full'; end
if nargin < 4, method = 1; end
if nargin < 3, mval = -9999; end

if nargin < 2
    if isnumeric(inpt)
        clms = [1 2 4];
    elseif iscell(inpt)
        clms = [3 4 8];
    end
end


otpt = inpt;

if isnumeric(inpt)
    
    if strcmp(datatype, 'full')
        sind = 2;
    else
        sind = 1;
    end
    
    mnth   = inpt(sind:end, clms(1));
    yr     = inpt(sind:end, clms(2));
    nrd    = eomday(yr, mnth);
    
    nrtsps = length(mnth);
    nrtsrs = length(inpt(sind, clms(3):end));
    
    
    daymat = nrd*ones(1, nrtsrs);
    
    if method == 1
        otpt(sind:end, clms(3):end) = otpt(sind:end, clms(3):end)./daymat;
    elseif method == 2
        otpt(sind:end, clms(3):end) = otpt(sind:end, clms(3):end).*daymat;
    end
    
    otpt(inpt == mval) = mval;
    
    
elseif iscell(inpt)
    
    mnth = cell2mat(inpt(:, clms(1)));
    yr   = cell2mat(inpt(:, clms(2)));
    nrd    = eomday(yr, mnth);
    
    if method == 1
        for i = 1:length(mnth)
            otpt{i, clms(3)} = inpt{i, clms(3)}./nrd(i);
            otpt{i, clms(3)}(inpt{i, clms(3)} == mval) = mval;
        end
    elseif method == 2
        for i = 1:length(mnth)
            otpt{i, clms(3)} = inpt{i, clms(3)}*nrd(i);
            otpt{i, clms(3)}(inpt == mval) = mval;
        end
    end

end




