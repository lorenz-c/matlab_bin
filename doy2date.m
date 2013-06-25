function date = doy2date(doy, year);


l_year = [1980 1984 1988 1992 1996 2000 2004 2008 2012];

if find(l_year == year)
    n_feb  = 29;
else 
    n_feb  = 28;
end

n_days = [31 n_feb 31 30 31 30 31 31 30 31 30 31];

days_year = 0;

for i = 1:12
	days_month = 0;
	for j = 1:n_days(i)
        days_year = days_year + 1;
        if doy == days_year
            date = [doy j, i, year];
            break;
        end
    end
end            
        

