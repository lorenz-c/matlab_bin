load /media/storage/Data/Precipitation/GPCC/GPCC_PRECv4.0.mat
gpcc_glob_ann = comp_glob_quant(gpcc_prec, [1989 2006],1, 'annual', [4 5 9], -9999, 1);
gpcc_glob_mon = comp_glob_quant(gpcc_prec, [1989 2006],1, 'monthly', [4 5 9], -9999, 1);

gpcc_nhsh_ann = comp_glob_quant(gpcc_prec, [1989 2006],4, 'annual', [4 5 9], -9999, 1);
gpcc_nhsh_mon = comp_glob_quant(gpcc_prec, [1989 2006],4, 'monthly', [4 5 9], -9999, 1);

gpcc_trpc_ann = comp_glob_quant(gpcc_prec, [1989 2006],5, 'annual', [4 5 9], -9999, 1);
gpcc_trpc_mon = comp_glob_quant(gpcc_prec, [1989 2006],5, 'monthly', [4 5 9], -9999, 1);

gpcc_cont_ann = comp_cont_quant(gpcc_prec, [1989 2006], 'annual', [7 6 3 8 9 1], [4 5 9], -9999, 1);
gpcc_cont_mon = comp_cont_quant(gpcc_prec, [1989 2006], 'monthly',  [7 6 3 8 9 1], [4 5 9], -9999, 1);
clear gpcc_prec
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
% cfsr_cont_mon = comp_cont_quant(cfsr_prec, [1989 2006], 'monthly',[7 6 3
% 8 9 1], [4 5 9], -9999, 1);