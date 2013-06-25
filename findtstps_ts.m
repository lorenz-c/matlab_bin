function [otpt] = findtstps_ts(fld, period, tscale, clms)
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

if nargin < 3
    tscale = 'monthly';
end

if nargin < 4
    if strcmp(tscale, 'monthly')
        clms = [1 2 4];
    elseif strcmp(tscale, 'daily')
        clms = [1 2 3 5];
    end
end



    
if strcmp(tscale, 'monthly')
    
    data_dtes = datenum(fld(:, clms(2)), fld(:, clms(1)), 15);
    
    if tval == 2
        dte_ref  = dtevec([1 period(1)], [12 period(2)], 'monthly');
    elseif tval == 4        
        dte_ref = dtevec(period(1:2), period(3:4), 'monthly');   
    end
    
    num_indx = 3;
    
    
elseif strcmp(tscale, 'daily')
    
	data_dtes = datenum(fld(clms(3)), fld(clms(2)), fld(clms(1)));
    
    if tval == 2
        dte_ref = dtevec([1 period(1)], [12 period(2)], 'daily');
    elseif tval == 4        
        dte_ref = dtevec(period(1:2), period(3:4), 'daily');   
    elseif tval == 6        
        dte_ref = dtevec(period(1:3), period(4:6), 'daily');
    end
    
    num_indx = 4;
    
    
end

otpt = zeros(size(dte_ref, 1), size(fld, 2)).*NaN;


for i = 1:length(dte_ref)
	data_indx = find(data_dtes == dte_ref(i, num_indx));
    otpt(i, 1:num_indx) = dte_ref(i, :);
    
    if ~isempty(data_indx)
        otpt(i, num_indx+1:end) = fld(data_indx, clms(end):end);
    end
end

if fld(1,1) == 0
    otpt = [fld(1, :); otpt];
end


        
        

    

    

        
        
        
    
    









    
    

