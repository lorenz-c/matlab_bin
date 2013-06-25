function Z = ztransform(inpt, frmt)


if strcmp(frmt, 'full')
    fld  = inpt(2:end, 4:end);
else
    fld  = inpt;
end

sdev = nanstd(fld);
mn   = nanmean(fld);
nts  = length(fld(:,1));

Z    = (fld - ones(nts, 1)*mn)./(ones(nts,1)*sdev);


if strcmp(frmt, 'full')
    Z = [inpt(1, :); inpt(2:end, 1:3) Z];
end

    
    
    