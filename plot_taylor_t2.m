function [] = plot_taylor_t2(cind, time);
close all
if nargin < 2
    time = [1989 2006];
end

load /home/lorenz-c/Data/Catchment_agg/merra_cagg_t2_sel.mat
load /home/lorenz-c/Data/Catchment_agg/cfsr01_cagg_t2_sel.mat
load /home/lorenz-c/Data/Catchment_agg/ecmwf_cagg_t2_sel.mat
load /home/lorenz-c/Data/Catchment_agg/cru_cagg_t2_sel.mat
load /home/lorenz-c/Data/Catchment_agg/del_cagg_t2_sel.mat

r = find(cell2mat(merra_cagg_t2_sel(:,2)) == cind);

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

[R E sig] = taylor_stats(cru_cagg_t2_sel{r,3}(cru_sind:cru_eind,3), ...
                         del_cagg_t2_sel{r,3}(del_sind:del_eind,3), ...
                         ecmwf_cagg_t2_sel{r,3}(ecmwf_sind:ecmwf_eind,3), ...
                         merra_cagg_t2_sel{r,3}(merra_sind:merra_eind,3), ...
                         cfsr_cagg_t2_sel{r,3}(cfsr_sind:cfsr_eind,3));
       
[hp ht axl] = taylordiag(sig, E, R)

set(ht(1), 'String', 'CRU')
set(ht(2), 'String', 'DEL')
set(ht(3), 'String', 'ECMWF')
set(ht(4), 'String', 'MERRA')
set(ht(5), 'String', 'CFSR')

tlte = ['Averaged monthly temperature for ', merra_cagg_t2_sel{r,1}];
title(tlte, 'fontsize', 14);
                     
filenme = ['/home/lorenz-c/Dokumente/Projektarbeit/Analysis/Precipitation/Timeseries/T2_Tlr_',  ...
           merra_cagg_t2_sel{r,1}]
       
print('-depsc', filenme);
                     