function [corrs corr] = glob_corr(set1, set2)
% The function computes a global map (corrs) where the different catchments
% show the correlation between set1 and set2. It can thus be used for a
% rough global comparison of two datasets.
% Therefore, both sets must be given as [405 x 3] structure variables in 
% the following form:
% set = {'ctchmnt_name', 'ctchmnt_id', time_series}
% The time series must be given as [n x 3] vector with the following
% elements:
% time_series = [month year signal_value]
% The function automatically determines the dataset with the least values
% and computes the correlation only in the overlapping time period. The
% ctchmnt_ids must agree with the ids in the global indexfile.asc


load indexfile3.asc
corrs = zeros(360,720);


r1 = size(set1{1,3},1);
r2 = size(set2{1,3},1);
r3 = size(set1, 1);

mx = min([r1 r2]);

for i = 1:r3
    tmp1    = set1{i,3}(1:mx,3);
    tmp2    = set2{i,3}(1:mx,3);

    mn_s1(i)   = mean(tmp1);
    mn_s2(i)   = mean(tmp2);
    
    dv_s1   = tmp1 - mn_s1(i);
    dv_s2   = tmp2 - mn_s2(i);
    
    sdv_s1  = sqrt(1/mx*(dv_s1'*dv_s1));
    sdv_s2  = sqrt(1/mx*(dv_s2'*dv_s2));
    
    corr(i) = (dv_s1'*dv_s2)/((mx-1)*(sdv_s1*sdv_s2));
    
    if corr(i) > 1
        corr(i) = 1;
    elseif corr(i) < -1
        corr(i) = -1;
    end
    
    corrs(indexfile3 == set1{i,2}) = corr(i);
end

    
    




