function R = nanrmse(fld1, fld2);


fld1(isnan(fld2)) = NaN;

if size(fld2) > 1
    fld2(isnan(fld1)) = NaN;
end


mask = zeros(size(fld1));

mask(~isnan(fld1)) = 1;
nr_obs = sum(mask);


R = sqrt(1./nr_obs.*nansum((fld1 - fld2).^2));





