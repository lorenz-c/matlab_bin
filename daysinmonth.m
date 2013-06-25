function nr_days  =  daysinmonth(month, year)


l_year = [1980; 1984; 1988; 1992; 1996; 2000; 2004; 2008; 2012];

if find(year == l_year)
    n_feb = 29;
else
    n_feb = 28;
end

mnth31 = [1 3 5 7 8 10 12];
mnth30 = [4 6 9 11];

if find(month == mnth31)
    nr_days = 31;
elseif find(month == mnth30)
    nr_days = 30;
elseif month == 2 & find(year == l_year)
    nr_days = 29;
else
    nr_days = 28;
end


