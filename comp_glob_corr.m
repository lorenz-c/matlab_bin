function [R E sig] = comp_glob_corr(inpt1, inpt2, time, tscale, cswitch, clms, mval)

% The function computes the area averaged mean over the continents (cswitch = 1),
% over the oceans (cswitch = 2)

% if nargin < 6
%     mval = -9999;
% end
% 
% if nargin < 5
%     clms = [4 5 9];
% end
% 
% if nargin < 4
%     tscale = 'complete';
% end
% 
% if nargin < 3
%     cswitch = 0;
% end


sindx1 = find(cell2mat(inpt1(:,clms(1))) == 1   & ...
                                cell2mat(inpt1(:,clms(2))) == time(1));
eindx1 = find(cell2mat(inpt1(:,clms(1))) == 12  & ...
                                cell2mat(inpt1(:,clms(2))) == time(2));

sindx2 = find(cell2mat(inpt2(:,clms(1))) == 1   & ...
                                cell2mat(inpt2(:,clms(2))) == time(1));
eindx2 = find(cell2mat(inpt2(:,clms(1))) == 12  & ...
                                cell2mat(inpt2(:,clms(2))) == time(2));                            

fields = cell(eindx1-sindx1+1, 4);
fields(:, 1:3) = inpt1(sindx1:eindx1, clms);
fields(:, 4) = inpt2(sindx2:eindx2, clms(3));
clear inpt*

if strcmp(mval, 'NaN')
    for i = 1:length(fields)
        fields{i,3}(isnan(fields3{i,3})) = -9999;
        fields{i,4}(isnan(fields3{i,3})) = -9999;        
    end
    mval = -9999;
end

A = area_wghts(0.25:0.5:179.75, 0.5);
A = A'*ones(1,720);

% Computing a mask for the different setups
mask_t = gen_mask(cswitch);


if strcmp(tscale, 'complete')
    R = zeros(length(fields), 3);
    
    R(:,1) = cell2mat(fields(:,1));
    R(:,2) = cell2mat(fields(:,2));
    
    E = R;
    sig = R;
    
    [R(:,3) E(:,3), sig(:,3)] = cellfun(@(x,y) spat_agg_corr(x,y, mask_t, mval, A), ...
                                    fields(:,3), fields(:,4));
elseif strcmp(tscale, 'monthly')
    
    R = zeros(12, 2);
    R(:,1) = 1:12;
    
    E = R;
    sig = R;
    
    for i = 1:12
        indx = find(cell2mat(fields(:,1)) == i);
        [tmp_r tmp_e tmp_sig] = cellfun(@(x,y) spat_agg_corr(x,y, ...
                       mask_t, mval, A), fields(indx, 3), fields(indx, 4));
        R(i,2) = mean(tmp_r);
        E(i,2) = mean(tmp_e);
        sig(i,2) = mean(tmp_sig);
    end
    
elseif strcmp(tscale, 'annual')
    
    j_indx = 1:12:length(fields);
    R = zeros(length(j_indx), 2);
    
    E = R;
    sig = R;
    
    for i = 1:length(j_indx)   
        indx = find(cell2mat(fields(:,2)) == fields{j_indx(i),2});
        [tmp_r tmp_e tmp_sig]  = cellfun(@(x,y) spat_agg_corr(x,y, ...
                       mask_t, mval, A), fields(indx, 3), fields(indx, 4));
                   
        R(i,1) = fields{j_indx(i),2};  
        E(i,1) = fields{j_indx(i),2};  
        sig(i,1) = fields{j_indx(i),2};  
        
        R(i,2) = mean(tmp_r);
        E(i,2) = mean(tmp_e);
        sig(i,2) = mean(tmp_sig);
        
    end
     
elseif strcmp(tscale, 'monthly_s')
    
    R = zeros(12, length(fields)/12+1);
    R(:,1) = 1:12;
    
    E = R;
    sig = R;
    
    for i = 1:12
        indx = find(cell2mat(fields(:,1)) == i);
        [tmp_r tmp_e tmp_sig] = cellfun(@(x,y) spat_agg_corr(x,y, ...
                       mask_t, mval, A), fields(indx, 3), fields(indx, 4));
        R(i,2:end) = tmp_r';
        E(i,2:end) = tmp_e';
        sig(i,2:end) = tmp_sig';
    end
end

