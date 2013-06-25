function mnthnms = mnthnms(stle)


if nargin < 1
    stle = 'short';
end

if strcmp(stle, 'long')
    mnthnms{1,1} = 'January';
    mnthnms{2,1} = 'February';
    mnthnms{3,1} = 'March';
    mnthnms{4,1} = 'April';
    mnthnms{5,1} = 'May';
    mnthnms{6,1} = 'June';
    mnthnms{7,1} = 'July';
    mnthnms{8,1} = 'August';
    mnthnms{9,1} = 'September';
    mnthnms{10,1} = 'October';
    mnthnms{11,1} = 'November';
    mnthnms{12,1} = 'December';
elseif strcmp(stle, 'short')
    mnthnms{1,1} = 'Jan';
    mnthnms{2,1} = 'Feb';
    mnthnms{3,1} = 'Mar';
    mnthnms{4,1} = 'Apr';
    mnthnms{5,1} = 'May';
    mnthnms{6,1} = 'Jun';
    mnthnms{7,1} = 'Jul';
    mnthnms{8,1} = 'Aug';
    mnthnms{9,1} = 'Sep';
    mnthnms{10,1} = 'Oct';
    mnthnms{11,1} = 'Nov';
    mnthnms{12,1} = 'Dec';
elseif strcmp(stle, 'vshort')
    mnthnms{1,1} = 'J';
    mnthnms{2,1} = 'F';
    mnthnms{3,1} = 'M';
    mnthnms{4,1} = 'A';
    mnthnms{5,1} = 'M';
    mnthnms{6,1} = 'J';
    mnthnms{7,1} = 'J';
    mnthnms{8,1} = 'A';
    mnthnms{9,1} = 'S';
    mnthnms{10,1} = 'O';
    mnthnms{11,1} = 'N';
    mnthnms{12,1} = 'D';
elseif strcmp(stle, 'ssnl')
    mnthnms{1,1} = 'DJF';
    mnthnms{2,1} = 'MAM';
    mnthnms{3,1} = 'JJA';
    mnthnms{4,1} = 'SON';
end


    
    