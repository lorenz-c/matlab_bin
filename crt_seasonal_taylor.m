load /media/storage/Data/Precipitation/GPCC/GPCC_PRECv4.0.mat
P_gpcc = comp_spat_mean(gpcc_prec, [1989 2006], 'monthly_2', [4,5,9], -9999,1);
clear gpcc*
sprintf('EIER')
load /media/storage/Data/Precipitation/CRU3/CRU3_PRECv3.0.mat
P_cru = comp_spat_mean(cru_prec, [1989 2006], 'monthly_2', [4,5,9], -9999,1);
clear cru*

load /media/storage/Data/Precipitation/CPC/CPC_PREC.mat
P_cpc = comp_spat_mean(cpc_prec, [1989 2006], 'monthly_2', [4,5,9], -9999,1);
clear cpc*

load /media/storage/Data/Precipitation/ECMWF/ECMWF_PREC.mat
P_ecmwf = comp_spat_mean(ecmwf_prec, [1989 2006], 'monthly_2', [4,5,9], -9999,1);
clear ecmwf*

load /media/storage/Data/Precipitation/MERRA/MERRA_PREC.mat
P_merra = comp_spat_mean(merra_prec, [1989 2006], 'monthly_2', [4,5,9], -9999,1);
clear merra*

load /media/storage/Data/Precipitation/CFSR/CFSR_PREC.mat
P_cfsr = comp_spat_mean(cfsr_prec, [1989 2006], 'monthly_2', [4,5,9], -9999,1);
clear cfsr*


mnth(1) = 1;
mnth(2) = 7;


for k = 1:2
for i = 1:18

    [Rt Et sigt] = taylor_stats_2d(P_gpcc{i,mnth(k)}, 3, -9999, P_cru{i,mnth(k)}, ...
                              P_cpc{i,mnth(k)}, P_ecmwf{i,mnth(k)}, P_merra{i,mnth(k)}, P_cfsr{i,mnth(k)});
    if i == 1
        for j = 1:11
            R{k,j}   = Rt(j,:);
            sig{k,j} = sigt(j,:);
            E{k,j}   = Et(j,:);
        end
    else
        for j = 1:11
            R{k,j}   =  [R{k,j}; Rt(j,:)];
            E{k,j}   =  [E{k,j}; Et(j,:)];
            sig{k,j} =  [sig{k,j}; sigt(j,:)];
            
        end
    end
end
end

for j = 1:2
    for i = 1:11
        E_n{j,i}   = E{j,i}./(sig{j,i}(:,1)*ones(1,6));
        sig_n{j,i} = sig{j,i}./(sig{j,i}(:,1)*ones(1,6));
    end
end


% for j = 1:4
%     for i = 1:11
%         mn_s{j}(i,:) = mean(sig{j,i},1);
%         mn_R{j}(i,:) = mean(R{j,i},1);
%         mn_E{j}(i,:) = (mn_s{j}(i,:).^2 + mn_s{j}(i,1).^2 - ...
%                        2*mn_s{j}(i,:).*mn_s{j}(i,1).*mn_R{j}(i,:)).^(1/2);
%     
%     end
%     mn_E{j} = mn_E{j}./(mn_s{j}(:,1)*ones(1,6));
%     mn_s{j} = mn_s{j}./(mn_s{j}(:,1)*ones(1,6));
% end


