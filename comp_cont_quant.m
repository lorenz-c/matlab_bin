function glob_val = comp_cont_quant(inpt, time, tscale, cindx, clms, mval, dimswitch)

% if nargin < 5
%     mval = -9999;
% end
% 
% if nargin < 4
%     clms = [4 5 9];
% end
% 
% if nargin < 3
%     tscale = 'complete';
% end
% 
% if nargin < 2
%     cswitch = 0;
% end


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

load continents.asc

% Computing the area of the pixels
A = area_wghts(0.25:0.5:179.75, 0.5);
A = A'*ones(1,720);

% Computing a mask for the different setups
mask_t = gen_mask(cswitch);


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
    
    glob_val = zeros(12, 13);
    glob_val(:,1) = 1:12;
    
    j_indx = 1:12:length(fields);
    
    for i = 1:12
     
        % Loop over all continents
        for j = 1:length(j_indx)
                      
            if dimswitch == 1
                nrd = daysinmonth(fields{j_indx(j)+i-1,1}, ...
                                                  fields{j_indx(j)+i-1,2});
            else 
                nrd = 1;
            end
                  
            for k = 1:length(cindx)
                
                mask = mask_t;
                mask(continents == cindx(k)) = 1;
                mask(fields{j_indx(j)+i-1,3} == mval) = 0;
                
                ar_wts = A.*mask;
                ar_tot = sum(sum(ar_wts)); 
                
                tmp  = fields{j_indx(j)+i-1,3}.*ar_wts;
                glob_val(i,k+1) = glob_val(i,k+1) + sum(sum(tmp))/(nrd*ar_tot);  

            end
        end
        glob_val(i,:) = glob_val(i,:)/length(j_indx);
    end

elseif strcmp(tscale, 'annual')
    
    j_indx = 1:12:length(fields);
    glob_val = zeros(length(j_indx), 13);
    
    for i = 1:length(j_indx)   
        glob_val(i,1) = fields{j_indx(i),2};
        
        for j = 1:12
            
            if dimswitch == 1
                nrd = daysinmonth(fields{j_indx(i)+j-1,1}, ...
                                              fields{j_indx(i)+j-1,2});
            else 
                nrd = 1;
            end
            
            for k = 1:length(cindx)
                mask = mask_t;
                mask(continents == cindx(k)) = 1;
                mask(fields{j_indx(i)+j-1,3} == mval) = 0;
                
                ar_wts = A.*mask;
                ar_tot = sum(sum(ar_wts));
                    
                tmp = fields{j_indx(i)+j-1,3}.*ar_wts;            
                glob_val(i,k+1) = glob_val(i,k+1) + sum(sum(tmp))/(ar_tot*nrd);
            end
        end
        glob_val(i, 2:end) = glob_val(i, 2:end)/12;
        
            
    end

   
            
            

                    
    
    
    
    
elseif strcmp(tscale, 'seasonal')
    glob_val = zeros(4, 12);
    j_indx = 1:12:length(fields);      % Index of all Januaries
    n      = length(j_indx);
    sns    = [1 2 3; 4 5 6; 7 8 9; 10 11 12];
    
    for i = 1:4                                  % Loop over the seasons
        
        for j = 1:n                              % Loop over the years
            
            for l = 1:3                          % Loop over the months
                if dimswitch == 1
                    nrd = daysinmonth(fields{j_indx(j)+sns(i,l)-1,1}, ...
                                      fields{j_indx(j)+sns(i,l)-1,2});
                else 
                    nrd = 1;
                end
                
                for k = 1:12                     % Loop over the continents
                    mask = mask_t;
                    mask(fields{j_indx(j)+sns(i,l)-1,3} == mval) = 0;
                    mask(continents == k-1) = 1;
                
                    ar_wts = A.*mask;
                    ar_tot = sum(sum(ar_wts));
                
                    tmp = fields{j_indx(j)+sns(i,l)-1,3}.*ar_wts;
                    
                    glob_val(i,k) = glob_val(i,k) + sum(sum(tmp))/(ar_tot*nrd);
                end
            end
        end
    end
    glob_val = glob_val/n;
                
end  
    
  
      
    
    


    
        
        
        
    
     







