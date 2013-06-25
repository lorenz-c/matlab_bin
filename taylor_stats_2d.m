function [R E sig] = taylor_stats_glob(r, cswitch, mval, varargin);

% Similar function like taylor_stats.m which allows two-dimensional fields
% as input quantities.


[rr cr] = size(r);

for k = 1:length(varargin)
    [rf cf] = size(varargin{k});
    if rr ~= rf | cr ~= cf
        error('Input fields must have the same dimension!')
    end
end

cell_area = area_wghts(0.25:0.5:179.75, 0.5);
cell_area = cell_area'*ones(1,720);

mask = gen_mask(cswitch);

mask(r == mval) = 0;
        
for i  = 1:length(varargin)
	% Set the value of any location which contains mval in a 
	% dataset to zero
	mask(varargin{i} == mval) = 0;
end
        
mask_ar = cell_area.*mask;
ar      = sum(sum(mask_ar));
mask_ar = mask_ar/ar;
mask_v  = mask_ar(mask == 1);
        
flds_vec(:,1) = r(mask == 1);
    
for i  = 1:length(varargin)
	flds_vec(:,i+1) = varargin{i}(mask == 1);
end
        
for i = 1:length(varargin)+1
	mn(1,i)  = mask_v'*flds_vec(:,i);
            
    if i == 1
        d1   = flds_vec(:,1) - mn(1,1);
    end
            
	d2 = flds_vec(:,i) - mn(1,i);
            
    sig(1,i) = sqrt(mask_v'.*d2'*d2);
    R(1,i)   = (mask_v'.*d1'*d2)/(sig(1,i)*sig(1,1));
    E(1,i)   = sqrt((mask_v'.*(d2-d1)'*(d2-d1)));
        
end
          
        clear flds_vec mask ar_wts ar_tot tmp n

    
elseif cswitch == 5
    
    for j = 1:11
        
        mask = mask_t;
        mask(continents ~= j) = 0;
        mask(r == mval) = 0;
        
        for i  = 1:length(varargin)
            % Set the value of any location which contains mval in a 
            % dataset to zero
            mask(varargin{i} == mval) = 0;
        end
        
        ar_wts = A.*mask;
        ar_tot = sum(sum(ar_wts));
        ar_wts = ar_wts/ar_tot;
        
        ar_wts2 = ar_wts(mask==1);
        
        flds_vec(:,1) = r(mask == 1);
    
        for i  = 1:length(varargin)
            tmp             = varargin{i};
            flds_vec(:,i+1) = tmp(mask == 1);
        end
        
        for i = 1:length(varargin)+1
            mn(j,i)  = ar_wts2'*flds_vec(:,i);
            
            if i == 1
                d1   = flds_vec(:,1) - mn(j,1);
            end
            
            d2       = flds_vec(:,i) - mn(j,i);
            
            sig(j,i) = sqrt(ar_wts2'.*d2'*d2);
            R(j,i)   = (ar_wts2'.*d1'*d2)/(sig(j,i)*sig(j,1));
            E(j,i)   = sqrt((ar_wts2'.*(d2-d1)'*(d2-d1)));
        
        end
          
        clear flds_vec mask ar_wts ar_tot tmp n
    end
end











