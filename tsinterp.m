function tsb = tsinterp(inpt, clms, interpflg);

mn  = inpt(:, clms(1));
yr  = inpt(:, clms(2));
ts  = inpt(:, clms(3));

if strcmp(interpflg, 'monmean')
    pstn = find(isnan(ts));
    tsb = ts;
    for i = 1:pstn
        mn_indx = find(mn(pstn(i)) == mn);
        flg = isfinite(ts(mn_indx));
        mn_vals = ts(mn_indx(flg ~= 0));
        tsb(pstn(i)) = mean(mn_vals);
    end
    
    
elseif strcmp(interpflg, 'interpol')
    
    pstn = find(~isnan(ts));
    tsn  = ts(~isnan(ts));
    
    tsb(:,1)  = interp1(pstn, tsn, 1:length(ts));
end

srn = datenum(yr, mn, ones(length(mn),1)*15);

tsb = [mn yr srn tsb];

        



 