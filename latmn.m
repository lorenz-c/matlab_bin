function Sig_lat = latmn(inpt, mval)
    
if ~isnan(mval)
    for i = 1:length(inpt)
        inpt{i}(inpt{i} == mval) = NaN;
    end
end

for i = 1:length(inpt)
    tmp = nanmean(inpt{i}, 2);
    tmp(isnan(tmp)) = [];
    Sig_lat(:,i) = tmp;
end