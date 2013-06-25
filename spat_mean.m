function otpt = spat_mean(inpt, time, tscale, mval)

% This function computes the mean of a time-series of global fields of an
% arbitrary quantity. Therefore, it can compute a monthly mean (i.e. the
% mean of all Januaries etc.), an annual mean (i.e. the mean of all
% complete years) and a seasonal mean (i.e. the mean of winter, spring,
% summer and autumn).


sind = find(cell2mat(inpt(:,4)) == 1 & cell2mat(inpt(:,5)) == time(1));
eind = find(cell2mat(inpt(:,4)) == 12 & cell2mat(inpt(:,5)) == time(2));

% If we want to compute a seasonal mean, we need the December before 
% t_start and January + February after t_end
if strcmp(tscale, 'seasonal')    
    sind = sind - 1;
    eind = eind - 1;
end

fields = inpt(sind:eind,[4 5 9]);

 


% We won't need the other components of the input data so we can delete it
clear inpt

if strcmp(tscale, 'seasonal')
    mnths = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    for i = 1:12
        indices(:,i) = find(cell2mat(fields(:,1)) == mnths(i));
    end

    otpt = cell(1,4);
        
    for i = 1:4
        snl_mn = zeros(360, 720);
        mask   = ones(360, 720);
        for j = 1:size(indices,1)
            for k = 1:3
                nr_days = daysinmonth(fields{indices(j,(i-1)*3+k),1}, ...
                                      fields{indices(j,(i-1)*3+k),2});
                snl_mn = snl_mn + fields{indices(j,(i-1)*3+k),3}/nr_days;
                mask(fields{indices(j,(i-1)*3+k),3} == mval) = 0;
            end
        end
        otpt{1,i} = snl_mn/(3*size(indices,1));
        otpt{1,i}(mask == 0) = mval;
    end
    
elseif strcmp(tscale, 'annual')
    syear = fields{1,2};
    eyear = fields{end,2};
   
    otpt  = zeros(360, 720);
    mask = ones(360, 720);
    
    for t = syear:eyear
        indices = find(cell2mat(fields(:,2)) == t);
        tmp_mn = zeros(360, 720);
        
        for i = 1:12
            nr_days = daysinmonth(i, t);
            tmp_mn  = tmp_mn + fields{indices(i), 3}/nr_days;
            mask(fields{indices(i),3} == mval) = 0;
        end
        
        otpt = otpt + tmp_mn/12;
    end
    otpt = otpt/(eyear-syear);    
    otpt(mask == 0) = mval;
    
end
           
                            
                    

                    
    
    

