function vimfd_mnth = mmstommmonth(vimfd_s)

lyear = [2000 2004 2008 2012];

vimfd_mnth = vimfd_s;

for i = 1:length(vimfd_s)
    if vimfd_s{i,1} == 1 || vimfd_s{i,1} == 3 || vimfd_s{i,1} == 5 ...
            || vimfd_s{i,1} == 7  || vimfd_s{i,1} == 8 ...
            || vimfd_s{i,1} == 10 || vimfd_s{i,1} == 12
        days = 31;
    elseif vimfd_s{i,1} == 4 || vimfd_s{i,1} == 6  || vimfd_s{i,1} == 9 ...
            || vimfd_s{i,1} == 11
        days = 30;
    elseif vimfd_s{i,1} == 2 && max(vimfd_s{i,2} == lyear) == 0
        days = 29;
    elseif vimfd_s{i,1} == 2 && max(vimfd_s{i,2} == lyear) == 1
        days = 28;
    end

    vimfd_mnth{i,3} = vimfd_mnth{i,3}*3600*24*days;
end
        