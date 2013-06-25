% function [] = crt_zonal_plts
load /home/lorenz-c/Data/colormaps/precip_zonal.mat

ytck{1} = '90S';
ytck{2} = '70S';
ytck{3} = '50S';
ytck{4} = '30S';
ytck{5} = '10S';
ytck{6} = '10N';
ytck{7} = '30N';
ytck{8} = '50N';
ytck{8} = '70N';
ytck{8} = '50N';
ytck{9} = '70N';
ytck{10} = '90N';


xtck{1}='J';
xtck{2}='F';
xtck{3}='M';
xtck{4}='A';
xtck{5}='M';
xtck{6}='J';
xtck{7}='J';
xtck{8}='A';
xtck{9}='S';
xtck{10}='O';
xtck{11}='N';
xtck{12}='D';





load /media/storage/Data/Precipitation/GPCC/GPCC_PRECv4.0.mat
gpcc_zon_ann = comp_zon_quant(gpcc_prec, [1989 2006], 3, 'annual');
gpcc_zon_snl = comp_zon_quant(gpcc_prec, [1990 2006], 3, 'seasonal');
gpcc_zon_mnt = comp_zon_quant(gpcc_prec, [1989 2006], 3, 'monthly');
clear gpcc_prec

gpcc{1} = gpcc_zon_ann;
gpcc{2} = gpcc_zon_snl;
gpcc{3} = gpcc_zon_mnt;
gpcc{3} = [gpcc{3}(:,12) gpcc{3}(:, 1:12) gpcc{3}(:,1)];
clear gpcc_zon*


c = figure
contourf(flipud(gpcc{1,3}), 0:1:9, 'linestyle', 'none')
caxis([0 9])
set(gca, 'xtick', 1.5:1:13.5)
set(gca, 'xticklabel', xtck, 'fontsize', 14)
set(gca, 'ytick', 0:40:360)
set(gca, 'yticklabel', ytck, 'fontsize', 14)
axis([1 14 80 320])
colormap(precip_zonal)
pbaspect([14 6 1])
grid on
print -depsc gpcc_zonal.eps
close(c)
sprintf('GPCC done')

load /media/storage/Data/Precipitation/CPC/CPC_PREC.mat
cpc_zon_ann = comp_zon_quant(cpc_prec, [1989 2006], 3, 'annual');
cpc_zon_snl = comp_zon_quant(cpc_prec, [1990 2006], 3, 'seasonal');
cpc_zon_mnt = comp_zon_quant(cpc_prec, [1989 2006], 3, 'monthly');
clear cpc_prec

cpc{1} = cpc_zon_ann;
cpc{2} = cpc_zon_snl;
cpc{3} = cpc_zon_mnt;
cpc{3} = [cpc{3}(:,12) cpc{3}(:, 1:12) cpc{3}(:,1)];

clear cpc_zon*
c = figure
contourf(flipud(cpc{1,3}), 0:1:9, 'linestyle', 'none')
caxis([0 9])
set(gca, 'xtick', 1.5:1:13.5)
set(gca, 'xticklabel', xtck, 'fontsize', 14)
set(gca, 'ytick', 0:40:360)
set(gca, 'yticklabel', ytck, 'fontsize', 14)
axis([1 14 80 320])
colormap(precip_zonal)
pbaspect([14 6 1])
grid on
print -depsc2 cpc_zonal.eps
close(c)
sprintf('CPC done')

load /media/storage/Data/Precipitation/CRU3/CRU3_PRECv3.0.mat
cru_zon_ann = comp_zon_quant(cru_prec, [1989 2006], 3, 'annual');
cru_zon_snl = comp_zon_quant(cru_prec, [1990 2006], 3, 'seasonal');
cru_zon_mnt = comp_zon_quant(cru_prec, [1989 2006], 3, 'monthly');
clear cru_prec

cru{1} = cru_zon_ann;
cru{2} = cru_zon_snl;
cru{3} = cru_zon_mnt;
cru{3} = [cru{3}(:,12) cru{3}(:, 1:12) cru{3}(:,1)];

clear cru_zon*
c = figure
contourf(flipud(cru{1,3}), 0:1:9, 'linestyle', 'none')
caxis([0 9])
set(gca, 'xtick', 1.5:1:13.5)
set(gca, 'xticklabel', xtck, 'fontsize', 14)
set(gca, 'ytick', 0:40:360)
set(gca, 'yticklabel', ytck, 'fontsize', 14)
axis([1 14 80 320])
colormap(precip_zonal)
pbaspect([14 6 1])
grid on
print -depsc2 cru_zonal.eps
close(c)
sprintf('CRU done')

load /media/storage/Data/Precipitation/CFSR/CFSR_PREC.mat
cfsr_zon_ann = comp_zon_quant(cfsr_prec, [1989 2006], 3, 'annual');
cfsr_zon_snl = comp_zon_quant(cfsr_prec, [1990 2006], 3, 'seasonal');
cfsr_zon_mnt = comp_zon_quant(cfsr_prec, [1989 2006], 3, 'monthly');
clear cfsr_prec

cfsr{1} = cfsr_zon_ann;
cfsr{2} = cfsr_zon_snl;
cfsr{3} = cfsr_zon_mnt;
cfsr{3} = [cfsr{3}(:,12) cfsr{3}(:, 1:12) cfsr{3}(:,1)];
clear cfsr_zon*

c = figure
contourf(flipud(cfsr{1,3}), 0:1:9, 'linestyle', 'none')
caxis([0 9])
set(gca, 'xtick', 1.5:1:13.5)
set(gca, 'xticklabel', xtck, 'fontsize', 14)
set(gca, 'ytick', 0:40:360)
set(gca, 'yticklabel', ytck, 'fontsize', 14)
axis([1 14 80 320])
colormap(precip_zonal)
pbaspect([14 6 1])
grid on
print -depsc2 cfsr_zonal.eps
close(c)
sprintf('CFSR done')

load /media/storage/Data/Precipitation/MERRA/MERRA_PREC.mat
merra_zon_ann = comp_zon_quant(merra_prec, [1989 2006], 3, 'annual');
merra_zon_snl = comp_zon_quant(merra_prec, [1990 2006], 3, 'seasonal');
merra_zon_mnt = comp_zon_quant(merra_prec, [1989 2006], 3, 'monthly');
clear merra_prec

merra{1} = merra_zon_ann;
merra{2} = merra_zon_snl;
merra{3} = merra_zon_mnt;
merra{3} = [merra{3}(:,12) merra{3}(:, 1:12) merra{3}(:,1)];
clear merra_zon*
c = figure
contourf(flipud(merra{1,3}), 0:1:9, 'linestyle', 'none')
caxis([0 9])
set(gca, 'xtick', 1.5:1:13.5)
set(gca, 'xticklabel', xtck, 'fontsize', 14)
set(gca, 'ytick', 0:40:360)
set(gca, 'yticklabel', ytck, 'fontsize', 14)
axis([1 14 80 320])
colormap(precip_zonal)
pbaspect([14 6 1])
grid on
f = colorbar('southoutside')
set(get(f, 'xlabel'), 'string', '[mm/day]')
set(f, 'fontsize', 14)

print -depsc2 merra_zonal.eps
close(c)
sprintf('MERRA done')

load /media/storage/Data/Precipitation/ECMWF/ECMWF_PREC.mat
ecmwf_zon_ann = comp_zon_quant(ecmwf_prec, [1989 2006], 3, 'annual');
ecmwf_zon_snl = comp_zon_quant(ecmwf_prec, [1990 2006], 3, 'seasonal');
ecmwf_zon_mnt = comp_zon_quant(ecmwf_prec, [1989 2006], 3, 'monthly');
clear ecmwf_prec

ecmwf{1} = ecmwf_zon_ann;
ecmwf{2} = ecmwf_zon_snl;
ecmwf{3} = ecmwf_zon_mnt;
ecmwf{3} = [ecmwf{3}(:,12) ecmwf{3}(:, 1:12) ecmwf{3}(:,1)];
clear ecmwf_zon*
c = figure
contourf(flipud(ecmwf{1,3}), 0:1:9, 'linestyle', 'none')
caxis([0 9])
set(gca, 'xtick', 1.5:1:13.5)
set(gca, 'xticklabel', xtck, 'fontsize', 14)
set(gca, 'ytick', 0:40:360)
set(gca, 'yticklabel', ytck, 'fontsize', 14)
axis([1 14 80 320])
colormap(precip_zonal)
pbaspect([14 6 1])
grid on
print -depsc2 ecmwf_zonal.eps
close(c)
sprintf('ECMWF done')




% c = figure
% 
% set(c,'paperunits','centimeters')
% set(c, 'papertype', 'a4');
% set(c,'paperposition',[0.5,2,20,25]) 

% indx = 1:360;
% 
tck{1} = '90N';
tck{2} = '45N';
tck{3} = '0N';
tck{4} = '45S';
tck{5} = '90S';


% ttle{1}  = 'January';
% ttle{2}  = 'February';
% ttle{3}  = 'March';
% ttle{4}  = 'April';
% ttle{5}  = 'May';
% ttle{6}  = 'June';
% ttle{7}  = 'July';
% ttle{8}  = 'August';
% ttle{9}  = 'September';
% ttle{10} = 'October';
% ttle{11} = 'November';
% ttle{12} = 'December';

% figure
% plot(indx, gpcc_zon_ann, 'k');
% hold on
% plot(indx, cpc_zon_ann, '--k');
% plot(indx, ecmwf_zon_ann, 'Color', [0.5 0.5 0.5]);
% plot(indx, merra_zon_ann, '--', 'color', [0.5 0.5 0.5]);
% plot(indx, cfsr_zon_ann, '-.', 'color', [0.5 0.5 0.5]);
% 
% set(gca, 'xtick', 0:90:360)
% set(gca, 'xticklabel', tck)

 
% end
%     
%     if i == 10 | i == 11 | i == 12
%         xlabel('Latitude')
%         set(gca, 'xticklabel', tck)
%     else
%         set(gca, 'xticklabel', ' ')
%     end
%     
% %     if i == 3
% %         legend('GPCC', 'CRU', 'DEL', 'CPC', 'ECMWF', 'MERRA', 'CFSR')
% %     end
%     
%     axis([0 360 0 2])
%     grid on
%     hold off
% end
% 
% print('-depsc', '-r300', 'zonal_mnth_prec')
    
    
    
    