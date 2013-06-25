clear all


% Ref 1
load /media/storage/Data/Precipitation/GPCC/GPCC_PRECv4.0.mat 
gpcc_mean_ann = spat_mean(gpcc_prec, [1989 2006], 'annual', -9999);
gpcc_mean_snl = spat_mean(gpcc_prec, [1990 2006], 'seasonal', -9999);

longi = gpcc_prec{1,8};
lati  = gpcc_prec{1,7};

clear gpcc_prec

% Ref 2
load /media/storage/Data/Precipitation/CPC/CPC_PREC.mat 
cpc_mean_ann = spat_mean(cpc_prec, [1989 2006], 'annual', -9999);
cpc_mean_snl = spat_mean(cpc_prec, [1990 2006], 'seasonal', -9999);
clear cpc_prec

% Reana 1
load /media/storage/Data/Precipitation/ECMWF/ECMWF_PREC.mat 
ecmwf_mean_ann = spat_mean(ecmwf_prec, [1989 2006], 'annual', -9999);
ecmwf_mean_snl = spat_mean(ecmwf_prec, [1990 2006], 'seasonal', -9999);
clear ecmwf_prec

% Reana 2
load /media/storage/Data/Precipitation/MERRA/MERRA_PREC.mat 
merra_mean_ann = spat_mean(merra_prec, [1989 2006], 'annual', -9999);
merra_mean_snl = spat_mean(merra_prec, [1990 2006], 'seasonal', -9999);
clear merra_prec

% Reana 3
load /media/storage/Data/Precipitation/CFSR/CFSR_PREC.mat 
cfsr_mean_ann = spat_mean(cfsr_prec, [1989 2006], 'annual', -9999);
cfsr_mean_snl = spat_mean(cfsr_prec, [1990 2006], 'seasonal', -9999);
clear cfsr_prec
% 
for i = 1:4    
    % Removing the missing values from GPCC in all datasets
    ecmwf_mean_snl{i}(gpcc_mean_snl{i} == -9999) = NaN;
    merra_mean_snl{i}(gpcc_mean_snl{i} == -9999) = NaN;
    cfsr_mean_snl{i}(gpcc_mean_snl{i} == -9999)  = NaN;
    cpc_mean_snl{i}(gpcc_mean_snl{i} == -9999)   = NaN;
    gpcc_mean_snl{i}(gpcc_mean_snl{i} == -9999) = NaN;
    % Removing the missing values from CPC in all datasets
    gpcc_mean_snl{i}(cpc_mean_snl{i} == -9999) = NaN;
    ecmwf_mean_snl{i}(cpc_mean_snl{i} == -9999) = NaN;
    merra_mean_snl{i}(cpc_mean_snl{i} == -9999) = NaN;
    cfsr_mean_snl{i}(cpc_mean_snl{i} == -9999) = NaN;
end


ecmwf_mean_ann(gpcc_mean_ann == -9999) = NaN;
merra_mean_ann(gpcc_mean_ann == -9999) = NaN;
cfsr_mean_ann(gpcc_mean_ann == -9999)  = NaN;
cpc_mean_ann(gpcc_mean_ann == -9999)   = NaN;
gpcc_mean_ann(gpcc_mean_ann == -9999)   = NaN;

gpcc_mean_ann(cpc_mean_ann == -9999)   = NaN;
ecmwf_mean_ann(cpc_mean_ann == -9999)  = NaN;
merra_mean_ann(cpc_mean_ann == -9999)  = NaN;
cfsr_mean_ann(cpc_mean_ann == -9999)   = NaN;

mask= zeros(360,720);
mask(gpcc_mean_ann == 0) = 1;
% Setting values equal zero to one to compute the relative differences
cpc_mean_ann(mask == 1)   = cpc_mean_ann(mask == 1) + 1;
ecmwf_mean_ann(mask == 1) = ecmwf_mean_ann(mask == 1) + 1;
merra_mean_ann(mask == 1) = merra_mean_ann(mask == 1) + 1;
cfsr_mean_ann(mask == 1)  = cfsr_mean_ann(mask == 1) + 1;
gpcc_mean_ann(mask == 1)  = 1;
% Computing the Differencess
cpc_diff_ann   = cpc_mean_ann   - gpcc_mean_ann;
ecmwf_diff_ann = ecmwf_mean_ann - gpcc_mean_ann;
merra_diff_ann = merra_mean_ann - gpcc_mean_ann;
cfsr_diff_ann  = cfsr_mean_ann  - gpcc_mean_ann;


cpc_rl_df_ann   = cpc_diff_ann./gpcc_mean_ann*100;
ecmwf_rl_df_ann = ecmwf_diff_ann./gpcc_mean_ann*100;
merra_rl_df_ann = merra_diff_ann./gpcc_mean_ann*100;
cfsr_rl_df_ann  = cfsr_diff_ann./gpcc_mean_ann*100;
 
cpc_diff_ann(isnan(gpcc_mean_ann))   = NaN;   
ecmwf_diff_ann(isnan(gpcc_mean_ann)) = NaN;   
merra_diff_ann(isnan(gpcc_mean_ann)) = NaN;   
cfsr_diff_ann(isnan(gpcc_mean_ann))  = NaN;   

cpc_rl_df_ann(isnan(gpcc_mean_ann))   = NaN;   
ecmwf_rl_df_ann(isnan(gpcc_mean_ann)) = NaN;   
merra_rl_df_ann(isnan(gpcc_mean_ann)) = NaN;   
cfsr_rl_df_ann(isnan(gpcc_mean_ann))  = NaN;   


cpc_mean_ann(mask == 1)   = cpc_mean_ann(mask == 1) - 1;
ecmwf_mean_ann(mask == 1) = ecmwf_mean_ann(mask == 1) - 1;
merra_mean_ann(mask == 1) = merra_mean_ann(mask == 1) - 1;
cfsr_mean_ann(mask == 1)  = cfsr_mean_ann(mask == 1) - 1;
gpcc_mean_ann(mask == 1)  = 0;

for i = 1:4

    mask(360,720);
    mask(gpcc_mean_snl{i} == 0) = 1;
    % Setting values equal zero to one to compute the relative differences
    cpc_mean_snl{i}(mask == 1)   = cpc_mean_snl{i}(mask == 1) + 1;
    ecmwf_mean_snl{i}(mask == 1) = ecmwf_mean_snl{i}(mask == 1) + 1;
    merra_mean_snl{i}(mask == 1) = merra_mean_snl{i}(mask == 1) + 1;
    cfsr_mean_snl{i}(mask == 1)  = cfsr_mean_snl{i}(mask == 1) + 1;
    gpcc_mean_snl{i}(mask == 1)  = 1;
    
    cpc_diff_snl{i}   = cpc_mean_snl{i}   - gpcc_mean_snl{i};
    ecmwf_diff_snl{i} = ecmwf_mean_snl{i} - gpcc_mean_snl{i};
    merra_diff_snl{i} = merra_mean_snl{i} - gpcc_mean_snl{i};
    cfsr_diff_snl{i}  = cfsr_mean_snl{i}  - gpcc_mean_snl{i};
    
    cpc_rl_df_snl{i}   = cpc_diff_snl{i}./gpcc_mean_snl{i}*100;
    ecmwf_rl_df_snl{i} = ecmwf_diff_snl{i}./gpcc_mean_snl{i}*100;
    merra_rl_df_snl{i} = merra_diff_snl{i}./gpcc_mean_snl{i}*100;
    cfsr_rl_df_snl{i}  = cfsr_diff_snl{i}./gpcc_mean_snl{i}*100;
    
    
    
    cpc_diff_snl{i}(isnan(gpcc_mean_snl{i})) = NaN;   
    ecmwf_diff_snl{i}(isnan(gpcc_mean_snl{i})) = NaN;   
    merra_diff_snl{i}(isnan(gpcc_mean_snl{i})) = NaN;   
    cfsr_diff_snl{i}(isnan(gpcc_mean_snl{i})) = NaN;   
    
    cpc_rl_df_snl{i}(isnan(gpcc_mean_snl{i})) = NaN;   
    ecmwf_rl_df_snl{i}(isnan(gpcc_mean_snl{i})) = NaN;   
    merra_rl_df_snl{i}(isnan(gpcc_mean_snl{i})) = NaN;   
    cfsr_rl_df_snl{i}(isnan(gpcc_mean_snl{i})) = NaN;  
    
    % Subtracting the previously added one
    cpc_mean_snl{i}(mask == 1) = cpc_mean_snl{i}(mask == 1) - 1;
    ecmwf_mean_snl{i}(mask == 1) = ecmwf_mean_snl{i}(mask == 1) - 1;
    merra_mean_snl{i}(mask == 1) = merra_mean_snl{i}(mask == 1) - 1;
    cfsr_mean_snl{i}(mask == 1) = cfsr_mean_snl{i}(mask == 1) - 1;
    gpcc_mean_snl{i}(mask == 1) = 0;
    
end


% Transforming the matices into the GMT-Format
sns{1} = 'DJF';
sns{2} = 'MAM';
sns{3} = 'JJA';
sns{4} = 'SON';

for i = 1:4
    fname = ['Absolute/gpcc_', sns{i}, '.txt'];
    tmp = grid2gmt(gpcc_mean_snl{i}, 0.5);
    save(fname, 'tmp', '-ASCII');
    
    fname = ['Absolute/cpc_', sns{i}, '.txt'];
    tmp = grid2gmt(cpc_mean_snl{i}, 0.5);
    save(fname, 'tmp', '-ASCII');
    
    fname = ['Differences/d_cpc_', sns{i}, '.txt'];
    tmp = grid2gmt(cpc_diff_snl{i}, 0.5);
    save(fname, 'tmp', '-ASCII');
    
    fname = ['Relative/d_rl_cpc_', sns{i}, '.txt'];
    tmp = grid2gmt(cpc_rl_df_snl{i}, 0.5);
    save(fname, 'tmp', '-ASCII');
    
    fname = ['Absolute/ecmwf_', sns{i}, '.txt'];
    tmp = grid2gmt(ecmwf_mean_snl{i}, 0.5);
    save(fname, 'tmp', '-ASCII');
    
    fname = ['Differences/d_ecmwf_', sns{i}, '.txt'];
    tmp = grid2gmt(ecmwf_diff_snl{i}, 0.5);
    save(fname, 'tmp', '-ASCII');
    
    fname = ['Relative/d_rl_ecmwf_', sns{i}, '.txt'];
    tmp = grid2gmt(ecmwf_rl_df_snl{i}, 0.5);
    save(fname, 'tmp', '-ASCII');
    
    fname = ['Absolute/merra_', sns{i}, '.txt'];
    tmp = grid2gmt(merra_mean_snl{i}, 0.5);
    save(fname, 'tmp', '-ASCII');
    
    fname = ['Differences/d_merra_', sns{i}, '.txt'];
    tmp = grid2gmt(merra_diff_snl{i}, 0.5);
    save(fname, 'tmp', '-ASCII');
    
    fname = ['Relative/d_rl_merra_', sns{i}, '.txt'];
    tmp = grid2gmt(merra_rl_df_snl{i}, 0.5);
    save(fname, 'tmp', '-ASCII');
    
    fname = ['Absolute/cfsr_', sns{i}, '.txt'];
    tmp = grid2gmt(cfsr_mean_snl{i}, 0.5);
    save(fname, 'tmp', '-ASCII');
    
    fname = ['Differences/d_cfsr_', sns{i}, '.txt'];
    tmp = grid2gmt(cfsr_diff_snl{i}, 0.5);
    save(fname, 'tmp', '-ASCII');
    
    fname = ['Relative/d_rl_cfsr_', sns{i}, '.txt'];
    tmp = grid2gmt(cfsr_rl_df_snl{i}, 0.5);
    save(fname, 'tmp', '-ASCII');
end

fname = ['Absolute/gpcc_ann.txt'];
tmp = grid2gmt(gpcc_mean_ann, 0.5);
save(fname, 'tmp', '-ASCII');

fname = ['Absolute/cpc_ann.txt'];
tmp = grid2gmt(cpc_mean_ann, 0.5);
save(fname, 'tmp', '-ASCII');

fname = ['Differences/d_cpc_ann.txt'];
tmp = grid2gmt(cpc_diff_ann, 0.5);
save(fname, 'tmp', '-ASCII');

fname = ['Relative/d_rl_cpc_ann.txt'];
tmp = grid2gmt(cpc_rl_df_ann, 0.5);
save(fname, 'tmp', '-ASCII');

fname = ['Absolute/ecmwf_ann.txt'];
tmp = grid2gmt(ecmwf_mean_ann, 0.5);
save(fname, 'tmp', '-ASCII');

fname = ['Differences/d_ecmwf_ann.txt'];
tmp = grid2gmt(ecmwf_diff_ann, 0.5);
save(fname, 'tmp', '-ASCII');

fname = ['Relative/d_rl_ecmwf_ann.txt'];
tmp = grid2gmt(ecmwf_rl_df_ann, 0.5);
save(fname, 'tmp', '-ASCII');

fname = ['Absolute/merra_ann.txt'];
tmp = grid2gmt(merra_mean_ann, 0.5);
save(fname, 'tmp', '-ASCII');

fname = ['Differences/d_merra_ann.txt'];
tmp = grid2gmt(merra_diff_ann, 0.5);
save(fname, 'tmp', '-ASCII');

fname = ['Relative/d_rl_merra_ann.txt'];
tmp = grid2gmt(merra_rl_df_ann, 0.5);
save(fname, 'tmp', '-ASCII');

fname = ['Absolute/cfsr_ann.txt'];
tmp = grid2gmt(cfsr_mean_ann, 0.5);
save(fname, 'tmp', '-ASCII');

fname = ['Differences/d_cfsr_ann.txt'];
tmp = grid2gmt(cfsr_diff_ann, 0.5);
save(fname, 'tmp', '-ASCII');

fname = ['Relative/d_rl_cfsr_ann.txt'];
tmp = grid2gmt(cfsr_rl_df_ann, 0.5);
save(fname, 'tmp', '-ASCII');



    
    

















% 

% gpcc_mean = spat_mean(gpcc_prec, [1990 1991], 'seasonal', -9999);



% load /media/storage/Data/Precipitation/ECMWF/ECMWF_PREC.mat
% 
% ecmwf_mean = spat_mean(ecmwf_prec, [1981 1995], 'annual', -9999);
% 
% clear ecmwf_prec*

% load /media/storage/Data/Precipitation/MERRA/MERRA_PREC2.mat
% 
% merra_mean = spat_mean(merra_prec, [1990 1991], 'annual', -9999);



% load /media/storage/Data/Precipitation/CFSR/CFSR_PREC.mat

% cfsr_mean = spat_mean(cfsr_prec, [1990 1991], 'seasonal', -9999);




% %     ecmwf_mean(gpcc_mean == -9999) = -9999;
% for i = 1:4
%     cfsr_mean{i} = cfsr_mean{i}/2;
%     cfsr_mean{i}(gpcc_mean{i} == -9999)  = -9999;
% %     merra_mean(gpcc_mean == -9999) = -9999;
% end

    
    
% ecmwf_rel = abs(ecmwf_mean - gpcc_mean)./gpcc_mean;
% merra_rel = abs(merra_mean - gpcc_mean)./gpcc_mean;
% cfsr_rel = abs(cfsr_mean - gpcc_mean)./gpcc_mean;

% 
% ecmwf_rel(gpcc_mean == -9999) = -9999;
% cfsr_rel(gpcc_mean == -9999) = -9999;
% merra_rel(gpcc_mean == -9999) = -9999;

% load coast
% load /home/lorenz-c/Data/colormaps/precip_cmap.mat
% load /home/lorenz-c/Data/colormaps/rel_precip_cmap.mat

% x4 = figure
% set(x4, 'papertype', 'a4')
% set(x4,'paperposition',[0.5,0.5,20,28])
% 
% subplot(2,2,1)
% imagesc(cfsr_prec{1,8}, cfsr_prec{1,7}, cfsr_mean{1}-gpcc_mean{1});
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([-5 5])
% title('GPCC')
% colormap(rel_precip_cmap)
% 
% subplot(2,2,2)
% imagesc(cfsr_prec{1,8}, cfsr_prec{1,7}, cfsr_mean{2}-gpcc_mean{2});
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([-5 5])
% title('GPCC')
% colormap(rel_precip_cmap)
% 
% subplot(2,2,3)
% imagesc(cfsr_prec{1,8}, cfsr_prec{1,7}, cfsr_mean{3}-gpcc_mean{3});
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([-5 5])
% title('GPCC')
% colormap(rel_precip_cmap)
% 
% subplot(2,2,4)
% imagesc(cfsr_prec{1,8}, cfsr_prec{1,7}, cfsr_mean{4}-gpcc_mean{4});
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([-5 5])
% title('GPCC')
% colormap(rel_precip_cmap)
% % 
% % subplot(4,1,2)
% % imagesc(cfsr_prec{1,8}, cfsr_prec{1,7}, ecmwf_mean);
% % axis xy
% % pbaspect([2 1 1])
% % hold on
% % plot(long, lat, 'k');
% % caxis([-1 12])
% % title('ECMWF')
% % colormap(precip_cmap)
% 
% subplot(3,1,2)
% imagesc(cfsr_prec{1,8}, cfsr_prec{1,7}, merra_mean);
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([0 750])
% title('MERRA')
% colormap(precip_cmap)
% 
% subplot(3,1,3)
% imagesc(cfsr_prec{1,8}, cfsr_prec{1,7}, cfsr_mean);
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([0 750])
% title('CFSR')
% colormap(precip_cmap)
% 
% 
% x3 = figure
% set(x3, 'papertype', 'a4')
% set(x3,'paperposition',[0.5,0.5,20,28])
% 
% % subplot(2,1,1)
% % imagesc(cfsr_prec{1,8}, cfsr_prec{1,7}, ecmwf_mean - gpcc_mean);
% % axis xy
% % pbaspect([2 1 1])
% % hold on
% % plot(long, lat, 'k');
% % caxis([-5 5])
% % title('ECMWF - GPCC')
% % colormap(rel_precip_cmap)
% 
% subplot(2,1,1)
% imagesc(cfsr_prec{1,8}, cfsr_prec{1,7}, merra_mean - gpcc_mean);
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([-250 250])
% title('MERRA - GPCC')
% colormap(rel_precip_cmap)
% 
% subplot(2,1,2)
% imagesc(cfsr_prec{1,8}, cfsr_prec{1,7}, cfsr_mean - gpcc_mean);
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([-250 250])
% title('CFSR - GPCC')
% colormap(rel_precip_cmap)



% x2 = figure
% set(x2, 'papertype', 'a4')
% set(x2,'paperposition',[0.5,0.5,20,28])
% 
% subplot(3,1,1)
% imagesc(cfsr_prec1{1,8}, cfsr_prec1{1,7}, ecmwf_rel);
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([0 1])
% title('ECMWF - GPCC, rel')
% colormap(precip_cmap)
% 
% subplot(3,1,2)
% imagesc(cfsr_prec1{1,8}, cfsr_prec1{1,7}, merra_rel);
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([0 1])
% title('MERRA - GPCC, rel')
% colormap(precip_cmap)
% 
% subplot(3,1,3)
% 
% imagesc(cfsr_prec1{1,8}, cfsr_prec1{1,7}, cfsr_rel);
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([0 1])
% title('CFSR - GPCC, rel')
% colormap(precip_cmap)




% subplot(4,1,4)
% imagesc(cfsr_prec1{1,8}, cfsr_prec1{1,7}, cfsr_mean{2});
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([-1 12])
% title('CFSR, MAM')
% colormap(precip_cmap)



% x1 = figure
% set(x1, 'papertype', 'a4')
% set(x1,'paperposition',[0.5,0.5,18,26])
% 
% subplot(4,1,1)
% imagesc(cfsr_prec1{1,8}, cfsr_prec1{1,7}, gpcc_mean{3});
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([-1 12])
% title('GPCC, JJA')
% colormap(precip_cmap)
% 
% subplot(4,1,2)
% imagesc(cfsr_prec1{1,8}, cfsr_prec1{1,7}, ecmwf_mean{3});
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([-1 12])
% title('ECMWF, JJA')
% colormap(precip_cmap)
% 
% subplot(4,1,3)
% imagesc(cfsr_prec1{1,8}, cfsr_prec1{1,7}, merra_mean{3});
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([-1 12])
% title('MERRA, JJA')
% colormap(precip_cmap)
% 
% subplot(4,1,4)
% imagesc(cfsr_prec1{1,8}, cfsr_prec1{1,7}, cfsr_mean{3});
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([-1 12])
% title('CFSR, JJA')
% colormap(precip_cmap)
% 
% 
% 
% 
% 
% x2 = figure
% set(x2, 'papertype', 'a4')
% set(x2,'paperposition',[0.5,0.5,18,26])
% 
% subplot(4,1,1)
% imagesc(cfsr_prec1{1,8}, cfsr_prec1{1,7}, gpcc_mean{4});
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([-1 12])
% title('GPCC, SON')
% colormap(precip_cmap)
% 
% subplot(4,1,2)
% imagesc(cfsr_prec1{1,8}, cfsr_prec1{1,7}, ecmwf_mean{4});
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([-1 12])
% title('ECMWF, SON')
% colormap(precip_cmap)
% 
% subplot(4,1,3)
% imagesc(cfsr_prec1{1,8}, cfsr_prec1{1,7}, merra_mean{4});
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([-1 12])
% title('MERRA, SON')
% colormap(precip_cmap)
% 
% subplot(4,1,4)
% imagesc(cfsr_prec1{1,8}, cfsr_prec1{1,7}, cfsr_mean{4});
% axis xy
% pbaspect([2 1 1])
% hold on
% plot(long, lat, 'k');
% caxis([-1 12])
% title('CFSR, SON')
% colormap(precip_cmap)
% % clr = colorbar('southoutside')
% % set(get(clr, 'xlabel'), 'String', '[mm/day]')

