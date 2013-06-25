% function [] = crt_tqv_ts

% load /media/storage/Data/Total_water_atm/SSMI/SSMI_TQV.mat
% ssmi = comp_glob_quant(ssmi_tqv, [1989 2006], 1, 'complete', [4 5 9], 'NaN', 0);
% clear ssmi_tqv

load /media/storage/Data/Total_water_atm/CFSR/CFSR_TQV.mat
cfsr = comp_glob_quant(cfsr_tqv, [1989 2006], 0, 'complete', [4 5 9], 'NaN', 0);
clear cfsr_tqv

load /media/storage/Data/Total_water_atm/ECMWF/ECMWF_TQV.mat
ecmwf = comp_glob_quant(ecmwf_tqv, [1989 2006], 0, 'complete', [4 5 9], 'NaN', 0);
clear ecmwf_tqv


load /media/storage/Data/Total_water_atm/MERRA/MERRA_TQV.mat
merra = comp_glob_quant(merra_tqv, [1989 2006], 0, 'complete', [4 5 9], 'NaN', 0);
clear merra_tqv


fu = figure('papersize', [4.5 4], 'paperunits', 'centimeters')

% plot(ssmi(:,3), 'm', 'linewidth', 1.5)

plot(ecmwf(:,3), 'b', 'linewidth', 1.5);
hold on
plot(merra(:,3), 'r', 'linewidth', 1.5)
plot(cfsr(:,3), 'g', 'linewidth', 1.5);

grid on
