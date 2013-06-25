% function [] = compute_zonal_prec_glob


load /media/storage/Data/Precipitation/GPCP/GPCP_PRECv2.1.mat

gpcp_totl = comp_zon_prec(gpcp_prec, [1979 2008], 0);
gpcp_land = comp_zon_prec(gpcp_prec, [1979 2008], 3);
gpcp_ocen = comp_zon_prec(gpcp_prec, [1979 2008], 2);

clear gpcp_prec

load /media/storage/Data/Precipitation/ECMWF/ECMWF_PREC.mat

ecmwf_totl = comp_zon_prec(ecmwf_prec, [1989 2009], 0);
ecmwf_land = comp_zon_prec(ecmwf_prec, [1989 2009], 1);
ecmwf_ocen = comp_zon_prec(ecmwf_prec, [1989 2009], 2);

clear ecmwf_prec

load /media/storage/Data/Precipitation/MERRA/MERRA_PREC.mat

merra_totl = comp_zon_prec(merra_prec, [1979 2009], 0);
merra_land = comp_zon_prec(merra_prec, [1979 2009], 1);
merra_ocen = comp_zon_prec(merra_prec, [1979 2009], 2);

clear merra_prec

load /media/storage/Data/Precipitation/CFSR/CFSR_PREC01.mat

cfsr_totl = comp_zon_prec(cfsr_prec1, [1979 2009], 0);
cfsr_land = comp_zon_prec(cfsr_prec1, [1979 2009], 1);
cfsr_ocen = comp_zon_prec(cfsr_prec1, [1979 2009], 2);

clear cfsr_prec1