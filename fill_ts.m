function TS_out = fill_ts(ts_in, ref_vec, tscale)

if nargin < 3, tscale = 'monthly'; end
if nargin < 2
    
    if strcmp(tscale, 'monthly')
        ref_vec = dtevec([ts_in(1,1), ts_in(1,2)], ...
                         [ts_in(end,1) ts_in(end,2)], ...
                         'monthly');
           
    elseif strcmp(tscale, 'daily')
        ref_vec = dtevec([ts_in(1,1) ts_in(1,2) ts_in(1,3)], ...
                         [ts_in(end,1) ts_in(end,2) ts_in(end,3)], ...
                         'daily');     

        
    end
end

num_indx = size(ref_vec, 2);


ts_dte = ts_in(:,num_indx);
TS_out = zeros(length(ref_vec), size(ts_in, 2));

for i = 1:length(ref_vec)
    if find(ts_dte == ref_vec(i,num_indx));
        indx(i,1) = find(ts_dte == ref_vec(i,num_indx));
    else
        indx(i,1) = NaN;
	end
end

for i = 1:length(indx)
    TS_out(i, 1:num_indx)   = ref_vec(i, :);
	if ~isnan(indx(i))
        TS_out(i, num_indx+1:end) = ts_in(indx(i), num_indx+1:end);
    else        
        TS_out(i, num_indx+1:end) = zeros(1, size(ts_in, 2)-num_indx)*NaN;
    end
end
    


        