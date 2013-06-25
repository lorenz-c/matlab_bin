function [mnth_ts ann_ts] = crt_glob_ts(inpt, ts, clms)





mnth = cell2mat(inpt(:,clms(1)));
yr   = cell2mat(inpt(:,clms(2)));

sind = find(mnth == 1  & yr == ts(1));
eind = find(mnth == 12 & yr == ts(2));


inpt = inpt(sind:eind,[clms(1) clms(2) clms(3)]);


load /media/storage/Data/LANDSEA/GPCC_LSM.mat
lm_prec = spataggmn(inpt, gpcc_lsm, 1, 'clms', [1 2 3], 'method', 'wmean');

mask = gpcc_lsm;
mask(181:end,:)           = 0;
nh_prec = spataggmn(inpt, mask, 1, 'clms', [1 2 3], 'method', 'wmean');

mask = gpcc_lsm;
mask(1:180,:)             = 0;
sh_prec = spataggmn(inpt, mask, 1, 'clms', [1 2 3], 'method', 'wmean');

mask = gpcc_lsm;
mask(1:149, :)            = 0;      %  Remove all gridpoints > 15°N
mask(212:end, :)          = 0;
tr_prec = spataggmn(inpt, mask, 1, 'clms', [1 2 3], 'method', 'wmean');



load continents.asc
cont_prec = spataggmn(inpt, continents, [7 6 3 8 9 1], 'clms', [1 2 3], 'method', 'wmean');


mnthly_ts = [lm_prec(2:end, 1:4) nh_prec(2:end,4) sh_prec(2:end,4) tr_prec(2:end,4) cont_prec(2:end, 4:end)];

mnth = mnthly_ts(:,1);
yr   = mnthly_ts(:,2);

for i = 1:length(mnth)
    nrd = eomday(yr(i), mnth(i));
    mnthly_ts(i,4:end) = mnthly_ts(i,4:end)/nrd;
end

ann_ts  = tsmean(mnthly_ts, 'annual', 'clms', [1 2 4], 'method', 'twmean');
mnth_ts = tsmean(mnthly_ts, 'monthly', 'clms', [1 2 4]);




