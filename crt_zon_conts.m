function [] = crt_zon_conts(set1, set2, set3, set4)
% 
% load /media/storage/Data/Precipitation/GPCP/GPCP_PRECv2.1.mat
% load /media/storage/Data/Precipitation/ECMWF/ECMWF_PREC.mat
% load /media/storage/Data/Precipitation/MERRA/MERRA_PREC.mat
% load /media/storage/Data/Precipitation/CFSR/CFSR_PREC01.mat
load /home/lorenz-c/Data/colormaps/precip_zonal.mat
% cf_zonal_glob = comp_zon_prec(cfsr_prec1, [4 5 9], [1979 2009], 0, 'mnth');
% ec_zonal_glob = comp_zon_prec(ecmwf_prec, [4 5 9], [1989 2009], 0, 'mnth');
% mr_zonal_glob = comp_zon_prec(merra_prec, [4 5 9], [1979 2009], 0, 'mnth');
% gp_zonal_glob = comp_zon_prec(gpcp_prec, [4 5 9], [1979 2009], 0, 'mnth');

v = 0:1:10;
t = 0.25:0.5:179.75;
x = 1:1:12;

tck{1} = '90S';
tck{2} = '60S';
tck{3} = '30S';
tck{4} = '0';
tck{5} = '30N';
tck{6} = '60N';
tck{7} = '90N';

xtck{1} = 'J';
xtck{2} = 'F';
xtck{3} = 'M';
xtck{4} = 'A';
xtck{5} = 'M';
xtck{6} = 'J';
xtck{7} = 'J';
xtck{8} = 'A';
xtck{9} = 'S';
xtck{10} = 'O';
xtck{11} = 'N';
xtck{12} = 'D';

c = figure;
set(c,'paperunits','centimeters')
set(c, 'papertype', 'a4');
set(c,'paperposition',[0.5,0.5,24,20])
set(c, 'paperorientation', 'landscape')

s1 = subplot(2,2,1, 'align')
contourf(x,t,flipud(set1), v, 'linestyle', 'none');
set(s1, 'ytick', 0:30:180);
set(s1, 'yticklabel', tck);
set(s1, 'xtick', 1:12);
set(s1, 'xticklabel', xtck);
colormap(precip_zonal)
title('GPCP')
axis([1 12 0 180])
pbaspect([2 1.5 1])

s2 = subplot(2,2,2, 'align')
contourf(x,t,flipud(set2), v, 'linestyle', 'none');
set(s2, 'ytick', 0:30:180);
set(s2, 'yticklabel', tck);
set(s2, 'xtick', 1:12);
set(s2, 'xticklabel', xtck);
colormap(precip_zonal)
title('ECMWF')
axis([1 12 0 180])
pbaspect([2 1.5 1])


s3 = subplot(2,2,3, 'align')
contourf(x,t,flipud(set3), v, 'linestyle', 'none');
set(s3, 'ytick', 0:30:180);
set(s3, 'yticklabel', tck);
set(s3, 'xtick', 1:12);
set(s3, 'xticklabel', xtck);
colormap(precip_zonal)
title('MERRA')
axis([1 12 0 180])
pbaspect([2 1.5 1])


s4 = subplot(2,2,4, 'align')
contourf(x,t,flipud(set4), v, 'linestyle', 'none');
set(s4, 'ytick', 0:30:180);
set(s4, 'yticklabel', tck);
set(s4, 'xtick', 1:12);
set(s4, 'xticklabel', xtck);
colormap(precip_zonal)
title('CFSR')
axis([1 12 0 180])
pbaspect([2 1.5 1])

