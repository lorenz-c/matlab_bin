% load /media/storage/Data/Precipitation/GPCC/GPCC_PRECv4.0.mat
% gpcc_glob_ann = comp_glob_quant(gpcc_prec, [1989 2006],1, 'annual', [4 5 9], -9999, 1);
% gpcc_glob_mon = comp_glob_quant(gpcc_prec, [1989 2006],1, 'monthly', [4 5 9], -9999, 1);
% 
% gpcc_nhsh_ann = comp_glob_quant(gpcc_prec, [1989 2006],4, 'annual', [4 5 9], -9999, 1);
% gpcc_nhsh_mon = comp_glob_quant(gpcc_prec, [1989 2006],4, 'monthly', [4 5 9], -9999, 1);
% 
% gpcc_trpc_ann = comp_glob_quant(gpcc_prec, [1989 2006],5, 'annual', [4 5 9], -9999, 1);
% gpcc_trpc_mon = comp_glob_quant(gpcc_prec, [1989 2006],5, 'monthly', [4 5 9], -9999, 1);
% 
% gpcc_cont_ann = comp_cont_quant(gpcc_prec, [1989 2006], 'annual', [7 6 3 8 9 1], [4 5 9], -9999, 1);
% gpcc_cont_mon = comp_cont_quant(gpcc_prec, [1989 2006], 'monthly',  [7 6 3 8 9 1], [4 5 9], -9999, 1);
% clear gpcc_prec
% 
% 
% gpcc_ann(:,1) = gpcc_glob_ann(:,2);
% gpcc_ann(:,2) = gpcc_nhsh_ann(:,2);
% gpcc_ann(:,3) = gpcc_nhsh_ann(:,3);
% gpcc_ann(:,4) = gpcc_cont_ann(:,2);
% gpcc_ann(:,5) = gpcc_cont_ann(:,3);
% gpcc_ann(:,6) = gpcc_cont_ann(:,4);
% gpcc_ann(:,7) = gpcc_cont_ann(:,5);
% gpcc_ann(:,8) = gpcc_cont_ann(:,6);
% gpcc_ann(:,9) = gpcc_cont_ann(:,7);
% gpcc_ann(:,10) = gpcc_trpc_ann(:,2);
% 
% gpcc_mon(:,1) = gpcc_glob_mon(:,2);
% gpcc_mon(:,2) = gpcc_nhsh_mon(:,2);
% gpcc_mon(:,3) = gpcc_nhsh_mon(:,3);
% gpcc_mon(:,4) = gpcc_cont_mon(:,2);
% gpcc_mon(:,5) = gpcc_cont_mon(:,3);
% gpcc_mon(:,6) = gpcc_cont_mon(:,4);
% gpcc_mon(:,7) = gpcc_cont_mon(:,5);
% gpcc_mon(:,8) = gpcc_cont_mon(:,6);
% gpcc_mon(:,9) = gpcc_cont_mon(:,7);
% gpcc_mon(:,10) = gpcc_trpc_mon(:,2);
% 
% clear *nhsh* *glob* *cont*
% 
% load /media/storage/Data/Precipitation/GPCP/GPCP_PRECv2.1.mat
% gpcp_glob_ann = comp_glob_quant(gpcp_prec, [1989 2006],1, 'annual', [4 5 9], -9999, 1);
% gpcp_glob_mon = comp_glob_quant(gpcp_prec, [1989 2006],1, 'monthly', [4 5 9], -9999, 1);
% 
% gpcp_nhsh_ann = comp_glob_quant(gpcp_prec, [1989 2006],4, 'annual', [4 5 9], -9999, 1);
% gpcp_nhsh_mon = comp_glob_quant(gpcp_prec, [1989 2006],4, 'monthly', [4 5 9], -9999, 1);
% 
% gpcp_trpc_ann = comp_glob_quant(gpcp_prec, [1989 2006],5, 'annual', [4 5 9], -9999, 1);
% gpcp_trpc_mon = comp_glob_quant(gpcp_prec, [1989 2006],5, 'monthly', [4 5 9], -9999, 1);
% 
% gpcp_cont_ann = comp_cont_quant(gpcp_prec, [1989 2006], 'annual', [7 6 3 8 9 1],[4 5 9], -9999, 1);
% gpcp_cont_mon = comp_cont_quant(gpcp_prec, [1989 2006], 'monthly', [7 6 3 8 9 1],[4 5 9], -9999, 1);
% clear gpcp_prec
% 
% gpcp_ann(:,1) = gpcp_glob_ann(:,2);
% gpcp_ann(:,2) = gpcp_nhsh_ann(:,2);
% gpcp_ann(:,3) = gpcp_nhsh_ann(:,3);
% gpcp_ann(:,4) = gpcp_cont_ann(:,2);
% gpcp_ann(:,5) = gpcp_cont_ann(:,3);
% gpcp_ann(:,6) = gpcp_cont_ann(:,4);
% gpcp_ann(:,7) = gpcp_cont_ann(:,5);
% gpcp_ann(:,8) = gpcp_cont_ann(:,6);
% gpcp_ann(:,9) = gpcp_cont_ann(:,7);
% gpcp_ann(:,10) = gpcp_trpc_ann(:,2);
% 
% gpcp_mon(:,1) = gpcp_glob_mon(:,2);
% gpcp_mon(:,2) = gpcp_nhsh_mon(:,2);
% gpcp_mon(:,3) = gpcp_nhsh_mon(:,3);
% gpcp_mon(:,4) = gpcp_cont_mon(:,2);
% gpcp_mon(:,5) = gpcp_cont_mon(:,3);
% gpcp_mon(:,6) = gpcp_cont_mon(:,4);
% gpcp_mon(:,7) = gpcp_cont_mon(:,5);
% gpcp_mon(:,8) = gpcp_cont_mon(:,6);
% gpcp_mon(:,9) = gpcp_cont_mon(:,7);
% gpcp_mon(:,10) = gpcp_trpc_mon(:,2);
% 
% clear *nhsh* *glob* *cont*
% 
% 
% 
% load /media/storage/Data/Precipitation/CRU3/CRU3_PRECv3.0.mat
% cru_glob_ann = comp_glob_quant(cru_prec, [1989 2006],1, 'annual', [4 5 9], -9999, 1);
% cru_glob_mon = comp_glob_quant(cru_prec, [1989 2006],1, 'monthly', [4 5 9], -9999, 1);
% 
% cru_nhsh_ann = comp_glob_quant(cru_prec, [1989 2006],4, 'annual', [4 5 9], -9999, 1);
% cru_nhsh_mon = comp_glob_quant(cru_prec, [1989 2006],4, 'monthly', [4 5 9], -9999, 1);
% 
% cru_trpc_ann = comp_glob_quant(cru_prec, [1989 2006],5, 'annual', [4 5 9], -9999, 1);
% cru_trpc_mon = comp_glob_quant(cru_prec, [1989 2006],5, 'monthly', [4 5 9], -9999, 1);
% 
% cru_cont_ann = comp_cont_quant(cru_prec, [1989 2006], 'annual', [7 6 3 8 9 1],[4 5 9], -9999, 1);
% cru_cont_mon = comp_cont_quant(cru_prec, [1989 2006], 'monthly', [7 6 3 8 9 1],[4 5 9], -9999, 1);
% clear cru_prec
% 
% cru_ann(:,1) = cru_glob_ann(:,2);
% cru_ann(:,2) = cru_nhsh_ann(:,2);
% cru_ann(:,3) = cru_nhsh_ann(:,3);
% cru_ann(:,4) = cru_cont_ann(:,2);
% cru_ann(:,5) = cru_cont_ann(:,3);
% cru_ann(:,6) = cru_cont_ann(:,4);
% cru_ann(:,7) = cru_cont_ann(:,5);
% cru_ann(:,8) = cru_cont_ann(:,6);
% cru_ann(:,9) = cru_cont_ann(:,7);
% cru_ann(:,10) = cru_trpc_ann(:,2);
% 
% cru_mon(:,1) = cru_glob_mon(:,2);
% cru_mon(:,2) = cru_nhsh_mon(:,2);
% cru_mon(:,3) = cru_nhsh_mon(:,3);
% cru_mon(:,4) = cru_cont_mon(:,2);
% cru_mon(:,5) = cru_cont_mon(:,3);
% cru_mon(:,6) = cru_cont_mon(:,4);
% cru_mon(:,7) = cru_cont_mon(:,5);
% cru_mon(:,8) = cru_cont_mon(:,6);
% cru_mon(:,9) = cru_cont_mon(:,7);
% cru_mon(:,10) = cru_trpc_mon(:,2);
% 
% clear *nhsh* *glob* *cont*
% 
% 
% load /media/storage/Data/Precipitation/CPC/CPC_PREC.mat
% cpc_glob_ann = comp_glob_quant(cpc_prec, [1989 2006],1, 'annual', [4 5 9], -9999, 1);
% cpc_glob_mon = comp_glob_quant(cpc_prec, [1989 2006],1, 'monthly', [4 5 9], -9999, 1);
% 
% cpc_nhsh_ann = comp_glob_quant(cpc_prec, [1989 2006],4, 'annual', [4 5 9], -9999, 1);
% cpc_nhsh_mon = comp_glob_quant(cpc_prec, [1989 2006],4, 'monthly', [4 5 9], -9999, 1);
% 
% cpc_trpc_ann = comp_glob_quant(cpc_prec, [1989 2006],5, 'annual', [4 5 9], -9999, 1);
% cpc_trpc_mon = comp_glob_quant(cpc_prec, [1989 2006],5, 'monthly', [4 5 9], -9999, 1);
% 
% cpc_cont_ann = comp_cont_quant(cpc_prec, [1989 2006], 'annual',[7 6 3 8 9 1], [4 5 9], -9999, 1);
% cpc_cont_mon = comp_cont_quant(cpc_prec, [1989 2006], 'monthly', [7 6 3 8 9 1],[4 5 9], -9999, 1);
% clear cpc_prec
% 
% 
% cpc_ann(:,1) = cpc_glob_ann(:,2);
% cpc_ann(:,2) = cpc_nhsh_ann(:,2);
% cpc_ann(:,3) = cpc_nhsh_ann(:,3);
% cpc_ann(:,4) = cpc_cont_ann(:,2);
% cpc_ann(:,5) = cpc_cont_ann(:,3);
% cpc_ann(:,6) = cpc_cont_ann(:,4);
% cpc_ann(:,7) = cpc_cont_ann(:,5);
% cpc_ann(:,8) = cpc_cont_ann(:,6);
% cpc_ann(:,9) = cpc_cont_ann(:,7);
% cpc_ann(:,10) = cpc_trpc_ann(:,2);
% 
% cpc_mon(:,1) = cpc_glob_mon(:,2);
% cpc_mon(:,2) = cpc_nhsh_mon(:,2);
% cpc_mon(:,3) = cpc_nhsh_mon(:,3);
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
% ecmwf_glob_ann = comp_glob_quant(ecmwf_prec, [1989 2006],1, 'annual', [4 5 9], -9999, 1);
% ecmwf_glob_mon = comp_glob_quant(ecmwf_prec, [1989 2006],1, 'monthly', [4 5 9], -9999, 1);
% 
% ecmwf_nhsh_ann = comp_glob_quant(ecmwf_prec, [1989 2006],4, 'annual', [4 5 9], -9999, 1);
% ecmwf_nhsh_mon = comp_glob_quant(ecmwf_prec, [1989 2006],4, 'monthly', [4 5 9], -9999, 1);
% 
% ecmwf_trpc_ann = comp_glob_quant(ecmwf_prec, [1989 2006],5, 'annual', [4 5 9], -9999, 1);
% ecmwf_trpc_mon = comp_glob_quant(ecmwf_prec, [1989 2006],5, 'monthly', [4 5 9], -9999, 1);
% 
% ecmwf_cont_ann = comp_cont_quant(ecmwf_prec, [1989 2006], 'annual', [7 6 3 8 9 1],[4 5 9], -9999, 1);
% ecmwf_cont_mon = comp_cont_quant(ecmwf_prec, [1989 2006], 'monthly', [7 6 3 8 9 1],[4 5 9], -9999, 1);
% clear ecmwf_prec
% 
% 
% ecmwf_ann(:,1) = ecmwf_glob_ann(:,2);
% ecmwf_ann(:,2) = ecmwf_nhsh_ann(:,2);
% ecmwf_ann(:,3) = ecmwf_nhsh_ann(:,3);
% ecmwf_ann(:,4) = ecmwf_cont_ann(:,2);
% ecmwf_ann(:,5) = ecmwf_cont_ann(:,3);
% ecmwf_ann(:,6) = ecmwf_cont_ann(:,4);
% ecmwf_ann(:,7) = ecmwf_cont_ann(:,5);
% ecmwf_ann(:,8) = ecmwf_cont_ann(:,6);
% ecmwf_ann(:,9) = ecmwf_cont_ann(:,7);
% ecmwf_ann(:,10) = ecmwf_trpc_ann(:,2);
% 
% ecmwf_mon(:,1) = ecmwf_glob_mon(:,2);
% ecmwf_mon(:,2) = ecmwf_nhsh_mon(:,2);
% ecmwf_mon(:,3) = ecmwf_nhsh_mon(:,3);
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
% merra_glob_ann = comp_glob_quant(merra_prec, [1989 2006],1, 'annual', [4 5 9], -9999, 1);
% merra_glob_mon = comp_glob_quant(merra_prec, [1989 2006],1, 'monthly', [4 5 9], -9999, 1);
% 
% merra_nhsh_ann = comp_glob_quant(merra_prec, [1989 2006],4, 'annual', [4 5 9], -9999, 1);
% merra_nhsh_mon = comp_glob_quant(merra_prec, [1989 2006],4, 'monthly', [4 5 9], -9999, 1);
% 
% merra_trpc_ann = comp_glob_quant(merra_prec, [1989 2006],5, 'annual', [4 5 9], -9999, 1);
% merra_trpc_mon = comp_glob_quant(merra_prec, [1989 2006],5, 'monthly', [4 5 9], -9999, 1);
% 
% merra_cont_ann = comp_cont_quant(merra_prec, [1989 2006], 'annual', [7 6 3 8 9 1],[4 5 9], -9999, 1);
% merra_cont_mon = comp_cont_quant(merra_prec, [1989 2006], 'monthly', [7 6 3 8 9 1],[4 5 9], -9999, 1);
% clear merra_prec
% 
% 
% merra_ann(:,1) = merra_glob_ann(:,2);
% merra_ann(:,2) = merra_nhsh_ann(:,2);
% merra_ann(:,3) = merra_nhsh_ann(:,3);
% merra_ann(:,4) = merra_cont_ann(:,2);
% merra_ann(:,5) = merra_cont_ann(:,3);
% merra_ann(:,6) = merra_cont_ann(:,4);
% merra_ann(:,7) = merra_cont_ann(:,5);
% merra_ann(:,8) = merra_cont_ann(:,6);
% merra_ann(:,9) = merra_cont_ann(:,7);
% merra_ann(:,10) = merra_trpc_ann(:,2);
% 
% merra_mon(:,1) = merra_glob_mon(:,2);
% merra_mon(:,2) = merra_nhsh_mon(:,2);
% merra_mon(:,3) = merra_nhsh_mon(:,3);
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
% cfsr_glob_ann = comp_glob_quant(cfsr_prec, [1989 2006],1, 'annual', [4 5 9], -9999, 1);
% cfsr_glob_mon = comp_glob_quant(cfsr_prec, [1989 2006],1, 'monthly', [4 5 9], -9999, 1);
% 
% cfsr_nhsh_ann = comp_glob_quant(cfsr_prec, [1989 2006],4, 'annual', [4 5 9], -9999, 1);
% cfsr_nhsh_mon = comp_glob_quant(cfsr_prec, [1989 2006],4, 'monthly', [4 5 9], -9999, 1);
% 
% cfsr_trpc_ann = comp_glob_quant(cfsr_prec, [1989 2006],5, 'annual', [4 5 9], -9999, 1);
% cfsr_trpc_mon = comp_glob_quant(cfsr_prec, [1989 2006],5, 'monthly', [4 5 9], -9999, 1);
% 
% cfsr_cont_ann = comp_cont_quant(cfsr_prec, [1989 2006], 'annual', [7 6 3 8 9 1],[4 5 9], -9999, 1);
% cfsr_cont_mon = comp_cont_quant(cfsr_prec, [1989 2006], 'monthly',[7 6 3 8 9 1], [4 5 9], -9999, 1);
% clear cfsr_prec
% 
% 
% cfsr_ann(:,1) = cfsr_glob_ann(:,2);
% cfsr_ann(:,2) = cfsr_nhsh_ann(:,2);
% cfsr_ann(:,3) = cfsr_nhsh_ann(:,3);
% cfsr_ann(:,4) = cfsr_cont_ann(:,2);
% cfsr_ann(:,5) = cfsr_cont_ann(:,3);
% cfsr_ann(:,6) = cfsr_cont_ann(:,4);
% cfsr_ann(:,7) = cfsr_cont_ann(:,5);
% cfsr_ann(:,8) = cfsr_cont_ann(:,6);
% cfsr_ann(:,9) = cfsr_cont_ann(:,7);
% cfsr_ann(:,10) = cfsr_trpc_ann(:,2);
% 
% cfsr_mon(:,1) = cfsr_glob_mon(:,2);
% cfsr_mon(:,2) = cfsr_nhsh_mon(:,2);
% cfsr_mon(:,3) = cfsr_nhsh_mon(:,3);
% cfsr_mon(:,4) = cfsr_cont_mon(:,2);
% cfsr_mon(:,5) = cfsr_cont_mon(:,3);
% cfsr_mon(:,6) = cfsr_cont_mon(:,4);
% cfsr_mon(:,7) = cfsr_cont_mon(:,5);
% cfsr_mon(:,8) = cfsr_cont_mon(:,6);
% cfsr_mon(:,9) = cfsr_cont_mon(:,7);
% cfsr_mon(:,10) = cfsr_trpc_mon(:,2);
% 
% clear *nhsh* *glob* *cont*


save prec_timeseries.mat 



text_str{1} = 'Global land';
text_str{2} = 'Northern hemisphere';
text_str{3} = 'Southern hemisphere';
text_str{4} = 'North America';
text_str{5} = 'South America';
text_str{6} = 'Europe';
text_str{7} = 'Africa';
text_str{8} = 'Asia';
text_str{9} = 'Australia';
text_str{10} = '15S - 15N (Tropics)';

yrs{1} = ' ';
yrs{2} = '1990';
yrs{3} = ' ';
yrs{4} = '1992 ';
yrs{5} = ' ';
yrs{6} = '1994 ';
yrs{7} = ' ';
yrs{8} = '1996 ';
yrs{9} = ' ';
yrs{10} = '1998 ';
yrs{11} = ' ';
yrs{12} = '2000';
yrs{13} = ' ';
yrs{14} = '2002 ';
yrs{15} = ' ';
yrs{16} = '2004 ';
yrs{17} = ' ';
yrs{18} = '2006 ';

mnths{1} = 'J';
mnths{2} = 'F';
mnths{3} = 'M';
mnths{4} = 'A';
mnths{5} = 'M';
mnths{6} = 'J';
mnths{7} = 'J';
mnths{8} = 'A';
mnths{9} = 'S';
mnths{10} = 'O';
mnths{11} = 'N';
mnths{12} = 'D';

fnames_ann{1} = 'P_ann_glob_ts';
fnames_ann{2} = 'P_ann_NH_ts';
fnames_ann{3} = 'P_ann_SH_ts';
fnames_ann{4} = 'P_ann_NA_ts';
fnames_ann{5} = 'P_ann_SA_ts';
fnames_ann{6} = 'P_ann_E_ts';
fnames_ann{7} = 'P_ann_AF_ts';
fnames_ann{8} = 'P_ann_AS_ts';
fnames_ann{9} = 'P_ann_AU_ts';
fnames_ann{10} = 'P_ann_TR_ts';

fnames_mon{1} = 'P_mon_glob_ts';
fnames_mon{2} = 'P_mon_NH_ts';
fnames_mon{3} = 'P_mon_SH_ts';
fnames_mon{4} = 'P_mon_NA_ts';
fnames_mon{5} = 'P_mon_SA_ts';
fnames_mon{6} = 'P_mon_E_ts';
fnames_mon{7} = 'P_mon_AF_ts';
fnames_mon{8} = 'P_mon_AS_ts';
fnames_mon{9} = 'P_mon_AU_ts';
fnames_mon{10} = 'P_mon_TR_ts';

for i = 1:10
    h = figure('papersize', [4.5 4], 'paperunits', 'centimeters')
    plot(cru_ann(:,i)   - gpcc_ann(:,i), 'c', 'linewidth', 1.5);
    hold on
    plot(gpcp_ann(:,i)  - gpcc_ann(:,i), 'm', 'linewidth', 1.5);
    plot(cpc_ann(:,i)   - gpcc_ann(:,i), 'y', 'linewidth', 1.5);
    plot(ecmwf_ann(:,i) - gpcc_ann(:,i), 'b', 'linewidth', 1.5);
    plot(merra_ann(:,i) - gpcc_ann(:,i), 'r', 'linewidth', 1.5);
    plot(cfsr_ann(:,i)  - gpcc_ann(:,i), 'g', 'linewidth', 1.5);

    grid on
    axis([1 18 -1 1]);
    set(gca, 'xtick', 1:1:18);
    set(gca, 'ytick', -1:0.25:1);
    set(gca, 'xticklabel', yrs, 'fontsize', 16);
    pbaspect([17 8 1]);
    
    
    text(2, 0.75, text_str{i} , 'fontsize', 20);
if i == 1
        leg = legend('GPCP', 'CRU', 'CPC', 'INTERIM', 'MERRA', 'CFSR', 'location','Best');
        set(leg, 'fontsize', 12)
        keyboard
    end
    print(h, '-depsc2', fnames_ann{i});
    clear h
    
    
    h = figure('papersize', [4.5 4], 'paperunits', 'centimeters')
    plot(cru_mon(:,i)   - gpcc_mon(:,i), 'c', 'linewidth', 1.5);
    hold on
    plot(gpcp_mon(:,i)  - gpcc_mon(:,i), 'm', 'linewidth', 1.5);
    plot(cpc_mon(:,i)   - gpcc_mon(:,i), 'y', 'linewidth', 1.5);
    plot(ecmwf_mon(:,i) - gpcc_mon(:,i), 'b', 'linewidth', 1.5);
    plot(merra_mon(:,i) - gpcc_mon(:,i), 'r', 'linewidth', 1.5);
    plot(cfsr_mon(:,i)  - gpcc_mon(:,i), 'g', 'linewidth', 1.5);

    grid on
    axis([1 12 -1.5 1.5]);
    set(gca, 'xtick', 1:1:12);
    set(gca, 'ytick', -1.5:0.5:1.5);
    set(gca, 'xticklabel', mnths, 'fontsize', 16);
    pbaspect([12 6 1]);
    
   
    text(2, 1, text_str{i} , 'fontsize', 20);
 if i == 1
        leg = legend('GPCP', 'CRU', 'CPC', 'INTERIM', 'MERRA', 'CFSR', 'location','Best');
        set(leg, 'fontsize', 12)
        keyboard
    end
    print(h, '-depsc2', fnames_mon{i});
    clear h
    close all
end




R_cru = comp_spat_corr(gpcc_prec, cru_prec, [1989 2006], 'annual_2', 1, [4 5 9], -9999);
clear cru_prec

load /media/storage/Data/Precipitation/CPC/CPC_PREC.mat
R_cpc = comp_spat_corr(gpcc_prec, cpc_prec, [1989 2006], 'annual_2', 1, [4 5 9], -9999);
clear cpc_prec

load /media/storage/Data/Precipitation/ECMWF/ECMWF_PREC.mat
R_ecmwf = comp_spat_corr(gpcc_prec, ecmwf_prec, [1989 2006], 'annual_2', 1, [4 5 9], -9999);
clear ecmwf_prec


load /media/storage/Data/Precipitation/MERRA/MERRA_PREC.mat
R_merra = comp_spat_corr(gpcc_prec, merra_prec, [1989 2006], 'annual_2', 1, [4 5 9], -9999);
clear merra_prec

load /media/storage/Data/Precipitation/CFSR/CFSR_PREC.mat
R_cfsr = comp_spat_corr(gpcc_prec, cfsr_prec, [1989 2006], 'annual_2', 1, [4 5 9], -9999);
clear cfsr_prec






cindx = [7 6 3 8 9 1];

% fname{1} = 'R_ann_NA.eps';
% fname{2} = 'R_ann_SA.eps';
% fname{3} = 'R_ann_E.eps';
% fname{4} = 'R_ann_AF.eps';
% fname{5} = 'R_ann_AS.eps';
% fname{6} = 'R_ann_AU.eps';

% fname{1} = 'P_mnth_NA.eps';
% fname{2} = 'P_mnth_SA.eps';
% fname{3} = 'P_mnth_E.eps';
% fname{4} = 'P_mnth_AF.eps';
% fname{5} = 'P_mnth_AS.eps';
% fname{6} = 'P_mnth_AU.eps';
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
yrs{1} = ' ';
yrs{2} = '1990';
yrs{3} = ' ';
yrs{4} = '1992 ';
yrs{5} = ' ';
yrs{6} = '1994 ';
yrs{7} = ' ';
yrs{8} = '1996 ';
yrs{9} = ' ';
yrs{10} = '1998 ';
yrs{11} = ' ';
yrs{12} = '2000';
yrs{13} = ' ';
yrs{14} = '2002 ';
yrs{15} = ' ';
yrs{16} = '2004 ';
yrs{17} = ' ';
yrs{18} = '2006 ';


% for i = 1:6
h = figure('papersize', [4.5 4], 'paperunits', 'centimeters')

% plot(P_gpcc(:, cindx(i)), 'k', 'linewidth', 1.5);

% plot(R_cru(:, cindx(i))-P_gpcc(:, cindx(i)), 'k--', 'linewidth', 1.5);
% hold on
% plot(R_cpc(:, cindx(i))-P_gpcc(:, cindx(i)), 'k-.', 'linewidth', 1.5);
% plot(R_ecmwf(:, cindx(i))-P_gpcc(:, cindx(i)), 'color',[0.4 0.4 0.4], 'linewidth', 1.5);
% plot(R_merra(:, cindx(i))-P_gpcc(:, cindx(i)), '--', 'color',[0.4 0.4 0.4], 'linewidth', 1.5);
% plot(P_cfsr(:, cindx(i))-P_gpcc(:, cindx(i)), '-.', 'color',[0.4 0.4 0.4], 'linewidth', 1.5);
% plot(R_cru(cindx(i), :), 'm', 'linewidth', 1.5);
% hold on
% plot(R_cpc(cindx(i), :), 'c', 'linewidth', 1.5);
% plot(R_ecmwf(cindx(i), :), 'b', 'linewidth', 1.5);
% plot(R_merra(cindx(i), :), 'r', 'linewidth', 1.5);
% plot(R_cfsr(cindx(i), :), 'g', 'linewidth', 1.5);
plot(R_cru(1, :), 'm', 'linewidth', 1.5);
hold on
plot(R_cpc(1, :), 'c', 'linewidth', 1.5);
plot(R_ecmwf(1, :), 'b', 'linewidth', 1.5);
plot(R_merra(1, :), 'r', 'linewidth', 1.5);
plot(R_cfsr(1, :), 'g', 'linewidth', 1.5);

grid on
axis([1 12 0.6 1]);
% axis([1 18 0.5 1]);
% set(gca, 'ytick', 0.5:0.05:1);
set(gca, 'ytick', 0.6:0.05:1);
% set(gca, 'xtick', 1:1:12)
% set(gca, 'xticklabel', mnths, 'fontsize', 16)

set(gca, 'xtick', 1:1:18)
set(gca, 'xticklabel', yrs, 'fontsize', 16)
% axis([1 18 -1 1])
pbaspect([12 8 1]);
% pbaspect([17 10 1]);
if i == 1
    legend('CRU', 'CPC', 'INTERIM', 'MERRA', 'CFSR', 'location', ... 
            'southeast', 'fontsize', 16);
end
% if i == 1 || i == 4
%     ylabel('[mm/day]', 'fontsize', 16)
% end
if i == 1
    keyboard
end
print(h, '-depsc2', 'corr_mnth_mean.eps');

% end


