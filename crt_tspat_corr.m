% 
% 
% load /media/storage/Data/Precipitation/GPCC/GPCC_PRECv4.0.mat
% gpcc = comp_spat_mean(gpcc_prec, [1989 2006], 'seasonal_2',[4 5 9], -9999);
% clear *prec
% 
% load /media/storage/Data/Precipitation/CRU3/CRU3_PRECv3.0.mat
% cru = comp_spat_mean(cru_prec, [1989 2006], 'seasonal_2',[4 5 9], -9999);
% clear *prec
% 
% load /media/storage/Data/Precipitation/CPC/CPC_PREC.mat
% cpc = comp_spat_mean(cpc_prec, [1989 2006], 'seasonal_2',[4 5 9], -9999);
% clear *prec
% 
% load /media/storage/Data/Precipitation/ECMWF/ECMWF_PREC.mat
% ecmwf = comp_spat_mean(ecmwf_prec, [1989 2006], 'seasonal_2',[4 5 9], -9999);
% clear *prec
% 
% load /media/storage/Data/Precipitation/MERRA/MERRA_PREC.mat
% merra = comp_spat_mean(merra_prec, [1989 2006], 'seasonal_2',[4 5 9], -9999);
% clear *prec
% 
% load /media/storage/Data/Precipitation/CFSR/CFSR_PREC.mat
% cfsr = comp_spat_mean(cfsr_prec, [1989 2006], 'seasonal_2',[4 5 9], -9999);
% clear *prec

for i = 1:4
    R_cru{i} = comp_tspat_corr(gpcc(:,i), cru(:,i), -9999);
    R_cpc{i} = comp_tspat_corr(gpcc(:,i), cpc(:,i), -9999);
    R_ecmwf{i} = comp_tspat_corr(gpcc(:,i), ecmwf(:,i), -9999);
    R_merra{i} = comp_tspat_corr(gpcc(:,i), merra(:,i), -9999);
    R_cfsr{i} = comp_tspat_corr(gpcc(:,i), cfsr(:,i), -9999);
end
    
