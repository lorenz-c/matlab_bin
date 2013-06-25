function [zonal_prec] = comp_zon_prec(inpt, time, cswitch, tscale)

clms = [4 5 9];

if nargin < 4
    tscale = 'mnth';
end

if cswitch == 1 | cswitch == 2
    load continents.asc
end


yrs = time(1):1:time(2);

sind = find(cell2mat(inpt(:,4)) == 1   &  cell2mat(inpt(:,5)) == time(1));
eind = find(cell2mat(inpt(:,4)) == 12  &  cell2mat(inpt(:,5)) == time(2));

if strcmp(tscale, 'yr')
    
    jan_ind = sind:12:eind;

    for i = 1:length(jan_ind)
        
        mask = zeros(360, 720);
      
        if cswitch == 0
            mask = mask + 1;           
        elseif cswitch == 1
            mask(continents > -9999) = 1;
        elseif cswitch == 2
            mask(continents == -9999) = 1;
        end

    
        yr_sum = zeros(360, 720);
    
        for j = 1:12
        
            tmp = inpt{jan_ind(i) + j - 1, 9};
            mask(tmp == -9999) = 0;
            tmp =  tmp.*mask;
            nr_days = daysinmonth(j, inpt{jan_ind(i) + j - 1, 5});
            yr_sum = yr_sum + tmp/nr_days;

        end

        valid_cells = sum(mask,2);
        zonal_prec_tmp(:,i) = sum(yr_sum,2)./(valid_cells*12);
 
    end
    
    zonal_prec = mean(zonal_prec_tmp,2);
    zonal_prec(valid_cells == 0) = 0;
    
elseif strcmp(tscale, 'mnth')
    zonal_prec = zeros(360, 12);
    
    tmp_fields = inpt(sind:eind,:);
    
    for i = 1:12
        
        % Searching through the data to find the indices of all identical
        % months
        mnth_ind = find(cell2mat(tmp_fields(:, 4)) == i);
        
        % Creating a matrix with zeros, in which the sums of the monthly
        % values will be stored 
        mnth_sum = zeros(360, 720);
        
        % If only continental values are desired, the mask filters out the
        % values over the oceans
        mask = zeros(360, 720);
      
        if cswitch == 0
            mask = mask + 1;           
        elseif cswitch == 1
            mask(continents > -9999) = 1;
        elseif cswitch == 2
            mask(continents == -9999) = 1;
        end
        
        for j = 1:length(mnth_ind)
            tmp = tmp_fields{mnth_ind(j), 9};
            mask(tmp == -9999) = 0;
            tmp =  tmp.*mask;
            
            % Computing the days of the considered month for the conversion
            % of [mm/month] to [mm/day]
            nr_days = daysinmonth(i, tmp_fields{mnth_ind(j), 5});
            
            mnth_sum = mnth_sum + tmp/nr_days;
        end
        
        % Computing the number of cells with valid values
        % -> It is not possible to simply take the mean of every row as the
        % number of valid cells changes with latitude. Thus, we have to
        % divide the sum of the single elements by the number of valid
        % cells of a specific row to obtain the mean!
        valid_cells = sum(mask,2);
       
        zonal_prec(:,i) = sum(mnth_sum,2)./(valid_cells*length(mnth_ind));
        zonal_prec(valid_cells == 0, i) = 0;
                        
    end
    
elseif strcmp(tscale, 'season')
    mnths = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    
    mask = zeros(360, 720);
      
    if cswitch == 0
        mask = mask + 1;           
    elseif cswitch == 1
        mask(continents > -9999) = 1;
	elseif cswitch == 2
        mask(continents == -9999) = 1;
	end
        
    for i = 1:12
        indices(:,i) = find(cell2mat(inpt(:,4)) == mnths(i));
    end
    
    zonal_prec = zeros(360,4);
    
    for i = 1:4
        snl_mn = zeros(360, 720);
 
        for j = 1:size(indices,1)
            for k = 1:3
                nr_days = daysinmonth(fields{indices(j,(i-1)*3+k),1}, ...
                                      fields{indices(j,(i-1)*3+k),2});
                snl_mn = snl_mn + inpt{indices(j,(i-1)*3+k),3}/nr_days;
                mask(inpt{indices(j,(i-1)*3+k),3} == mval) = 0;
            end
        end
        valid_cells = sum(mask,2);
        zonal_prec_tmp = snl_mn/(3*size(indices,1));

    end
    
    
    
end

            
            
        
        
    
    


        




   

