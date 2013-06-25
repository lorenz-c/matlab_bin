function otpt = agg_glbwrf(inpt, varname, period, avswitch)


time = nj_varget(inpt, 'time');

for i = 1:length(time)
	tmp   = int2str(time(i));
	yr(i,:) = str2num(tmp(1:4));
	mn(i,:) = str2num(tmp(5:6));
    dy(i,:) = str2num(tmp(7:8));
	hr(i,:) = str2num(tmp(9:10));
    dta{i} = flipud(nj_varget(inpt, varname, [i 1 1], [1 inf inf]));
end


if strcmp(period, 'daily')
    days = unique([yr mn dy], 'rows');
    for i = 1:size(days,1)
        indx = find(dy == days(i,3));
        otpt{i} = 0;
        for j = 1:length(indx)
            otpt{i} = otpt{i} + dta{indx(j)};
        end
        if avswitch == 1
            otpt{i} = otpt{i}/length(indx);
        end
    end
    
elseif strcmp(period, 'monthly')
    mnths = unique([yr mn], 'rows');
	for i = 1:size(mnths,1)
        indx = find(mn == mnths(i,2));
        otpt{i} = 0;
        for j = 1:length(indx)
            otpt{i} = otpt{i} + dta{indx(j)};
        end
        if avswitch == 1
            otpt{i} = otpt{i}/length(indx);
        end
    end
    
end
    
    
        
    
   
            
            
    
    
    

    
    
    

