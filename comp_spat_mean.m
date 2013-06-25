function otpt = comp_spat_mean(inpt, time, tscale, clms, mval, mmdayflg)

% Of a given input dataset, this function computes the long-term mean
% either as the mean of the whole timeseries, a seasonal mean or a monthly
% mean. 
% -------------------------------------------------------------------------
% Input:   inpt   'cell'      The input dataset must be a cell variable
%                             which contains the global field itself and a 
%                             time stamp
%          time   [1 x 2]     Defines the start- and end-year of the
%                             time-series which is considered
%          tscale 'string'    'annual'    -> long-term annual mean
%                             'seasonal'  -> long-term of the four seasons
%                                            JFM, AMJ, JAS, OND                                             
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
% Uses:
% -------------------------------------------------------------------------



sind = find(cell2mat(inpt(:,clms(1))) == 1   & ...
                                cell2mat(inpt(:,clms(2))) == time(1))
eind = find(cell2mat(inpt(:,clms(1))) == 12  & ...
                                cell2mat(inpt(:,clms(2))) == time(2))


fields = inpt(sind:eind, clms);
fsize  = size(fields{1,3});


if strcmp(mval, 'NaN')
    for i = 1:length(fields)
        fields{i,3}(isnan(fields{i,3})) = -9999;
    end
    mval = -9999;
end

if nargin < 6
    mmdayflg = 0;
end


if mmdayflg == 1
    for i = 1:length(fields)
        nr_days(i,1) = daysinmonth(fields{i,1}, fields{i,2});
    end
else
	nr_days = ones(length(fields), 1);
end

if strcmp(tscale, 'annual_1')

    otpt = zeros(fsize);
    valid_cells = zeros(fsize);
    
    for i = 1:length(fields)
        otpt = otpt + fields{i,3}/nr_days(i);
        valid_cells(fields{i,3} ~= mval) = ...
                                      valid_cells(fields{i,3} ~= mval) + 1;
    end
    
    otpt(valid_cells ~= 0) = otpt(valid_cells ~= 0) ...
                                           ./valid_cells(valid_cells ~= 0);
    
    if strcmp(mval, 'NaN')
        otpt(valid_cells == 0) = NaN;
    else
        otpt(valid_cells == 0) = mval;
    end
    
    
elseif strcmp(tscale, 'annual_2')
    j_indx = find(cell2mat(fields(:,1)) == 1);
    
    for i = 1:length(j_indx)
        otpt{i,1} = zeros(fsize);
        valid_cells = zeros(fsize);
        tmp = zeros(fsize);
        
        for j = 1:12
            tmp = tmp + fields{j_indx(i)+j-1,3} ...
                                               /nr_days(j_indx(i)+j-1);
            valid_cells(fields{j_indx(i)+j-1,3} ~= mval) = ...
                          valid_cells(fields{j_indx(i)+j-1,3} ~= mval) + 1;
        end
        
        otpt{i,1}(valid_cells ~= 0) = tmp(valid_cells ~= 0) ...
                                           ./valid_cells(valid_cells ~= 0);
            
        if strcmp(mval, 'NaN')
            otpt{i,1}(valid_cells == 0) = NaN;
        else
            otpt{i,1}(valid_cells == 0) = mval;
        end
    end
    
        
elseif strcmp(tscale, 'seasonal_1')
    
    ssn_indx(:,1) = find(cell2mat(fields(:,1)) == 1);
    ssn_indx(:,2) = ssn_indx(:,1) + 3;
    ssn_indx(:,3) = ssn_indx(:,2) + 3;
    ssn_indx(:,4) = ssn_indx(:,3) + 3;
    
    for i = 1:4
        valid_cells = zeros(fsize);
        otpt{1,i} = zeros(fsize);
        tmp = zeros(fsize);
        
        for j = 1:size(ssn_indx,1)
            for k = 1:3
                tmp = tmp + fields{ssn_indx(j+k-1,i), 3} ...
                                               /nr_days(ssn_indx(j+k-1,i));
                valid_cells(fields{ssn_indx(j+k-1,i), 3} ~= mval) ...
                   = valid_cells(fields{ssn_indx(j+k-1,i), 3} ~= mval) + 1;
            end
        end
        
        otpt{1,i}(valid_cells ~= 0) = tmp(valid_cells ~= 0) ...
                                           ./valid_cells(valid_cells ~= 0);
        if strcmp(mval, 'NaN')
            otpt{1,i}(valid_cells == 0) = NaN;
        else
            otpt{1,i}(valid_cells == 0) = mval;
        end

    end


elseif strcmp(tscale, 'seasonal_2')
     
    ssn_indx(:,1) = find(cell2mat(fields(:,1)) == 1);
    ssn_indx(:,2) = ssn_indx(:,1) + 3;
    ssn_indx(:,3) = ssn_indx(:,2) + 3;
    ssn_indx(:,4) = ssn_indx(:,3) + 3;
    
    for i = 1:4
        for j = 1:size(ssn_indx,1)
            otpt{j,i} = zeros(fsize);
            tmp = zeros(fsize);
            valid_cells = zeros(fsize);
            
            for k = 1:3
                tmp = tmp + fields{ssn_indx(j,i)+k-1, 3} ...
                                               /nr_days(ssn_indx(j,i)+k-1);
                valid_cells(fields{ssn_indx(j,i)+k-1, 3} ~= mval) ...
                   = valid_cells(fields{ssn_indx(j,i)+k-1, 3} ~= mval) + 1;
            end
            
            otpt{j,i}(valid_cells ~= 0) = tmp(valid_cells ~= 0) ...
                                           ./valid_cells(valid_cells ~= 0);
            if strcmp(mval, 'NaN')
                otpt{j,i}(valid_cells == 0) = NaN;
            else
                otpt{j,i}(valid_cells == 0) = mval;
            end
        end
    end
    
    
    
elseif strcmp(tscale, 'monthly_1')
%     j_indx = 1:12:length(fields)   % Vector which contains all months
    
mnths = cell2mat(fields(:, 1));
yrs   = cell2mat(fields(:, 2));
    for i = 1:12
        indx = find(mnths == i);
        
        otpt{i,1} = zeros(fsize);
        tmp = zeros(fsize);
        valid_cells = zeros(fsize);
        
        for j = 1:length(indx)
            tmp = tmp + fields{indx(j), 3};
            valid_cells(fields{indx(j), 3} ~= mval) ...
                       = valid_cells(fields{indx(j), 3} ~= mval) + 1;
        end
        tmp(valid_cells ~= 0) = tmp(valid_cells ~= 0) ...
                                           ./valid_cells(valid_cells ~= 0);
        otpt{i,1} = tmp;
        otpt{i,1}(valid_cells == 0) = mval;

        
    end
    
elseif strcmp(tscale, 'monthly_2')
    m_indx(:,1) = find(cell2mat(fields(:,1)) == 1);
    
    for i = 1:11
        m_indx(:,i+1) = m_indx(:,i) + 1;
    end

    for i = 1:size(m_indx,1)
        for j = 1:12
            otpt{i,j} = fields{m_indx(i,j), 3};
        end
    end
end
    
