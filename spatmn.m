function otpt = spatmn(inpt, time, tscale, clms, mval, method)

% Of a given input dataset, this function computes the long-term mean
% either as the mean of the whole timeseries, a seasonal mean or a monthly
% mean. 
% -------------------------------------------------------------------------
% Input:   inpt   'cell'      The input dataset must be a cell variable
%                             which contains the global field itself and a 
%                             time stamp
%          time   [1 x 2]     Defines the start- and end-year of the
%                             time-series which is considered
%          tscale 'string'    'complete'  -> complete time-series
%                             'annual'    -> mean of each year
%                             'seasonal'  -> long-term mean of the four 
%                                            seasons DJF, MAM, JJA, SON                                           
%                             'monthly'   -> long-term mean for each month
%          clms   [1 x 3]     tells the function which row of the input
%                             dataset contains month, year and the global
%                             field, i.e. clms(1) -> month, clms(2) -> year
%                             and clms(3) -> field
%
% Output:  otpt   {1 x 1}     long-term annual mean global field
%                 {1 x 4}     long-term mean seasonal global fields
%                 {1 x 12}    long-term mean monthly global fields

% -------------------------------------------------------------------------
% Christof Lorenz, IMK-IFU Garmisch-Partenkirchen
% Jaunary 2011
% -------------------------------------------------------------------------
% Uses: findtsps.m
% -------------------------------------------------------------------------


if nargin < 6, method = 'wmean'; end
if nargin < 5, mval = -9999; end
if nargin < 4, clms = [3 4 8]; end
    

fields = findtstps_cell(inpt, [time(1) time(2)], clms(2));

mnths  = cell2mat(fields(:, clms(1)));
yrs    = cell2mat(fields(:, clms(2)));
fields = fields(:, clms(3));
fsze   = size(fields{1});


if strcmp(mval, 'NaN')
    for i = 1:length(fields)
        fields{i}(isnan(fields{i})) = -9999;
    end
    mval = -9999;
end

if strcmp(method, 'wmean')
    dom  = eomday(yrs, mnths);    
    dots = sum(dom);
end

if strcmp(tscale, 'complete')

    otpt  = zeros(fsze);
    vclls = zeros(fsze);
%     keyboard
    if strcmp(method, 'wmean')
        for i = 1:length(fields)
            otpt = otpt + dom(i)*fields{i};
            vclls(fields{i} ~= mval) = vclls(fields{i} ~= mval) + dom(i);
        end  
        otpt(vclls ~= 0) = otpt(vclls ~= 0)./vclls(vclls ~= 0);
        
    elseif strcmp(method, 'mean')   
        for i = 1:length(fields)
            otpt = otpt + fields{i};
            vclls(fields{i} ~= mval) = vclls(fields{i} ~= mval) + 1;
        end
        otpt(vclls ~= 0) = otpt(vclls ~= 0)./vclls(vclls ~= 0);
        
    elseif strcmp(method, 'sum')   
        for i = 1:length(fields)
            otpt = otpt + fields{i};
            vclls(fields{i} ~= mval) = vclls(fields{i} ~= mval) + 1;
        end
        otpt(vclls < i) = mval;
    end
    otpt(vclls == 0) = mval;
    
    
    
elseif strcmp(tscale, 'annual')
    yrs_u = unique(yrs);
   
    for i = 1:length(yrs_u)
        
        yr_indx   = find(yrs == yrs_u(i));
        otpt{i,1} = yrs_u(i);
        otpt{i,2} = zeros(fsze);
        vclls     = zeros(fsze);
        tmp       = zeros(fsze);
        
        if strcmp(method, 'wsum')
            for j = 1:length(yr_indx)
                tmp = tmp + dom(yr_indx(j))*fields{yr_indx(j)}
                vclls(fields{yr_indx(j)} ~= mval) = ...
                       vclls(fields{yr_indx(j)} ~= mval) + dom(yr_indx(j));
            end
        else
            for j = 1:length(yr_indx)
                tmp = tmp + fields{yr_indx(j)};
                vclls(fields{yr_indx(j)} ~= mval) = ...
                       vclls(fields{yr_indx(j)} ~= mval) + 1;
            end
        end
        
        otpt{i,2}(vclls ~= 0) = tmp(vclls ~= 0)./vclls(vclls ~= 0);
            
    end
    
        
elseif strcmp(tscale, 'seasonal')
    % Find the fields' indices of the four seasons
    ssn_indx{1} = find(mnths == 12 | mnths == 1  | mnths == 2);
    ssn_indx{2} = find(mnths == 3  | mnths == 4  | mnths == 5);
    ssn_indx{3} = find(mnths == 6  | mnths == 7  | mnths == 8);
    ssn_indx{4} = find(mnths == 9  | mnths == 10 | mnths == 11);
    
    
    for i = 1:4
        vclls     = zeros(fsze);
        otpt{1,i} = zeros(fsze);
        tmp       = zeros(fsze);
        
        if strcmp(method, 'wmean')
            for j = 1:length(ssn_indx{i})
                tmp   = tmp + dom(ssn_indx{i}(j))*fields{ssn_indx{i}(j)};
                vclls = eval_clls(vclls, fields{ssn_indx{i}(j)}, ...
                                  mval, dom(ssn_indx{i}(j)));
            end
            otpt{1,i}(vclls ~= 0) = tmp(vclls ~= 0)./vclls(vclls ~= 0);
            
        elseif strcmp(method, 'mean')
            for j = 1:length(ssn_indx{i})
                tmp   = tmp + fields{ssn_indx{i}(j)};
                vclls = eval_clls(vclls, fields{ssn_indx{i}(j)}, mval, 1);
            end
            otpt{1,i}(vclls ~= 0) = tmp(vclls ~= 0)./vclls(vclls ~= 0);
            
        elseif strcmp(method, 'sum')
            for j = 1:length(ssn_indx{i})
                tmp   = tmp + fields{ssn_indx{i}(j)};
                vclls = eval_clls(vclls, fields{ssn_indx{i}(j)}, mval, 1);
            end     
            tmp(vclls == 0) = mval;
        end
        
    end

    
    
 elseif strcmp(tscale, 'monthly')

    for i = 1:12
        indx = find(mnths == i);
        
        otpt{i,1} = zeros(fsze);
        tmp = zeros(fsze);
        vclls = zeros(fsze);
        
        if strcmp(method, 'wmean')
            for j = 1:length(indx)
                tmp = tmp + dom(indx(j))*fields{indx(j)};
                vclls = eval_clls(vclls, fields{indx(j)}, mval, dom(indx(j)));
            end
        else
            for j = 1:length(indx)
                tmp = tmp + fields{indx(j)};
                vclls = eval_clls(vclls, fields{indx(j)}, mval, 1);
            end
        end
        
        tmp(vclls ~= 0) = tmp(vclls ~= 0)./vclls(vclls ~= 0);
        otpt{i,1} = tmp;
        
        if strcmp(mval, 'NaN')
            otpt{i,1}(vcllss == 0) = NaN;
        else
            otpt{i,1}(vclls == 0) = mval;
        end
    end

end



function vclls = eval_clls(vclls, field, mval, add_nr)
    % The sub-routine adds a number add_nr to each location of a field
    % without a missing value. 
    vclls(field ~= mval) = vclls(field ~= mval) + add_nr;

    
