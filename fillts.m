function tsb = fillts(inpt, clms);

mnths = inpt(:, clms(1));
yrs   = inpt(:, clms(2));
ts    = inpt(:, clms(3));

% 1. Find missing months
mflg = mnths(2:end) - mnths(1:end-1);

missing = find(mflg ~= 1 & mflg ~= -11);

ts_n = [];

for i = 1:length(missing)
    if i == 1
        tmp = ts(1:missing(1));    % ts until the missing element
        if mflg(missing(i)) > 0     % missing element during the year
            rep = ones(mflg(missing(i))-1,1)*NaN;
        elseif mflg(missing(i)) < 0
            rep = ones(11 + mflg(missing(i)),1)*NaN;
        end
        ts_n = [tmp; rep];  
        
    elseif i == length(missing)
        tmp = ts(missing(i-1)+1:missing(i));
        if mflg(missing(i)) > 0    % missing element during the year
            rep = ones(mflg(missing(i))-1,1)*NaN;
        elseif mflg(missing(i)) < 0
            rep = ones(11 + mflg(missing(i)),1)*NaN;
        end
        ts_n = [ts_n; tmp; rep; ts(missing(i)+1:end)];
        
    else
        tmp = ts(missing(i-1)+1:missing(i));
        if mflg(missing(i)) > 0    % missing element during the year
            rep = ones(mflg(missing(i))-1,1)*NaN;
        elseif mflg(missing(i)) < 0
            rep = ones(11 + mflg(missing(i)),1)*NaN; 
        end
        ts_n = [ts_n; tmp; rep];  
    end   
end

mn_n = zeros(size(ts_n));
yr_n = zeros(size(ts_n));
snr = zeros(size(ts_n));

mn_n(1) = mnths(1);
yr_n(1) = yrs(1);
snr(1)  = datenum(yrs(1), mnths(1), 15);

for i = 2:length(ts_n)
    mn_n(i) = mn_n(i-1) + 1;
    yr_n(i) = yr_n(i-1);
    
    if mn_n(i) == 13
        mn_n(i) = 1;
        yr_n(i) = yr_n(i) + 1;
    end
    snr(i) = datenum(yr_n(i), mn_n(i), 15);
end

tsb = [mn_n yr_n snr ts_n];
