function R = comp_spat_corr(fld1, fld2, time, tscale, cswitch, clms, mval)

% Of a given input dataset, this function computes the long-term mean
% either as the mean of the whole timeseries, a seasonal mean or a monthly
% mean. 
% -------------------------------------------------------------------------
% Input:   fld1/2 'cell'     The input dataset must be a cell variable
%                            which contains the global field itself and a 
%                            time stamp
%          time   [1 x 2]    Defines the start- and end-year of the
%                            time-series which is considered
%          tscale 'string'   'annual_1'    -> long-term annual mean
%                            'annual_2'    -> mean of each year
%                            'seasonal'    -> long-term of the four seasons
%                                             JFM, AMJ, JAS, OND                                             
%                            'monthly'     -> long-term mean for each 
%                                             month
%          clms   [1 x 3]    tells the function which row of the input
%                            dataset contains month, year and the global
%                            field, i.e. clms(1) -> month, clms(2) -> year
%                            and clms(3) -> field
%                            If clms has only 3 elements, it is assumed
%                            that both datasets have the same ordering.
%                            Otherwise, clms is a [1 x 6] vector, of which
%                            the first 3 elements belong to fld1 and the
%                            rest to fld2.
%          mval   [1 x 1]    Missing values in the datasets. If mval is
%                            NaN, it must be given as a string, i.e. mval =
%                            'NaN'
%
% Output:  R      {1 x 1}     long-term annual mean global field
%                 {1 x 4}     long-term mean seasonal global fields
%                 {1 x 12}    long-term mean monthly global fields

% -------------------------------------------------------------------------
% Christof Lorenz, IMK-IFU Garmisch-Partenkirchen
% Jaunary 2011
% -------------------------------------------------------------------------
% Uses: spat_corr.m, comp_spat_mean.m
% -------------------------------------------------------------------------


if nargin < 7
    mval = -9999;
end

if nargin < 6
    clms = [4 5 9 4 5 9];
end

if nargin < 5
    cswitch  = 1;
end

if nargin < 4
    tscale = 'complete';
end

if size(clms,1) == 3
    clms = [clms; clms];
elseif size(clms,2) == 3
    clms = [clms clms];
end

sind1 = find(cell2mat(fld1(:,clms(1))) == 1   & ...
                                cell2mat(fld1(:,clms(2))) == time(1));
eind1 = find(cell2mat(fld1(:,clms(1))) == 12  & ...
                                cell2mat(fld1(:,clms(2))) == time(2));
                            
sind2 = find(cell2mat(fld2(:,clms(4))) == 1   & ...
                                cell2mat(fld2(:,clms(5))) == time(1));
eind2 = find(cell2mat(fld2(:,clms(4))) == 12  & ...
                                cell2mat(fld2(:,clms(5))) == time(2));
                            
fields(:,1:3) = fld1(sind1:eind1, clms(1:3));
fields(:,4)   = fld2(sind2:eind2, clms(6));


if strcmp(tscale, 'annual_1') 
        
    mn_1 = comp_spat_mean(fields, time, tscale, [1 2 3], mval);
    mn_2 = comp_spat_mean(fields, time, tscale, [1 2 4], mval);
    
    R = spat_corr(mn_1, mn_2, cswitch, mval);

elseif strcmp(tscale, 'annual_2')
    j_indx = find(cell2mat(fields(:,1)) == 1);
    
    for i = 1:length(j_indx)
        for j = 1:12
            tmp(j,:) = spat_corr(fields{j_indx(i)+j-1,3}, ...
                                 fields{j_indx(i)+j-1,4}, cswitch, mval);
        end
        R(:,i) = mean(tmp,1)';
    end
    
   
elseif strcmp(tscale, 'complete')
    
    for i = 1:length(fields)
        R(i,:) = spat_corr(fields{i,3}, fields{i,4}, cswitch, mval);
    end
    
elseif strcmp(tscale, 'monthly')
    
    mn_1 = comp_spat_mean(fields, time, 'monthly_2', [1 2 3], mval);
    mn_2 = comp_spat_mean(fields, time, 'monthly_2', [1 2 4], mval);
    
    for i = 1:12
        for j = 1:size(mn_1,1)
            tmp(j,:) = spat_corr(mn_1{j,i}, mn_2{j,i}, cswitch, mval);
        end
        R(:,i) = mean(tmp,1)';
        clear tmp;
    end       
end
    
    
    
    
    
    

    
    


                            
                            

