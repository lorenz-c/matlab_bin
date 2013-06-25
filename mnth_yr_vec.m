function [mnths, yrs] = mnth_yr_vec(smnth, syr, emnth, eyr);



if syr == eyr
    nts = emnth - smnth + 1;
else
    mnths_y1 = 12 - smnth + 1;
    mnths_y2 = emnth;
    
    nts = mnths_y1 + 12*(eyr - (syr + 1)) + mnths_y2;
end


mnths(1, 1) = smnth;
yrs(1, 1)   = syr;

for i = 2:nts
    mnths(i, 1) = mnths(i-1, 1) + 1;
    
    if mnths(i, 1) == 13
        mnths(i, 1) = 1;
        yrs(i, 1) = yrs(i-1, 1) + 1;
    else
        yrs(i, 1) = yrs(i-1, 1);
    end
end


