% Comparison of annual precipitation in Europe
% clear all
close all
% 
% % loading the datasets
% load /home/lorenz-c/Data/Precipitation/E-Obs/E-OBS_PREC.mat
% load /home/lorenz-c/Data/Precipitation/MERRA/MERRA_PREC.mat
% load /home/lorenz-c/Data/Precipitation/ECMWF/ECMWF_PREC.mat
% load /home/lorenz-c/Data/Precipitation/GPCC/GPCC_PREC.mat
% load /home/lorenz-c/Data/Precipitation/CRU3/CRU3_PREC.mat
% % load /home/lorenz-c/Data/Precipitation/DEL/DEL_PREC.mat
% load /home/lorenz-c/Data/Precipitation/CFSR/CFSR_PREC.mat
% % 
% load /home/lorenz-c/Data/colormaps/precip_cmap.mat
% load /home/lorenz-c/Data/colormaps/rel_precip_cmap.mat

k = 1;
% % Computing the total annual precipitation of each dataset
% 
longi = eobs_prec{1,8};
lati  = eobs_prec{1,7};
load coast
% % 
% % 
setname{1} = 'GPCC';
setname{2} = 'E-OBS';
setname{3} = 'CRU3';
% setname{3} = 'DEL';
setname{4} = 'ECMWF';
setname{5} = 'MERRA';
setname{6} = 'CFSR';




year = 2000;
k = 1;
for i = 1:7

    r_eobs  = find(cell2mat(eobs_prec(:,5))  == year);
    r_merra = find(cell2mat(merra_prec(:,5)) == year);  
    r_ecmwf = find(cell2mat(ecmwf_prec(:,5)) == year);
    r_gpcc  = find(cell2mat(gpcc_prec(:,4))   == year);
    r_cfsr  = find(cell2mat(cfsr_prec(:,5))  == year);
    r_cru   = find(cell2mat(cru3_prec(:,5))  == year);
    
    
    merra{k,1} = zeros(101,232);
    ecmwf{k,1} = zeros(101,232);
    cru{k,1}   = zeros(101,232);
    gpcc{k,1}   = zeros(101,232);
    cfsr{k,1}  = zeros(101,232);
    eobs{k,1}  = zeros(101,232);
    
    
    % Datasets with monthly values
    for j = 1:12
        cfsr{k,1}  = cfsr{k,1}  + cfsr_prec{r_cfsr(j),9}(30:130, 280:511);
        merra{k,1} = merra{k,1} + merra_prec{r_merra(j),9}(30:130, 280:511);
        ecmwf{k,1} = ecmwf{k,1} + ecmwf_prec{r_ecmwf(j),9}(30:130, 280:511);
        cru{k,1}   = cru{k,1}   + cru3_prec{r_cru(j),9}(30:130, 280:511);
        gpcc{k,1}  = gpcc{k,1}  + gpcc_prec{r_gpcc(j),8}(30:130, 280:511);
%         del{k,1}   = del{k,1}   + del_prec{r_del(j),9}(30:130, 280:511);
    end
    
    % Datasets with daily values
    msk     = zeros(101,232);
    tmp_msk = zeros(101,232);
    
    for j = 1:length(r_eobs)
        tmp_msk(eobs_prec{r_eobs(j),9}~=-9999) = 1;
        msk = msk + tmp_msk;         
        eobs{k,1}(eobs_prec{r_eobs(j),9}~=-9999) =     ...
            eobs{k,1}(eobs_prec{r_eobs(j),9}~=-9999) + ...
            eobs_prec{r_eobs(j),9}(eobs_prec{r_eobs(j),9}~=-9999);
    end
    
    
%     eobs{k,1} = eobs{k,1}./msk;
    eobs{k,1}(msk<length(r_eobs)) = -9999;

    cfsr{k,1}(eobs{k,1}==-9999)  = -9999;
    merra{k,1}(eobs{k,1}==-9999) = -9999;
    ecmwf{k,1}(eobs{k,1}==-9999) = -9999;
    gpcc{k,1}(eobs{k,1}==-9999)   = -9999;
    cru{k,1}(eobs{k,1}==-9999)   = -9999;
    
%     cfsr{k,1}(eobs{k,1}~=-9999)  = cfsr{k,1}(eobs{k,1}~=-9999)/length(r_cfsr);
%     merra{k,1}(eobs{k,1}~=-9999) = merra{k,1}(eobs{k,1}~=-9999)/length(r_merra);
%     ecmwf{k,1}(eobs{k,1}~=-9999) = ecmwf{k,1}(eobs{k,1}~=-9999)/length(r_ecmwf);
%     del{k,1}(eobs{k,1}~=-9999)   = del{k,1}(eobs{k,1}~=-9999)/length(r_del);
%     cru{k,1}(eobs{k,1}~=-9999)   = cru{k,1}(eobs{k,1}~=-9999)/length(r_cru);
    
  
    
    k = k + 1;
    year = year + 1;
end


keyboard
clear *t2


dtasets{1} = gpcc;
dtasets{2} = eobs;
dtasets{3} = cru;
% dtasets{3} = del;
dtasets{4} = ecmwf;
dtasets{5} = merra;
dtasets{6} = cfsr;

keyboard

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
        caxis([-100 2500])
        colormap(precip_cmap)
    end
    
    clrbr = colorbar('horiz');
    set(clrbr, 'Position', [.3314 .08 .4 .01])  
    set(get(clrbr, 'xlabel'), 'String', '[mm/year]')
    
    tlte = ['Total annual precipitation for ', int2str(year)];
    mtit(tlte, 'fontsize', 14)
    
    fnme = ['Mn_prec_', int2str(year)];
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
        caxis([-1000 1000])    
        colormap(rel_precip_cmap)
    end
    tlte = ['Relative annual precipitation to GPCC for ', int2str(year)];
    mtit(tlte, 'fontsize', 14)
    fnme = ['Rel_prec_', int2str(year)];
    
    clrbr = colorbar('horiz');
    set(clrbr, 'Position', [.3314 .05 .4 .01])   
    set(get(clrbr, 'xlabel'), 'String', '[mm/year]')
    set(clrbr, 'xtick', -1000:250:1000);
    print('-depsc', fnme)
    
    year = year + 1;
end
% close all      
        
        










