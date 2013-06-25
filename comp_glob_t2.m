load /home/lorenz-c/Data/Temperature/T2/CRU3/CRU_T2.mat
sind = find(cell2mat(cru_t2(:,4)) == 1  & ...
                                        cell2mat(cru_t2(:,5)) == 1989);
eind = find(cell2mat(cru_t2(:,4)) == 12 & ...
                                        cell2mat(cru_t2(:,5)) == 2006);
                                    
cru = cru_t2(sind:eind, [4 5 9]);
clear cru_t2 sind eind

load /home/lorenz-c/Data/Temperature/T2/DEL/DEL_T2.mat
sind = find(cell2mat(del_t2(:,4)) == 1  & ...
                                        cell2mat(del_t2(:,5)) == 1989);
eind = find(cell2mat(del_t2(:,4)) == 12 & ...
                                        cell2mat(del_t2(:,5)) == 2006);
                                    
del = del_t2(sind:eind, [4 5 9]);
clear del_t2 sind eind

load /home/lorenz-c/Data/Temperature/T2/ECMWF/ECMWF_T2.mat
sind = find(cell2mat(ecmwf_t2(:,4)) == 1  & ...
                                        cell2mat(ecmwf_t2(:,5)) == 1989);
eind = find(cell2mat(ecmwf_t2(:,4)) == 12 & ...
                                        cell2mat(ecmwf_t2(:,5)) == 2006);
                                    
ecmwf = ecmwf_t2(sind:eind, [4 5 9]);
clear ecmwf_t2 sind eind


load /home/lorenz-c/Data/Temperature/T2/MERRA/MERRA_T2.mat
sind = find(cell2mat(merra_t2(:,4)) == 1  & ...
                                        cell2mat(merra_t2(:,5)) == 1989);
eind = find(cell2mat(merra_t2(:,4)) == 12 & ...
                                        cell2mat(merra_t2(:,5)) == 2006);
                                    
merra = merra_t2(sind:eind, [4 5 9]);
clear merra_t2 sind eind
 
load /home/lorenz-c/Data/Temperature/T2/CFSR/CFSR_T2.mat
sind = find(cell2mat(cfsr_t2(:,4)) == 1  & ...
                                        cell2mat(cfsr_t2(:,5)) == 1989);
eind = find(cell2mat(cfsr_t2(:,4)) == 12 & ...
                                        cell2mat(cfsr_t2(:,5)) == 2006);
                                    
cfsr = cfsr_t2(sind:eind, [4 5 9]);
clear cfsr_t2 sind eind


cru_mn  = zeros(360, 720);
del_mn   = zeros(360, 720);
ecmwf_mn = zeros(360, 720);
merra_mn = zeros(360, 720);
cfsr_mn  = zeros(360, 720);

mask_cru = zeros(360, 720);
mask_del  = zeros(360, 720);


for i = 1:length(cru)
    cru_mn = cru_mn + cru{i,3};
    mask_cru(cru{i,3} ~= -9999) = mask_cru(cru{i,3} ~= -9999) + 1;
    
    del_mn  = del_mn  + del{i,3};
    mask_del(del{i,3} ~= -9999) = mask_del(del{i,3} ~= -9999) + 1;
    
    ecmwf_mn = ecmwf_mn + ecmwf{i,3};
    merra_mn = merra_mn + merra{i,3};
    cfsr_mn  = cfsr_mn  + cfsr{i,3};
end
    
mask_total = zeros(360, 720);

mask_cru(mask_cru < 216) = 0;
mask_del(mask_del < 216)   = 0;

mask_total(mask_cru == 216 & mask_del == 216) = 216;

cru_mn  = cru_mn./mask_total;
del_mn   = del_mn./mask_total;
ecmwf_mn = ecmwf_mn./mask_total;
merra_mn = merra_mn./mask_total;
cfsr_mn  = cfsr_mn./mask_total;

cru_mn(mask_total == 0)   = NaN;
del_mn(mask_total == 0)   = NaN;
ecmwf_mn(mask_total == 0) = NaN;
merra_mn(mask_total == 0) = NaN;
cfsr_mn(mask_total == 0)  = NaN;

d_del = del_mn - cru_mn;
d_ecmwf = ecmwf_mn - cru_mn;
d_merra = merra_mn - cru_mn;
d_cfsr  = cfsr_mn  - cru_mn;


A = grid2gmt(cru_mn, 0.5);
save /home/lorenz-c/Dokumente/Projektarbeit/Publications/Reana_comp/Images/Absolute/cru_ann_t2.txt A -ascii
A = grid2gmt(del_mn, 0.5);
save /home/lorenz-c/Dokumente/Projektarbeit/Publications/Reana_comp/Images/Absolute/del_ann_t2.txt A -ascii
A = grid2gmt(ecmwf_mn, 0.5);
save /home/lorenz-c/Dokumente/Projektarbeit/Publications/Reana_comp/Images/Absolute/ecmwf_ann_t2.txt A -ascii
A = grid2gmt(merra_mn, 0.5);
save /home/lorenz-c/Dokumente/Projektarbeit/Publications/Reana_comp/Images/Absolute/merra_ann_t2.txt A -ascii
A = grid2gmt(cfsr_mn, 0.5);
save /home/lorenz-c/Dokumente/Projektarbeit/Publications/Reana_comp/Images/Absolute/cfsr_ann_t2.txt A -ascii

A = grid2gmt(d_del, 0.5);
save /home/lorenz-c/Dokumente/Projektarbeit/Publications/Reana_comp/Images/Differences/d_cpc_ann_t2.txt A -ascii
A = grid2gmt(d_ecmwf, 0.5);
save /home/lorenz-c/Dokumente/Projektarbeit/Publications/Reana_comp/Images/Differences/d_ecmwf_ann_t2.txt A -ascii
A = grid2gmt(d_merra, 0.5);
save /home/lorenz-c/Dokumente/Projektarbeit/Publications/Reana_comp/Images/Differences/d_merra_ann_t2.txt A -ascii
A = grid2gmt(d_cfsr, 0.5);
save /home/lorenz-c/Dokumente/Projektarbeit/Publications/Reana_comp/Images/Differences/d_cfsr_ann_t2.txt A -ascii








