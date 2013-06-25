function ddt = wcdiff(inpt, clms, mval, wghts)

if nargin < 3
    mval = -9999;
end

if nargin < 2
    clms = [3 4 8];
end

mnths = cell2mat(inpt(:, clms(:,1)));
yrs   = cell2mat(inpt(:, clms(:,2)));
inpt  = inpt(:, clms(3));

if wghts == 1
    for i = 1:length(inpt)
        if i == 1
            dom_fw = eomday(yrs(i+1), mnths(i+1));
            dom_bw = eomday(yrs(i), mnths(i));
            ddt{i,1} = (inpt{i+1}/dom_fw - inpt{i}/dom_bw)*dom_bw;
        elseif i == length(inpt)
            dom_fw = eomday(yrs(end), mnths(end));
            dom_bw = eomday(yrs(end-1), mnths(end-1));
            ddt{i,1} = (inpt{end}/dom_fw - inpt{end-1}/dom_bw)*dom_fw;
        else
            dom_fw = eomday(yrs(i+1), mnths(i+1));
            dom_bw = eomday(yrs(i-1), mnths(i-1));
            dom_c  = eomday(yrs(i), mnths(i));
            ddt{i,1} = (inpt{i+1}/dom_fw - inpt{i-1}/dom_bw)/2*dom_c;
        end
        ddt{i,1}(inpt{i} == mval) = mval;
    end
    
else
    
    for i = 1:length(inpt)
        if i == 1
            ddt{i,1} = inpt{i+1} - inpt{i};
        elseif i == length(inpt)
            ddt{i,1} = inpt{end} - inpt{end-1};
        else
            ddt{i,1} = (inpt{i+1} - inpt{i-1})/2;
        end
        ddt{i,1}(inpt{i} == mval) = mval;
    end
end

    
    
        