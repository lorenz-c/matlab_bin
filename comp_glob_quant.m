function s_agg = comp_glob_quant(inpt, time, cswitch, tscale, clms, mval, dimflg)

% The function computes the area averaged mean over the continents (cswitch = 1),
% over the oceans (cswitch = 2)
if nargin < 7
    dimflg = 1;
end

if nargin < 6
    mval = -9999;
end

if nargin < 5
    clms = [4 5 9];
end

if nargin < 4
    tscale = 'complete';
end

if nargin < 3
    cswitch = 0;
end

if cswitch > 0
    load continents.asc
end



sind = find(cell2mat(inpt(:,clms(1))) == 1   & ...
                                cell2mat(inpt(:,clms(2))) == time(1));
eind = find(cell2mat(inpt(:,clms(1))) == 12  & ...
                                cell2mat(inpt(:,clms(2))) == time(2));
fields = inpt(sind:eind, clms);


if strcmp(mval, 'NaN')
    for i = 1:length(fields)
        fields{i,3}(isnan(fields{i,3})) = -9999;
    end
    mval = -9999;
end


A = area_wghts(0.25:0.5:179.75, 0.5);
A = A';
A = A*ones(1,720);




% Computing a mask for the different setups
mask = gen_mask(cswitch);

if strcmp(tscale, 'complete')
    
    if dimflg == 1
        nrd = cellfun(@(x,y) daysinmonth(x,y), fields(:,1), fields(:,2));
    else
        nrd = 1;
    end
    
    s_agg(:,1) = cell2mat(fields(:,1));
    s_agg(:,2) = cell2mat(fields(:,2));
    
    s_agg(:,3) = cellfun(@(x) spat_agg(x, mask, mval, A), fields(:,3));
    s_agg(:,3) = s_agg(:,3)./nrd;
    
        
elseif strcmp(tscale, 'monthly')
    
    mnths = cell2mat(fields(:,1));
    
    s_agg = zeros(12, 2);

    for i = 1:12
        
        indx = find(mnths == i);
        
        if dimflg == 1
            nrd = cellfun(@(x,y) daysinmonth(x,y), fields(indx,1), ...
                                                   fields(indx,2));
        else
            nrd = 1;
        end
        
        tmp = cellfun(@(x) spat_agg(x, mask, mval, A), fields(indx,3));
        
        s_agg(i,1) = i;
        s_agg(i,2) = mean(tmp./nrd);
        
    end
    
elseif strcmp(tscale, 'annual')
    
    yrs   = cell2mat(fields(:,2));
    yrs_t = unique(yrs);
    
    for i = 1:length(yrs_t)
        indx = find(yrs == yrs_t(i));
        
        if dimflg == 1
            nrd = cellfun(@(x,y) daysinmonth(x,y), fields(indx,1), ...
                                                   fields(indx,2));
            nrd = sum(nrd);
        else
            nrd = 1;
        end
        
        tmp  = cellfun(@(x) spat_agg(x, mask, mval, A), fields(indx,3));
        s_agg(i,1) = yrs_t(i);
        s_agg(i,2) = mean(tmp./nrd);
    end
end
    
    
   

    
   
        
        
        
        
     
      
       
% elseif strcmp(tscale, 'seasonal_1')
%     j_indx = 1:12:length(fields);      % Index of all Januaries
%     n      = length(j_indx);
%     if cswitch < 6
%         glob_val = zeros(length(j_indx), 4);
%         
%         for i = 1:4
%             
%             for j = 1:n
%                 mask = mask_t;
%                 tmp  = zeros(360, 720);
%                 for k = 1:3
%                     nrd = daysinmonth(fields{j_indx(i)+j-1,1}, ...
%                                               fields{j_indx(i)+j-1,2});
%                     mask(fields{j_indx(i+k-1),3} == mval) = 0;
%                     tmp = tmp + mask.*fields{j_indx(i+k-1),3}/nrd;
%                 end
%                 ar_wts = A.*mask;
%                 ar_tot = sum(sum(ar_wts));
%                 
%                 glob_val(j,i) = sum(sum(ar_wts.*tmp))/ar_tot;
%             end
%             j_indx = j_indx + 3;
%         end
%     elseif cswitch == 6
%         
%         for i = 1:4
%         
%     end
%                 
%                     
%                 
%             
%     end
% end
% 
% 
%         
%         
%         
        
        
        
        
        
        
        
        
        
        
        
    
    




                            
                            
                            
                            
