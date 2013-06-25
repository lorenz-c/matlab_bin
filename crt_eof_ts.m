
load /media/storage/Data/Precipitation/MERRA/MERRA_PREC.mat
[eofs_merra, pcs_merra, var_merra, rec_merra] = eof_ana(merra_prec, [1989 2006], 0, 1, -9999, [4 5 9], 0);
clear merra_prec

load /media/storage/Data/Precipitation/CFSR/CFSR_PREC.mat
[eofs_cfsr, pcs_cfsr, var_cfsr, rec_cfsr] = eof_ana(cfsr_prec, [1989 2006], 0, 1, -9999, [4 5 9], 0);
clear cfsr_prec

load /media/storage/Data/Precipitation/GPCC/GPCC_PRECv4.0.mat
[eofs_gpcc, pcs_gpcc, var_gpcc, rec_gpcc] = eof_ana(gpcc_prec, [1989 2006], 0, 1, -9999, [4 5 9], 0);
clear gpcc_prec

load /media/storage/Data/Precipitation/CRU3/CRU3_PRECv3.0.mat
[eofs_cru, pcs_cru, var_cru, rec_cru] = eof_ana(cru_prec, [1989 2006], 0, 1, -9999, [4 5 9], 0);
clear cru_prec

load /media/storage/Data/Precipitation/CPC/CPC_PREC.mat
[eofs_cpc, pcs_cpc, var_cpc, rec_cpc] = eof_ana(cpc_prec, [1989 2006], 0, 1, -9999, [4 5 9], 0);
clear cru_prec

load /media/storage/Data/Precipitation/ECMWF/ECMWF_PREC.mat
[eofs_ecmwf, pcs_ecmwf, var_ecmwf, rec_ecmwf] = eof_ana(ecmwf_prec, [1989 2006], 0, 1, -9999, [4 5 9], 0);
clear ecmwf_prec