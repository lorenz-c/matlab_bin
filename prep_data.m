function otpt = prep_data(inpt, time, clms, mval);


mnths = cell2mat(inpt(:, clms(1)));
yrs   = cell2mat(inpt(:, clms(2)));

sind = find(mnths == 1  & yrs == time(1));
eind = find(mnths == 12 & yrs == time(2));


otpt = inpt(sind:eind, clms(1:3));