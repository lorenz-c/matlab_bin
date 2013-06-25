function [otpt] = findtstps(fld, period, tscale, clms)
% The function selects the time-steps between a start and end year from a
% given dataset which can be either a matrix or a cell array.

%--------------------------------------------------------------------------
% Input:        fld     matrix/cell Input field which contains the data and
%                                   time information
%               period  vector      Period which will be selected by the
%                                   function. The start and end date must
%                                   be given in one of the following orders
%                                   [2 x 1] -> start-year, end-year
%                                   [4 x 1] -> start-month/year
%                                              end-month/year
%                                   [6 x 1] -> start-day/month/year
%                                              end-day/month/year
%               clms     vector     Columns which contain the time
%                                   information
%                                        
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   March 2012
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------

tval = length(period);

if nargin < 4
    if tval == 2
        if isnumeric(fld)
            clms = 2;
        elseif iscell(fld)
            clms = 4;
        end
    elseif tval == 4
        if isnumeric(fld)
            clms = [1 2];
        elseif iscell(fld)
            clms = [3 4];
        end  
    end
end

if nargin < 3
    tscale = 'monthly';
end


if isnumeric(fld)
    
    if strcmp(tscale, 'monthly')
        data_dtes = datenum(fld(clms(2)), fld(clms(1)), 15);
    elseif strcmp(tscale, 'daily')
        data_dtes = datenum(fld(clms(3)), fld(clms(2)), fld(clms(1)));
    end
    
    if tval == 2
        dte_ref  = dtevec([1 period(1)], [12 period(2)], tscale);
        dte_indx = find(data_dtes == dte_ref(i, 3));
    elseif tval == 4        
        dte_ref = dtevec(period(1:2), period(3:4), tscale);
    elseif tval == 6
        dte_ref = dtevec(period(1:3), period(4:6), 'daily');
    end
    

        
        
        

    
elseif iscell(fld)

    if tval == 2
        
        yrs = cell2mat(fld(:, clms(1)));
        sindx = find(yrs == period(1), 1, 'first');
        eindx = find(yrs == period(2), 1, 'last');
    
    elseif tval == 4
        
        mnths = cell2mat(fld(:, clms(1)));
        yrs   = cell2mat(fld(:, clms(2)));
        
        sindx = find(mnths == period(1) & yrs == period(2), 1, 'first');
        eindx = find(mnths == period(3) & yrs == period(4), 1, 'last');
            
    elseif tval == 6
        
        days  = cell2mat(fld(:, clms(1)));
        mnths = cell2mat(fld(:, clms(2)));
        yrs   = cell2mat(fld(:, clms(3)));
        
        sindx = find(days  == period(1) & ...
                     mnths == period(2) & ...
                     yrs   == period(3), 1, 'first');
        sindx = find(days  == period(4) & ...
                     mnths == period(5) & ...
                     yrs   == period(6), 1, 'last');
    end
    
    if isempty(sindx), error('Start date not included in the dataset'); end
    if isempty(eindx), error('End date not included in the dataset');   end
    
    otpt = fld(sindx:eindx, :);
end

    

        
        
        
    
    









    
    

