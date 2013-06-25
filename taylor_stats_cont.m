function [R E sig] = taylor_stats_cont(r, obs, contindx, mval);

% Similar function like taylor_stats.m which allows two-dimensional fields
% as input quantities.


[rr cr] = size(r);
[ro co] = size(obs);

if rr ~= ro | cr ~= co
     error('Input fields must have the same dimension!')
end
    
if strcmp(mval, 'NaN')
    r(isnan(r)) = -9999;
    obs(isnan(obs)) = -9999;
    mval = -9999;
end

cell_area = area_wghts(0.25:0.5:179.75, 0.5);
cell_area = cell_area'*ones(1,720);

load continents.asc

 for i = 1:contindx
    mask = zeros(360, 720);
    mask(continents == contindx(i)) = 1;
    mask(r == mval) = 0;
    mask(obs == mval) = 0;
    
    mask_ar = cell_area.*mask;
    ar      = sum(sum(mask_ar));
    mask_ar = mask_ar/ar;
    mask_v  = mask_ar(mask == 1);

    r_vec  = r(mask == 1);
    
    for j  = 1:length(obs)
        f_vec = obs{i}(mask == 1);
        mn    = mask_v'*f_vec;
        if i == 1
            d1 = r - mn;
        end
        d2 = f_vec - mn;
        sig(j,i) = sqrt(mask_v'.*d2'*d2);
        R(j,i)   = (mask_v'.*d1'*d2)/(sig(1,i)*sig(1,1));
        E(j,i)  = sqrt((mask_v'.*(d2-d1)'*(d2-d1)));
    end
end
          

    
