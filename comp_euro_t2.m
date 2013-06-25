% Comparison of annual precipitation in Europe
% clear all
close all
% 
% % loading the datasets
% load /home/lorenz-c/Data/Temperature/T2/E-Obs/EOBS_T2.mat
% load /home/lorenz-c/Data/Temperature/T2/MERRA/MERRA_T2.mat
% load /home/lorenz-c/Data/Temperature/T2/ECMWF/ECMWF_T2.mat
% load /home/lorenz-c/Data/Temperature/T2/CRU3/CRU3_T2.mat
% load /home/lorenz-c/Data/Temperature/T2/DEL/DEL_T2.mat
% load /home/lorenz-c/Data/Temperature/T2/CFSR/CFSR_T2.mat
% % 
% load /home/lorenz-c/Data/colormaps/t2_cmap.mat
% load /home/lorenz-c/Data/colormaps/rel_t2_cmap.mat
% 
% k = 1;
% % % Computing the total annual precipitation of each dataset
% % 
% longi = eobs_t2{1,8};
% lati  = eobs_t2{1,7};
% load coast
% % 
% % 
% setname{1} = 'E-OBS';
% setname{2} = 'CRU3';
% setname{3} = 'DEL';
% setname{4} = 'ECMWF';
% setname{5} = 'MERRA';
% setname{6} = 'CFSR';
% 
% 
% 
% 
% year = 2000;
% k = 1;
% for i = 1:7
% 
%     r_eobs  = find(cell2mat(eobs_t2(:,5))  == year);
%     r_merra = find(cell2mat(merra_t2(:,5)) == year);  
%     r_ecmwf = find(cell2mat(ecmwf_t2(:,5)) == year);
%     r_del   = find(cell2mat(del_t2(:,5))   == year);
%     r_cfsr  = find(cell2mat(cfsr_t2(:,5))  == year);
%     r_cru   = find(cell2mat(cru3_t2(:,5))  == year);
%     
%     
%     merra{k,1} = zeros(101,232);
%     ecmwf{k,1} = zeros(101,232);
%     cru{k,1}   = zeros(101,232);
%     del{k,1}   = zeros(101,232);
%     cfsr{k,1}  = zeros(101,232);
%     eobs{k,1}  = zeros(101,232);
%     
%     
%     % Datasets with monthly values
%     for j = 1:12
%         cfsr{k,1}  = cfsr{k,1}  + cfsr_t2{r_cfsr(j),9}(30:130, 280:511);
%         merra{k,1} = merra{k,1} + merra_t2{r_merra(j),9}(30:130, 280:511);
%         ecmwf{k,1} = ecmwf{k,1} + ecmwf_t2{r_ecmwf(j),9}(30:130, 280:511);
%         cru{k,1}   = cru{k,1}   + cru3_t2{r_cru(j),9}(30:130, 280:511);
%         del{k,1}   = del{k,1}   + del_t2{r_del(j),9}(30:130, 280:511);
%     end
%     
%     % Datasets with daily values
%     msk     = zeros(101,232);
%     tmp_msk = zeros(101,232);
%     
%     for j = 1:length(r_eobs)
%         tmp_msk(eobs_t2{r_eobs(j),9}~=-9999) = 1;
%         msk = msk + tmp_msk;         
%         eobs{k,1}(eobs_t2{r_eobs(j),9}~=-9999) =     ...
%             eobs{k,1}(eobs_t2{r_eobs(j),9}~=-9999) + ...
%             eobs_t2{r_eobs(j),9}(eobs_t2{r_eobs(j),9}~=-9999);
%     end
%     
%     
%     eobs{k,1} = eobs{k,1}./msk;
%     eobs{k,1}(msk==0) = -9999;
% 
%     cfsr{k,1}(eobs{k,1}<-100)  = -9999;
%     merra{k,1}(eobs{k,1}<-100) = -9999;
%     ecmwf{k,1}(eobs{k,1}<-100) = -9999;
%     del{k,1}(eobs{k,1}<-100)   = -9999;
%     cru{k,1}(eobs{k,1}<-100)   = -9999;
%     
%     cfsr{k,1}(eobs{k,1}~=-9999)  = cfsr{k,1}(eobs{k,1}~=-9999)/length(r_cfsr);
%     merra{k,1}(eobs{k,1}~=-9999) = merra{k,1}(eobs{k,1}~=-9999)/length(r_merra);
%     ecmwf{k,1}(eobs{k,1}~=-9999) = ecmwf{k,1}(eobs{k,1}~=-9999)/length(r_ecmwf);
%     del{k,1}(eobs{k,1}~=-9999)   = del{k,1}(eobs{k,1}~=-9999)/length(r_del);
%     cru{k,1}(eobs{k,1}~=-9999)   = cru{k,1}(eobs{k,1}~=-9999)/length(r_cru);
%     
%   
%     
%     k = k + 1;
%     year = year + 1;
% end
% 
% 
% 
% clear *t2
% 
% dtasets{1} = eobs;
% dtasets{2} = cru;
% dtasets{3} = del;
% dtasets{4} = ecmwf;
% dtasets{5} = merra;
% dtasets{6} = cfsr;



year = 2000;

for i = 1:7
    
   c = figure
   set(c,'paperunits','centimeters')
   set(c,'papertype','a4')
   set(c,'paperposition',[0.5,0.5,20,28])
   
    for j = 1:6
        subplot(3,2,j, 'align');
        imagesc(longi, lati, dtasets{j}{i});
        hold on
        plot(long,lat,'k');
        axis xy
        axis([-25 45 35 70]);
        pbaspect([70 35 1])
        title(setname{j});
        caxis([-5 20])
        colormap(t2_cmap)
    end
    
    clrbr = colorbar('horiz');
    set(clrbr, 'Position', [.3314 .08 .4 .01])  
    set(get(clrbr, 'xlabel'), 'String', '[°C]')
    
    tlte = ['Mean annual temperature at 2m for ', int2str(year)];
    mtit(tlte, 'fontsize', 14)
    
    fnme = ['Mn_t2_', int2str(year)];
    print('-depsc', fnme)
    
    c = figure
    set(c,'paperunits','centimeters')
    set(c,'papertype','a4')
    set(c,'paperposition',[0.5,0.5,20,28])
%     set(c,'paperposition',[0.5,0.5,28,20])
%     set(c,'PaperOrientation', 'landscape');
    
    for j = 2:6
        subplot(3,2,j-1, 'align');
        imagesc(longi, lati, dtasets{j}{i}-dtasets{1}{i});
        hold on
        plot(long,lat,'k');
        axis xy
        axis([-25 45 35 70]);
        pbaspect([70 35 1])
        title(setname{j});
        caxis([-6 6])    
        colormap(rel_t2_cmap)
    end
    tlte = ['Mean relative annual temperature at 2m to E-OBS for ', int2str(year)];
    mtit(tlte, 'fontsize', 14)
    fnme = ['Mn_rel_t2_', int2str(year)];
    
    clrbr = colorbar('horiz');
    set(clrbr, 'Position', [.3314 .05 .4 .01])   
    set(get(clrbr, 'xlabel'), 'String', '[°C]')
    set(clrbr, 'xtick', -6:2:6);
    print('-depsc', fnme)
    
    year = year + 1;
end
close all      
        
        










