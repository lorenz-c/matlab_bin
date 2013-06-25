% clear all
% 
% load /media/storage/Data/Mflux/ECMWF/ECMWF_VIMFD.mat
% ec_indx1 = find(cell2mat(ecmwf_vimfd(:,4)) == 1 & cell2mat(ecmwf_vimfd(:,5)) == 2004);
% ec_indx2 = find(cell2mat(ecmwf_vimfd(:,4)) == 12 & cell2mat(ecmwf_vimfd(:,5)) == 2009);
% ecmwf_vimfd = ecmwf_vimfd(ec_indx1:ec_indx2,:);
% 
% cd /home/lorenz-c/Dokumente/GRACE/SHBundle
% 
% W = gaussfltr(200, 500);
% W = W*ones(1,401);
% 
% for i = 1:72
%     tmp1 = [ecmwf_vimfd{i,9}(:, 361:end) ecmwf_vimfd{i,9}(:, 1:360)];
%     tmp2 = cs2sc(gsha(tmp1, 'ls', 'cell', 200));
%     tmp3 = tmp2.*W;
%     
%     ecflt{i,1} = ecmwf_vimfd{i,4};
%     ecflt{i,2} = ecmwf_vimfd{i,5};  
%     ecflt{i,3} = gshs(tmp3, 'none', 'cell', 360, 0, 0, 0, 'grace', 1);
% end
% keyboard
% save ecflt.mat ecflt
% clear all
% 
% load /media/storage/Data/Mflux/MERRA/MERRA_VIMFD.mat
% mr_indx1 = find(cell2mat(merra_vimfd(:,4)) == 1 & cell2mat(merra_vimfd(:,5)) == 2004);
% mr_indx2 = find(cell2mat(merra_vimfd(:,4)) == 12 & cell2mat(merra_vimfd(:,5)) == 2009);
% merra_vimfd = merra_vimfd(mr_indx1:mr_indx2,:);
% 
% cd /home/lorenz-c/Dokumente/GRACE/SHBundle
% 
% W = gaussfltr(200, 500);
% W = W*ones(1,401);
% 
% for i = 1:72
%     
%     tmp1 = [merra_vimfd{i,9}(:, 361:end) merra_vimfd{i,9}(:, 1:360)];
%     tmp2 = cs2sc(gsha(tmp1, 'ls', 'cell', 200));
%     tmp3 = tmp2.*W;
%     
%     mcflt{i,1} = merra_vimfd{i,4};
%     mcflt{i,2} = merra_vimfd{i,5};  
%     mcflt{i,3} = gshs(tmp3, 'none', 'cell', 360, 0, 0, 0, 'grace', 1);
% end
% 
% save mrflt.mat mrflt
% clear all
% 
% 
% 
% 
% load /media/storage/Data/Mflux/CFSR/CFSR_VIMFD.mat
% cf_indx1 = find(cell2mat(cfsr_vimfd(:,4)) == 1 & cell2mat(cfsr_vimfd(:,5)) == 2004);
% cf_indx2 = find(cell2mat(cfsr_vimfd(:,4)) == 12 & cell2mat(cfsr_vimfd(:,5)) == 2009);
% cfsr_vimfd = cfsr_vimfd(cf_indx1:cf_indx2,:);
% 
% 
% cd /home/lorenz-c/Dokumente/GRACE/SHBundle
% 
% W = gaussfltr(200, 500);
% W = W*ones(1,401);
% 
% 
% 
% 
% for i = 1:72
% 
%     
%     tmp1 = [cfsr_vimfd{i,9}(:, 361:end) cfsr_vimfd{i,9}(:, 1:360)];
%     tmp2 = cs2sc(gsha(tmp1, 'ls', 'cell', 200));
%     tmp3 = tmp2.*W;
%     
%     cfflt{i,1} = cfsr_vimfd{i,4};
%     cfflt{i,2} = cfsr_vimfd{i,5};  
%     cfflt{i,3} = gshs(tmp3, 'none', 'cell', 360, 0, 0, 0, 'grace', 1);
%       
% end
% 
% save cfflt.mat cfflt


% % mdiv_ecmwf = spataggmn(ecmwf_vimfd, indexfile3, [193, 183, 320], 'clms', [4 5 9]);
% % 
% % clear ecmwf_vimfd
% 
% % load /media/storage/Data/Mflux/MERRA/MERRA_VIMFD.mat
% % mdiv_merra = spataggmn(merra_vimfd, indexfile3, [193, 183, 320], 'clms', [4 5 9]);
% % 
% % clear merra_vimfd
% 
% % load /media/storage/Data/Runoff/GRDC/Runoff_review_2011.mat
% % 
% % R = [Runoff_review(:, 1:2) Runoff_review(:, [3 9 17])];
% % 
% % load /home/lorenz-c/Downloads/gfz4mdsg500_der_c.mat
% % 
% % 
% % for i = 1:98
% %     gfz4mdsg500_der_c{i,5} = [gfz4mdsg500_der_c{i,5}(:, 361:end) gfz4mdsg500_der_c{i,5}(:, 1:360)];
% % end
% % 
% % grace = spataggmn(gfz4mdsg500_der_c, indexfile3, [193, 183, 320], 'clms', [2 1 5]);
% 
% ec_indx1 = find(mdiv_ecmwf(:,1) == 1 & mdiv_ecmwf(:,2) == 2004);
% ec_indx2 = find(mdiv_ecmwf(:,1) == 12 & mdiv_ecmwf(:,2) == 2009);
% 
% % mr_indx1 = find(mdiv_merra(:,1) == 1 & mdiv_merra(:,2) == 2003);
% % mr_indx2 = find(mdiv_merra(:,1) == 12 & mdiv_merra(:,2) == 2008);
% 
% % gr_indx1 = find(grace(:,1) == 1 & grace(:,2) == 2004);
% % gr_indx2 = find(grace(:,1) == 12 & grace(:,2) == 2009);
% 
% % grace = grace(gr_indx1:gr_indx2,:);
% 
% rf_indx1 = find(R(:,2) == 1 & R(:,1) == 2004);
% rf_indx2 = find(R(:,2) == 12 & R(:,1) == 2009);
% 
% 
% dsdt_ecmwf = mdiv_ecmwf(ec_indx1:ec_indx2,:);
% dsdt_ecmwf(:, 4:end) = -dsdt_ecmwf(:, 4:end) - R(rf_indx1:rf_indx2, 3:end);
% % 
% dsdt_merra = mdiv_merra(mr_indx1:mr_indx2,:);
% dsdt_merra = -dsdt_merra(:, 4:end) - R(:, 4:end);
% clear all
% clc


load /media/storage/Analysis/ecflt.mat
load indexfile3.asc

ecmwf = spataggmn(ecflt, indexfile3, [193, 183, 320, 29], 'clms', [1 2 3]);
clear ecflt

load /media/storage/Analysis/mcflt.mat

merra = spataggmn(mcflt, indexfile3, [193, 183, 320, 29], 'clms', [1 2 3]);
clear mcflt

load /media/storage/Analysis/cfflt.mat
load indexfile3.asc

cfsr = spataggmn(cfflt, indexfile3, [193, 183, 320, 29], 'clms', [1 2 3]);
clear cfflt

load /home/lorenz-c/Dokumente/gfz4mdsg500_der_c.mat
for i = 1:98
    gfz4mdsg500_der_c{i,5} = [gfz4mdsg500_der_c{i,5}(:,361:end) gfz4mdsg500_der_c{i,5}(:,1:360)];
end

grace = spataggmn(gfz4mdsg500_der_c, indexfile3, [193, 183, 320, 29], 'clms', [2 1 5]);
clear gfz4mdsg500_der_c i


load /media/storage/Data/Runoff/GRDC/GRDC_R.mat








