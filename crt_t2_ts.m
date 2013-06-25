function [] = crt_t2_ts(cind, time, mn, mx, stp)



% load /home/lorenz-c/Data/Precipitation/MERRA/MERRA_PREC.mat
% load /home/lorenz-c/Data/Precipitation/ECMWF/ECMWF_PREC.mat
% load /home/lorenz-c/Data/Precipitation/CRU3/CRU3_PREC.mat
% load /home/lorenz-c/Data/Precipitation/DEL/DEL_PREC.mat
% load /home/lorenz-c/Data/Precipitation/CFSR/CFSR_PREC.mat
% load /home/lorenz-c/Data/Precipitation/GPCC/GPCC_PREC.mat
% 
% 
% merra_c_agg_prec = crt_ts(merra_prec, [4 5 9]);
% merra_c_agg_prec = crt_ts(merra_prec, [4 5 9]);
% merra_c_agg_prec = crt_ts(merra_prec, [4 5 9]);
% merra_c_agg_prec = crt_ts(merra_prec, [4 5 9]);
% merra_c_agg_prec = crt_ts(merra_prec, [4 5 9]);
% merra_c_agg_prec = crt_ts(merra_prec, [4 5 9]);



load /home/lorenz-c/Data/Catchment_agg/merra_cagg_t2_sel.mat
load /home/lorenz-c/Data/Catchment_agg/cfsr01_cagg_t2_sel.mat
load /home/lorenz-c/Data/Catchment_agg/ecmwf_cagg_t2_sel.mat
load /home/lorenz-c/Data/Catchment_agg/cru_cagg_t2_sel.mat
load /home/lorenz-c/Data/Catchment_agg/del_cagg_t2_sel.mat

r = find(cell2mat(merra_cagg_t2_sel(:,2)) == cind);

yrs = time(1):1:time(2);

for i = 1:length(yrs)
    yr_str(i,:) = ['Jan ', num2str(yrs(i))];
end

ecmwf_sind = find(ecmwf_cagg_t2_sel{1,3}(:,1) == 1  & ...
                        ecmwf_cagg_t2_sel{1,3}(:,2) == time(1));
ecmwf_eind = find(ecmwf_cagg_t2_sel{1,3}(:,1) == 12 & ...
                        ecmwf_cagg_t2_sel{1,3}(:,2) == time(2)); 

merra_sind = find(merra_cagg_t2_sel{1,3}(:,1) == 1  & ...
                        merra_cagg_t2_sel{1,3}(:,2) == time(1));
merra_eind = find(merra_cagg_t2_sel{1,3}(:,1) == 12 & ...
                        merra_cagg_t2_sel{1,3}(:,2) == time(2));    
                    
cfsr_sind  = find(cfsr_cagg_t2_sel{1,3}(:,1) == 1  & ... 
                        cfsr_cagg_t2_sel{1,3}(:,2) == time(1));
cfsr_eind  = find(cfsr_cagg_t2_sel{1,3}(:,1) == 12  & ... 
                        cfsr_cagg_t2_sel{1,3}(:,2) == time(2));
                    
cru_sind   = find(cru_cagg_t2_sel{1,3}(:,1) == 1  & ...
                        cru_cagg_t2_sel{1,3}(:,2) == time(1));
cru_eind   = find(cru_cagg_t2_sel{1,3}(:,1) == 12  & ...
                        cru_cagg_t2_sel{1,3}(:,2) == time(2));
                    
del_sind = find(del_cagg_t2_sel{1,3}(:,1) == 1  & ...
                        del_cagg_t2_sel{1,3}(:,2) == time(1));
del_eind = find(del_cagg_t2_sel{1,3}(:,1) == 12  & ...
                        del_cagg_t2_sel{1,3}(:,2) == time(2));
                    
    

ts_matrix(:,1) = cru_cagg_t2_sel{r,3}(cru_sind:cru_eind,3);
ts_matrix(:,2) = del_cagg_t2_sel{r,3}(del_sind:del_eind,3);
ts_matrix(:,3) = ecmwf_cagg_t2_sel{r,3}(ecmwf_sind:ecmwf_eind,3);
ts_matrix(:,4) = merra_cagg_t2_sel{r,3}(merra_sind:merra_eind,3);
ts_matrix(:,5) = cfsr_cagg_t2_sel{r,3}(cfsr_sind:cfsr_eind,3);




nr_steps = merra_eind - merra_sind;

for i = 1:nr_steps+1;
    stepnr(i) = i;
end

figure

plot(stepnr, ts_matrix(:,1), 'r', 'linewidth', 1)
hold on
plot(stepnr, ts_matrix(:,2), 'g', 'linewidth', 1)
plot(stepnr, ts_matrix(:,3), 'b', 'linewidth', 1)
plot(stepnr, ts_matrix(:,4), 'c', 'linewidth', 1)
plot(stepnr, ts_matrix(:,5), 'm', 'linewidth', 1)

% legend('CRU', 'DEL', 'ECMWF', 'MERRA', 'CFSR','location','northoutside');

set(gca, 'xtick', 1:12:nr_steps);
set(gca, 'xticklabel', yr_str, 'xminortick', 'on',  'xminorgrid', 'on');

grid on


% axis([1 nr_steps mn mx]);
tlte = ['Averaged monthly temperature for ', merra_cagg_t2_sel{r,1}];
title(tlte);
ylabel('[°C]')
pbaspect([3 1 1])

filenme = ['/home/lorenz-c/Dokumente/Projektarbeit/Analysis/Precipitation/Timeseries/T2_Ts_', ...
           merra_cagg_t2_sel{r,1}]
print('-depsc', filenme);







