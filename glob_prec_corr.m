% load /media/storage/Data/Precipitation/GPCC/GPCC_PRECv4.0.mat
% load /media/storage/Data/Precipitation/GPCP/GPCP_PRECv2.1.mat
% 
% 
% gpcp_glob_ann = comp_glob_corr(gpcc_prec, gpcp_prec, [1989 2006], 1, 'annual', [4 5 9], -9999);
% gpcp_glob_mon = comp_glob_corr(gpcc_prec, gpcp_prec, [1989 2006],1, 'monthly', [4 5 9], -9999);
% 
% gpcp_nh_ann = comp_glob_corr(gpcc_prec, gpcp_prec, [1989 2006],4, 'annual', [4 5 9], -9999);
% gpcp_nh_mon = comp_glob_corr(gpcc_prec, gpcp_prec, [1989 2006],4, 'monthly', [4 5 9], -9999);
% 
% gpcp_sh_ann = comp_glob_corr(gpcc_prec, gpcp_prec, [1989 2006],5, 'annual', [4 5 9], -9999);
% gpcp_sh_mon = comp_glob_corr(gpcc_prec, gpcp_prec, [1989 2006],5, 'monthly', [4 5 9], -9999);
% 
% gpcp_trpc_ann = comp_glob_corr(gpcc_prec, gpcp_prec, [1989 2006],6, 'annual', [4 5 9], -9999);
% gpcp_trpc_mon = comp_glob_corr(gpcc_prec, gpcp_prec, [1989 2006],6, 'monthly', [4 5 9], -9999);
% 
% gpcp_cont_ann = comp_cont_corr(gpcc_prec, gpcp_prec, [1989 2006], 'annual', [7 6 3 8 9 1], [4 5 9], -9999);
% gpcp_cont_mon = comp_cont_corr(gpcc_prec, gpcp_prec, [1989 2006], 'monthly',  [7 6 3 8 9 1], [4 5 9], -9999);
% 
% 
% gpcp_ann(:,1) = gpcp_glob_ann(:,2);
% gpcp_ann(:,2) = gpcp_nh_ann(:,2);
% gpcp_ann(:,3) = gpcp_sh_ann(:,2);
% gpcp_ann(:,4) = gpcp_cont_ann(:,2);
% gpcp_ann(:,5) = gpcp_cont_ann(:,3);
% gpcp_ann(:,6) = gpcp_cont_ann(:,4);
% gpcp_ann(:,7) = gpcp_cont_ann(:,5);
% gpcp_ann(:,8) = gpcp_cont_ann(:,6);
% gpcp_ann(:,9) = gpcp_cont_ann(:,7);
% gpcp_ann(:,10) = gpcp_trpc_ann(:,2);
% 
% gpcp_mon(:,1) = gpcp_glob_mon(:,2);
% gpcp_mon(:,2) = gpcp_nh_mon(:,2);
% gpcp_mon(:,3) = gpcp_sh_mon(:,2);
% gpcp_mon(:,4) = gpcp_cont_mon(:,2);
% gpcp_mon(:,5) = gpcp_cont_mon(:,3);
% gpcp_mon(:,6) = gpcp_cont_mon(:,4);
% gpcp_mon(:,7) = gpcp_cont_mon(:,5);
% gpcp_mon(:,8) = gpcp_cont_mon(:,6);
% gpcp_mon(:,9) = gpcp_cont_mon(:,7);
% gpcp_mon(:,10) = gpcp_trpc_mon(:,2);
% clear *nhsh* *glob* *cont* gpcp_prec
% keyboard
% load /media/storage/Data/Precipitation/CRU3/CRU3_PRECv3.0.mat
% cru_glob_ann = comp_glob_corr(gpcc_prec,cru_prec, [1989 2006],1, 'annual', [4 5 9], -9999);
% cru_glob_mon = comp_glob_corr(gpcc_prec,cru_prec, [1989 2006],1, 'monthly', [4 5 9], -9999);
% 
% cru_nh_ann = comp_glob_corr(gpcc_prec,cru_prec, [1989 2006],4, 'annual', [4 5 9], -9999);
% cru_nh_mon = comp_glob_corr(gpcc_prec,cru_prec, [1989 2006],4, 'monthly', [4 5 9], -9999);
% 
% cru_sh_ann = comp_glob_corr(gpcc_prec,cru_prec, [1989 2006],5, 'annual', [4 5 9], -9999);
% cru_sh_mon = comp_glob_corr(gpcc_prec,cru_prec, [1989 2006],5, 'monthly', [4 5 9], -9999);
% 
% cru_trpc_ann = comp_glob_corr(gpcc_prec,cru_prec, [1989 2006],6, 'annual', [4 5 9], -9999);
% cru_trpc_mon = comp_glob_corr(gpcc_prec,cru_prec, [1989 2006],6, 'monthly', [4 5 9], -9999);
% 
% cru_cont_ann = comp_cont_corr(gpcc_prec,cru_prec, [1989 2006], 'annual', [7 6 3 8 9 1],[4 5 9], -9999);
% cru_cont_mon = comp_cont_corr(gpcc_prec,cru_prec, [1989 2006], 'monthly', [7 6 3 8 9 1],[4 5 9], -9999);
% 
% 
% cru_ann(:,1) = cru_glob_ann(:,2);
% cru_ann(:,2) = cru_nh_ann(:,2);
% cru_ann(:,3) = cru_sh_ann(:,2);
% cru_ann(:,4) = cru_cont_ann(:,2);
% cru_ann(:,5) = cru_cont_ann(:,3);
% cru_ann(:,6) = cru_cont_ann(:,4);
% cru_ann(:,7) = cru_cont_ann(:,5);
% cru_ann(:,8) = cru_cont_ann(:,6);
% cru_ann(:,9) = cru_cont_ann(:,7);
% cru_ann(:,10) = cru_trpc_ann(:,2);
% 
% cru_mon(:,1) = cru_glob_mon(:,2);
% cru_mon(:,2) = cru_nh_mon(:,2);
% cru_mon(:,3) = cru_sh_mon(:,2);
% cru_mon(:,4) = cru_cont_mon(:,2);
% cru_mon(:,5) = cru_cont_mon(:,3);
% cru_mon(:,6) = cru_cont_mon(:,4);
% cru_mon(:,7) = cru_cont_mon(:,5);
% cru_mon(:,8) = cru_cont_mon(:,6);
% cru_mon(:,9) = cru_cont_mon(:,7);
% cru_mon(:,10) = cru_trpc_mon(:,2);
% 
% clear *nhsh* *glob* *cont* cru_prec*


% load /media/storage/Data/Precipitation/CPC/CPC_PREC.mat
% cpc_glob_ann = comp_glob_corr(gpcc_prec, cpc_prec, [1989 2006],1, 'annual', [4 5 9], -9999);
% cpc_glob_mon = comp_glob_corr(gpcc_prec,cpc_prec, [1989 2006],1, 'monthly', [4 5 9], -9999);
% 
% cpc_nh_ann = comp_glob_corr(gpcc_prec,cpc_prec, [1989 2006],4, 'annual', [4 5 9], -9999);
% cpc_nh_mon = comp_glob_corr(gpcc_prec,cpc_prec, [1989 2006],4, 'monthly', [4 5 9], -9999);
% 
% cpc_sh_ann = comp_glob_corr(gpcc_prec,cpc_prec, [1989 2006],5, 'annual', [4 5 9], -9999);
% cpc_sh_mon = comp_glob_corr(gpcc_prec,cpc_prec, [1989 2006],5, 'monthly', [4 5 9], -9999);
% 
% cpc_trpc_ann = comp_glob_corr(gpcc_prec,cpc_prec, [1989 2006],6, 'annual', [4 5 9], -9999);
% cpc_trpc_mon = comp_glob_corr(gpcc_prec,cpc_prec, [1989 2006],6, 'monthly', [4 5 9], -9999);
% 
% cpc_cont_ann = comp_cont_corr(gpcc_prec,cpc_prec, [1989 2006], 'annual',[7 6 3 8 9 1], [4 5 9], -9999);
% cpc_cont_mon = comp_cont_corr(gpcc_prec,cpc_prec, [1989 2006], 'monthly', [7 6 3 8 9 1],[4 5 9], -9999);
% clear cpc_prec
% 
% 
% cpc_ann(:,1) = cpc_glob_ann(:,2);
% cpc_ann(:,2) = cpc_nh_ann(:,2);
% cpc_ann(:,3) = cpc_sh_ann(:,2);
% cpc_ann(:,4) = cpc_cont_ann(:,2);
% cpc_ann(:,5) = cpc_cont_ann(:,3);
% cpc_ann(:,6) = cpc_cont_ann(:,4);
% cpc_ann(:,7) = cpc_cont_ann(:,5);
% cpc_ann(:,8) = cpc_cont_ann(:,6);
% cpc_ann(:,9) = cpc_cont_ann(:,7);
% cpc_ann(:,10) = cpc_trpc_ann(:,2);
% 
% cpc_mon(:,1) = cpc_glob_mon(:,2);
% cpc_mon(:,2) = cpc_nh_mon(:,2);
% cpc_mon(:,3) = cpc_sh_mon(:,2);
% cpc_mon(:,4) = cpc_cont_mon(:,2);
% cpc_mon(:,5) = cpc_cont_mon(:,3);
% cpc_mon(:,6) = cpc_cont_mon(:,4);
% cpc_mon(:,7) = cpc_cont_mon(:,5);
% cpc_mon(:,8) = cpc_cont_mon(:,6);
% cpc_mon(:,9) = cpc_cont_mon(:,7);
% cpc_mon(:,10) = cpc_trpc_mon(:,2);
% 
% clear *nhsh* *glob* *cont*
% 
% load /media/storage/Data/Precipitation/ECMWF/ECMWF_PREC.mat
% ecmwf_glob_ann = comp_glob_corr(gpcc_prec,ecmwf_prec, [1989 2006],1, 'annual', [4 5 9], -9999);
% ecmwf_glob_mon = comp_glob_corr(gpcc_prec,ecmwf_prec, [1989 2006],1, 'monthly', [4 5 9], -9999);
% 
% ecmwf_nh_ann = comp_glob_corr(gpcc_prec,ecmwf_prec, [1989 2006],4, 'annual', [4 5 9], -9999);
% ecmwf_nh_mon = comp_glob_corr(gpcc_prec,ecmwf_prec, [1989 2006],4, 'monthly', [4 5 9], -9999);
% 
% ecmwf_sh_ann = comp_glob_corr(gpcc_prec,ecmwf_prec, [1989 2006],5, 'annual', [4 5 9], -9999);
% ecmwf_sh_mon = comp_glob_corr(gpcc_prec,ecmwf_prec, [1989 2006],5, 'monthly', [4 5 9], -9999);
% 
% ecmwf_trpc_ann = comp_glob_corr(gpcc_prec,ecmwf_prec, [1989 2006],6, 'annual', [4 5 9], -9999);
% ecmwf_trpc_mon = comp_glob_corr(gpcc_prec,ecmwf_prec, [1989 2006],6, 'monthly', [4 5 9], -9999);
% 
% ecmwf_cont_ann = comp_cont_corr(gpcc_prec,ecmwf_prec, [1989 2006], 'annual', [7 6 3 8 9 1],[4 5 9], -9999);
% ecmwf_cont_mon = comp_cont_corr(gpcc_prec,ecmwf_prec, [1989 2006], 'monthly', [7 6 3 8 9 1],[4 5 9], -9999);
% clear ecmwf_prec
% 
% 
% ecmwf_ann(:,1) = ecmwf_glob_ann(:,2);
% ecmwf_ann(:,2) = ecmwf_nh_ann(:,2);
% ecmwf_ann(:,3) = ecmwf_sh_ann(:,2);
% ecmwf_ann(:,4) = ecmwf_cont_ann(:,2);
% ecmwf_ann(:,5) = ecmwf_cont_ann(:,3);
% ecmwf_ann(:,6) = ecmwf_cont_ann(:,4);
% ecmwf_ann(:,7) = ecmwf_cont_ann(:,5);
% ecmwf_ann(:,8) = ecmwf_cont_ann(:,6);
% ecmwf_ann(:,9) = ecmwf_cont_ann(:,7);
% ecmwf_ann(:,10) = ecmwf_trpc_ann(:,2);
% 
% ecmwf_mon(:,1) = ecmwf_glob_mon(:,2);
% ecmwf_mon(:,2) = ecmwf_nh_mon(:,2);
% ecmwf_mon(:,3) = ecmwf_sh_mon(:,2);
% ecmwf_mon(:,4) = ecmwf_cont_mon(:,2);
% ecmwf_mon(:,5) = ecmwf_cont_mon(:,3);
% ecmwf_mon(:,6) = ecmwf_cont_mon(:,4);
% ecmwf_mon(:,7) = ecmwf_cont_mon(:,5);
% ecmwf_mon(:,8) = ecmwf_cont_mon(:,6);
% ecmwf_mon(:,9) = ecmwf_cont_mon(:,7);
% ecmwf_mon(:,10) = ecmwf_trpc_mon(:,2);
% 
% clear *nhsh* *glob* *cont*
% 
% load /media/storage/Data/Precipitation/MERRA/MERRA_PREC.mat
% merra_glob_ann = comp_glob_corr(gpcc_prec,merra_prec, [1989 2006],1, 'annual', [4 5 9], -9999);
% merra_glob_mon = comp_glob_corr(gpcc_prec,merra_prec, [1989 2006],1, 'monthly', [4 5 9], -9999);
% 
% merra_nh_ann = comp_glob_corr(gpcc_prec,merra_prec, [1989 2006],4, 'annual', [4 5 9], -9999);
% merra_nh_mon = comp_glob_corr(gpcc_prec,merra_prec, [1989 2006],4, 'monthly', [4 5 9], -9999);
% 
% merra_sh_ann = comp_glob_corr(gpcc_prec,merra_prec, [1989 2006],5, 'annual', [4 5 9], -9999);
% merra_sh_mon = comp_glob_corr(gpcc_prec,merra_prec, [1989 2006],5, 'monthly', [4 5 9], -9999);
% 
% merra_trpc_ann = comp_glob_corr(gpcc_prec,merra_prec, [1989 2006],6, 'annual', [4 5 9], -9999);
% merra_trpc_mon = comp_glob_corr(gpcc_prec,merra_prec, [1989 2006],6, 'monthly', [4 5 9], -9999);
% 
% merra_cont_ann = comp_cont_corr(gpcc_prec,merra_prec, [1989 2006], 'annual', [7 6 3 8 9 1],[4 5 9], -9999);
% merra_cont_mon = comp_cont_corr(gpcc_prec,merra_prec, [1989 2006], 'monthly', [7 6 3 8 9 1],[4 5 9], -9999);
% clear merra_prec
% 
% 
% merra_ann(:,1) = merra_glob_ann(:,2);
% merra_ann(:,2) = merra_nh_ann(:,2);
% merra_ann(:,3) = merra_sh_ann(:,2);
% merra_ann(:,4) = merra_cont_ann(:,2);
% merra_ann(:,5) = merra_cont_ann(:,3);
% merra_ann(:,6) = merra_cont_ann(:,4);
% merra_ann(:,7) = merra_cont_ann(:,5);
% merra_ann(:,8) = merra_cont_ann(:,6);
% merra_ann(:,9) = merra_cont_ann(:,7);
% merra_ann(:,10) = merra_trpc_ann(:,2);
% 
% merra_mon(:,1) = merra_glob_mon(:,2);
% merra_mon(:,2) = merra_nh_mon(:,2);
% merra_mon(:,3) = merra_sh_mon(:,2);
% merra_mon(:,4) = merra_cont_mon(:,2);
% merra_mon(:,5) = merra_cont_mon(:,3);
% merra_mon(:,6) = merra_cont_mon(:,4);
% merra_mon(:,7) = merra_cont_mon(:,5);
% merra_mon(:,8) = merra_cont_mon(:,6);
% merra_mon(:,9) = merra_cont_mon(:,7);
% merra_mon(:,10) = merra_trpc_mon(:,2);
% 
% clear *nhsh* *glob* *cont*
% 
% load /media/storage/Data/Precipitation/CFSR/CFSR_PREC.mat
% cfsr_glob_ann = comp_glob_corr(gpcc_prec,cfsr_prec, [1989 2006],1, 'annual', [4 5 9], -9999);
% cfsr_glob_mon = comp_glob_corr(gpcc_prec,cfsr_prec, [1989 2006],1, 'monthly', [4 5 9], -9999);
% 
% cfsr_nh_ann = comp_glob_corr(gpcc_prec,cfsr_prec, [1989 2006],4, 'annual', [4 5 9], -9999);
% cfsr_nh_mon = comp_glob_corr(gpcc_prec,cfsr_prec, [1989 2006],4, 'monthly', [4 5 9], -9999);
% 
% cfsr_sh_ann = comp_glob_corr(gpcc_prec,cfsr_prec, [1989 2006],5, 'annual', [4 5 9], -9999);
% cfsr_sh_mon = comp_glob_corr(gpcc_prec,cfsr_prec, [1989 2006],5, 'monthly', [4 5 9], -9999);
% 
% cfsr_trpc_ann = comp_glob_corr(gpcc_prec,cfsr_prec, [1989 2006],6, 'annual', [4 5 9], -9999);
% cfsr_trpc_mon = comp_glob_corr(gpcc_prec,cfsr_prec, [1989 2006],6, 'monthly', [4 5 9], -9999);
% 
% cfsr_cont_ann = comp_cont_corr(gpcc_prec,cfsr_prec, [1989 2006], 'annual', [7 6 3 8 9 1],[4 5 9], -9999);
% cfsr_cont_mon = comp_cont_corr(gpcc_prec,cfsr_prec, [1989 2006], 'monthly',[7 6 3 8 9 1], [4 5 9], -9999);
% clear cfsr_prec
% 
% 
% cfsr_ann(:,1) = cfsr_glob_ann(:,2);
% cfsr_ann(:,2) = cfsr_nh_ann(:,2);
% cfsr_ann(:,3) = cfsr_sh_ann(:,2);
% cfsr_ann(:,4) = cfsr_cont_ann(:,2);
% cfsr_ann(:,5) = cfsr_cont_ann(:,3);
% cfsr_ann(:,6) = cfsr_cont_ann(:,4);
% cfsr_ann(:,7) = cfsr_cont_ann(:,5);
% cfsr_ann(:,8) = cfsr_cont_ann(:,6);
% cfsr_ann(:,9) = cfsr_cont_ann(:,7);
% cfsr_ann(:,10) = cfsr_trpc_ann(:,2);
% 
% cfsr_mon(:,1) = cfsr_glob_mon(:,2);
% cfsr_mon(:,2) = cfsr_nh_mon(:,2);
% cfsr_mon(:,3) = cfsr_sh_mon(:,2);
% cfsr_mon(:,4) = cfsr_cont_mon(:,2);
% cfsr_mon(:,5) = cfsr_cont_mon(:,3);
% cfsr_mon(:,6) = cfsr_cont_mon(:,4);
% cfsr_mon(:,7) = cfsr_cont_mon(:,5);
% cfsr_mon(:,8) = cfsr_cont_mon(:,6);
% cfsr_mon(:,9) = cfsr_cont_mon(:,7);
% cfsr_mon(:,10) = cfsr_trpc_mon(:,2);
% 
% clear *nhsh* *glob* *cont*
% 
% 
% save corr_timeseries.mat 
% 
% 
% 
% text_str{1} = 'Global land';
% text_str{2} = 'Northern hemisphere';
% text_str{3} = 'Southern hemisphere';
% text_str{4} = 'North America';
% text_str{5} = 'South America';
% text_str{6} = 'Europe';
% text_str{7} = 'Africa';
% text_str{8} = 'Asia';
% text_str{9} = 'Australia';
% text_str{10} = '15S - 15N (Tropics)';
% 
% yrs{1} = ' ';
% yrs{2} = '1990';
% yrs{3} = ' ';
% yrs{4} = '1992 ';
% yrs{5} = ' ';
% yrs{6} = '1994 ';
% yrs{7} = ' ';
% yrs{8} = '1996 ';
% yrs{9} = ' ';
% yrs{10} = '1998 ';
% yrs{11} = ' ';
% yrs{12} = '2000';
% yrs{13} = ' ';
% yrs{14} = '2002 ';
% yrs{15} = ' ';
% yrs{16} = '2004 ';
% yrs{17} = ' ';
% yrs{18} = '2006 ';
% 
% mnths{1} = 'J';
% mnths{2} = 'F';
% mnths{3} = 'M';
% mnths{4} = 'A';
% mnths{5} = 'M';
% mnths{6} = 'J';
% mnths{7} = 'J';
% mnths{8} = 'A';
% mnths{9} = 'S';
% mnths{10} = 'O';
% mnths{11} = 'N';
% mnths{12} = 'D';
% 
% fnames_ann{1} = 'R_ann_glob_ts';
% fnames_ann{2} = 'R_ann_NH_ts';
% fnames_ann{3} = 'R_ann_SH_ts';
% fnames_ann{4} = 'R_ann_NA_ts';
% fnames_ann{5} = 'R_ann_SA_ts';
% fnames_ann{6} = 'R_ann_E_ts';
% fnames_ann{7} = 'R_ann_AF_ts';
% fnames_ann{8} = 'R_ann_AS_ts';
% fnames_ann{9} = 'R_ann_AU_ts';
% fnames_ann{10} = 'R_ann_TR_ts';
% 
% fnames_mon{1} = 'R_mon_glob_ts';
% fnames_mon{2} = 'R_mon_NH_ts';
% fnames_mon{3} = 'R_mon_SH_ts';
% fnames_mon{4} = 'R_mon_NA_ts';
% fnames_mon{5} = 'R_mon_SA_ts';
% fnames_mon{6} = 'R_mon_E_ts';
% fnames_mon{7} = 'R_mon_AF_ts';
% fnames_mon{8} = 'R_mon_AS_ts';
% fnames_mon{9} = 'R_mon_AU_ts';
% fnames_mon{10} = 'R_mon_TR_ts';

for i = 1:10
    h = figure('papersize', [4.5 4], 'paperunits', 'centimeters')
    plot(gpcp_ann(:,i), 'c', 'linewidth', 1.5);
    hold on
    plot(cru_ann(:,i), 'm', 'linewidth', 1.5);
    plot(cpc_ann(:,i), 'y', 'linewidth', 1.5);
    plot(ecmwf_ann(:,i), 'b', 'linewidth', 1.5);
    plot(merra_ann(:,i), 'r', 'linewidth', 1.5);
    plot(cfsr_ann(:,i), 'g', 'linewidth', 1.5);

    grid on
    axis([1 18 0.4 1]);
    set(gca, 'xtick', 1:1:18);
    set(gca, 'ytick', 0.4:0.1:1);
    set(gca, 'xticklabel', yrs, 'fontsize', 16);
    pbaspect([17 6 1]);
    
    
    text(2, 0.9, text_str{i} , 'fontsize', 20);
if i == 1
        leg = legend('GPCP', 'CRU', 'CPC', 'INTERIM', 'MERRA', 'CFSR', 'location','Best');
        set(leg, 'fontsize', 12)
        keyboard
    end
    print(h, '-depsc2', fnames_ann{i});
    clear h
    
    
    h = figure('papersize', [4.5 4], 'paperunits', 'centimeters')
    plot(gpcp_mon(:,i), 'c', 'linewidth', 1.5);
    hold on
    plot(cru_mon(:,i), 'm', 'linewidth', 1.5);
    plot(cpc_mon(:,i), 'y', 'linewidth', 1.5);
    plot(ecmwf_mon(:,i), 'b', 'linewidth', 1.5);
    plot(merra_mon(:,i), 'r', 'linewidth', 1.5);
    plot(cfsr_mon(:,i), 'g', 'linewidth', 1.5);

    grid on
    axis([1 12 0.4 1]);
    set(gca, 'xtick', 1:1:12);
    set(gca, 'ytick', 0.4:0.1:1);
    set(gca, 'xticklabel', mnths, 'fontsize', 16);
    pbaspect([12 6 1]);
    
   
    text(2, 0.9, text_str{i} , 'fontsize', 20);
    if i == 1
        leg = legend('GPCP', 'CRU', 'CPC', 'INTERIM', 'MERRA', 'CFSR', 'location','Best');
        set(leg, 'fontsize', 12)
        keyboard
    end
    print(h, '-depsc2', fnames_mon{i});
    clear h
    close all
end
























