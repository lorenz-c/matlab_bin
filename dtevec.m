function dte    = dtevec(sdte, edte, tscale)

if nargin < 3, tscale = 'monthly'; end

if length(sdte) == 3
    dte   = zeros(1,4);
    sday  = sdte(1);
    smnth = sdte(2);
    syr   = sdte(3);    
elseif length(sdte) == 2
    dte = zeros(1,2);
    smnth = sdte(1);
    syr   = sdte(2);
    
    if strcmp(tscale, 'monthly')
        sday  = 15;
    elseif strcmp(tscale, 'daily')
        sday  = 1;
    end
    

end


if length(edte) == 3
    eday  = edte(1);
    emnth = edte(2);
    eyr   = edte(3);    
elseif length(edte) == 2
    emnth = edte(1);
    eyr   = edte(2);
	if strcmp(tscale, 'monthly')
        eday  = 15;
    elseif strcmp(tscale, 'daily')
        eday  = eomday(eyr, emnth);
    end

end

k = 1; 

snum   = datenum(syr, smnth, sday);
yr     = syr;
mnth   = smnth;
day    = sday;

enum   = datenum(eyr, emnth, eday);

actnum = snum;

if strcmp(tscale, 'monthly')
    while actnum <= enum
        dte(k, 1) = mnth;
        dte(k, 2) = yr;
        dte(k, 3) = actnum;
    
        mnth = mnth + 1;
    
        if mnth == 13
            mnth = 1;
            yr   = yr + 1;
        end
    
        actnum = datenum(yr, mnth, 15);
        k = k + 1;
    end
elseif strcmp(tscale, 'daily')
    while actnum <= enum
        dte(k, 1) = day;
        dte(k, 2) = mnth;
        dte(k, 3) = yr;
        dte(k, 4) = actnum;
        
        day = day + 1;
        
        if day > eomday(yr, mnth)
            day = 1;
            mnth = mnth + 1;
            
            if mnth == 13
                mnth = 1;
                yr   = yr + 1;
            end
        end
        actnum = datenum(yr, mnth, day);
        k = k + 1;
    end
end



