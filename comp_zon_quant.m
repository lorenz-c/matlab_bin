function zon_val = comp_zon_quant(inpt, time, cswitch, tscale, clms, mval)

if nargin < 6
    mval = -9999;
end

if nargin < 5
    clms = [4 5 9];
end

if nargin < 4
    tscale = 'annual';
end

if nargin < 3
    cswitch = 0;
end

% If we want to compute only continental or oceanic values, we need a
% land/sea-mask!
if cswitch == 1 | cswitch == 2 | cswitch == 3
    load continents.asc
end
 
sind = find(cell2mat(inpt(:,clms(1))) == 1   & ...
                                cell2mat(inpt(:,clms(2))) == time(1));
eind = find(cell2mat(inpt(:,clms(1))) == 12  & ...
                                cell2mat(inpt(:,clms(2))) == time(2));
                            

% if strcmp(tscale, 'season')
%     % If our input dataset starts in January of the start year, we need to
%     % switch to march for seasonal values
%     if sind == 1         
%         sind = sind + 3;
%     % Otherwise, we can also use the data from December of the last year
%     else
%         sind = sind - 1;
%     end
%     % If our input dataset ends in December of the end year, we need to
%     % switch to November for seasonal values
%     if eind == length(inpt)
%         eind = eind - 1;
%     % Otherwise, we can also use the data from December of the following year
%     else
%         eind = eind + 11;
%     end
% end

if strcmp(tscale, 'seasonal')
    sind = sind - 1;
    eind = eind - 1;
end

    
fields = inpt(sind:eind, [clms(1) clms(2) clms(3)]);

clear inpt


if strcmp(tscale, 'annual')
    
    % The indices of all Januaries of the dataset
    jan_ind = 1:12:length(fields);
    
    zon_val = zeros(360, 1);
    
    valid_years = zeros(360, 1);
    % Now, the mean of each year is computed seperately
    for i = 1:length(jan_ind)
        
        % Defining a mask for global, continental or oceanic values
        mask = zeros(360, 720);
        
        if cswitch == 0
            mask = mask + 1;                   % All values          
        elseif cswitch == 1
            mask(continents ~= mval) = 1;      % Continental values        
        elseif cswitch == 2
            mask(continents == mval) = 1;      % Oceanic values
        elseif cswitch == 3
            mask(continents ~= mval) = 1;      % Without polar regions
            mask(continents == 4)    = 0;
        end
        
        fld_sum = zeros(360, 720);
        
        
        for j = 1:12
            % Storing the actual field in the tmp variable
            tmp = fields{jan_ind(i) + j - 1, 3};
            % Setting the elements of the mask to zero, where missing
            % values in the input dataset are present
            mask(tmp == mval) = 0;
            % Computing a global/continental/oceanic field without missing
            % values
            tmp =  tmp.*mask;
            % For the conversion from mm/month to mm/day, we need to know
            % the number of days of the specific month
            nr_days = daysinmonth(j, fields{jan_ind(i) + j - 1, 2});
            % Adding the actual month to the yearly sum
            fld_sum = fld_sum + tmp/nr_days;
        end
        
        % Computing the number of cells with valid values
        % -> It is not possible to simply take the mean of every row as the
        % number of valid cells changes with latitude. Thus, we have to
        % divide the sum of the single elements by the number of valid
        % cells of a specific row to obtain the mean!
        % Furthermore, this step removes these latitudes, where not all
        % months of a specific year contain valid values to aviod an
        % estimate which is shifted towards a specific period of a year. 
        valid_cells = sum(mask,2);
        valid_cells(valid_cells < 10) = 0;
        valid_years(valid_cells ~= 0) = valid_years(valid_cells ~= 0) + 1;
        % Now we add the zonal values of the actual year 
        zon_val = zon_val + sum(fld_sum,2)./(valid_cells*12);        
    end
    
    zon_val = zon_val./valid_years;
    zon_val(valid_years == 0) = 0;
    zon_val(valid_cells <  15) = 0;
elseif strcmp(tscale, 'monthly')
    
    zon_val = zeros(360, 12);
    
    for i = 1:12
        % Look through the dataset to find all Januaries, Februaries, ...
        mnth_ind = find(cell2mat(fields(:, 1)) == i);
        
        % Defining a mask for global, continental or oceanic values
        mask = zeros(360, 720);
        
        if cswitch == 0
            mask = mask + 1;                    % All values          
        elseif cswitch == 1
            mask(continents ~= mval) = 1;           % Continental values        
        elseif cswitch == 2
            mask(continents == mval) = 1;      % Oceanic values
        elseif cswitch == 3
            mask(continents ~= mval) = 1;      % Without polar regions
            mask(continents == 4)    = 0;
        end
        
        fld_sum = zeros(360, 720);
        
        for j = 1:length(mnth_ind)
            % Storing the actual field in the tmp variable
            tmp = fields{mnth_ind(j), 3};            
            % Setting the elements of the mask to zero, where missing
            % values in the input dataset are present
            mask(tmp == mval) = 0;           
            % Computing a global/continental/oceanic field without missing
            % values
            tmp =  tmp.*mask;
            % For the conversion from mm/month to mm/day, we need to know
            % the number of days of the specific month
            nr_days = daysinmonth(j, fields{mnth_ind(j), 2});
            % Now we add the zonal values of the actual year 
            fld_sum = fld_sum + tmp/nr_days;
        end
        
        valid_cells = sum(mask,2);
        zon_val(:,i) = sum(fld_sum,2)./(valid_cells*length(mnth_ind));
        zon_val(valid_cells == 0, i) = NaN;
        zon_val(valid_cells < 15, i) = NaN;
    end
    
elseif strcmp(tscale, 'seasonal')
    % We want to compute the mean values for DJF, MAM, JJA and SON
    mnths = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    
    % Defining a mask for global, continental or oceanic values
	mask = zeros(360, 720);
        
	if cswitch == 0
        mask = mask + 1;                   % All values          
	elseif cswitch == 1
        mask(continents ~= mval) = 1;      % Continental values        
	elseif cswitch == 2
        mask(continents == mval) = 1;      % Oceanic values
    elseif cswitch == 3
        mask(continents ~= mval) = 1;      % Without polar regions
        mask(continents == 4)    = 0;
    end
        
	fld_sum = zeros(360, 720);
    
    % First, we need 
    for i = 1:12
        indices(:,i) = find(cell2mat(fields(:,1)) == mnths(i));
    end
    
    for i = 1:4
        fld_sum = zeros(360, 720);
        
        for j = 1:size(indices,1)
            
            for k = 1:3
                tmp = fields{indices(j,(i-1)*3+k),3};
                mask(tmp == mval) = 0;
                tmp = tmp.*mask;
                nr_days = daysinmonth(fields{indices(j,(i-1)*3+k),1}, ...
                                      fields{indices(j,(i-1)*3+k),2});
                fld_sum = fld_sum + tmp/nr_days;
                mask(tmp == mval) = 0;
            end
        end
       
        valid_cells = sum(mask,2);
        zon_val(:,i) = sum(fld_sum,2)./(valid_cells*j*3);
        zon_val(valid_cells == 0, i) = 0;
        zon_val(valid_cells < 15, i) = 0;
    end
end


        
    
    
        
        
        
        
        
    
        
        
        

        
    
    
    




