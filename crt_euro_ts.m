merra_euro{1,1} = zeros(101,232);
merra_euro{2,1} = zeros(101,232);
merra_euro{3,1} = zeros(101,232);
merra_euro{4,1} = zeros(101,232);
merra_euro{5,1} = zeros(101,232);
merra_euro{6,1} = zeros(101,232);
merra_euro{7,1} = zeros(101,232);

ecmwf_euro{1,1} = zeros(101,232);
ecmwf_euro{2,1} = zeros(101,232);
ecmwf_euro{3,1} = zeros(101,232);
ecmwf_euro{4,1} = zeros(101,232);
ecmwf_euro{5,1} = zeros(101,232);
ecmwf_euro{6,1} = zeros(101,232);
ecmwf_euro{7,1} = zeros(101,232);

% gpcc_euro{1,1} = zeros(101,232);
% gpcc_euro{2,1} = zeros(101,232);
% gpcc_euro{3,1} = zeros(101,232);
% gpcc_euro{4,1} = zeros(101,232);
% gpcc_euro{5,1} = zeros(101,232);
% gpcc_euro{6,1} = zeros(101,232);
% gpcc_euro{7,1} = zeros(101,232);

eobs_euro{1,1} = zeros(101,232);
eobs_euro{2,1} = zeros(101,232);
eobs_euro{3,1} = zeros(101,232);
eobs_euro{4,1} = zeros(101,232);
eobs_euro{5,1} = zeros(101,232);
eobs_euro{6,1} = zeros(101,232);
eobs_euro{7,1} = zeros(101,232);

n_days = [366 365 365 365 366 365 365 365];

for i = 1:7
    for j = 1:12
        merra_euro{i,1} = merra_euro{i,1} + flipud(merra_t2{j+(i-1)*12,3}(30:130, 280:511));
        ecmwf_euro{i,1} = ecmwf_euro{i,1} + flipud(ecmwf_t2{j+(i-1)*12,3}(30:130, 280:511));
%         gpcc_euro{i,1}  = gpcc_euro{i,1}  + flipud(gpcc_prec{j+(i-1)*12,8}(30:130, 280:511));
    end
    merra_euro{i,1} = merra_euro{i,1}/12-273.15;
    ecmwf_euro{i,1} = ecmwf_euro{i,1}/12-273.15;
end


for i = 1:7
    for j = 1:n_days(i)
        tmp = zeros(101,232);
        tmp(eobs_t2{j+(i-1)*n_days(i),9}~=-9999) = eobs_t2{j+(i-1)*n_days(i),9}(eobs_t2{j+(i-1)*n_days(i),9}~=-9999);
        eobs_euro{i,1} = eobs_euro{i,1} + tmp;
    end
    eobs_euro{i,1} = eobs_euro{i,1}/n_days(i)*0.01;
end


for i = 1:7
    merra_euro{i,1}(eobs_t2{1,9}==-9999) = -9999;
    ecmwf_euro{i,1}(eobs_t2{1,9}==-9999) = -9999;
    eobs_euro{i,1}(eobs_t2{1,9}==-9999) = -9999;
%     gpcc_euro{i,1}(gpcc_euro{i,1}<0) = 0;
end
    



figure
subplot(1,3,1)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, eobs_euro{1,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('E-OBS')
hold off

% subplot(1,4,2)
% imagesc(eobs_t2{1,8}, eobs_t2{1,7}, gpcc_euro{1,1})
% axis xy 
% axis square
% hold on
% plot(long,lat,'k');
% % colormap(precip_cmap);
% % caxis([0 2000])
% title('GPCC')
% hold off

subplot(1,3,2)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, ecmwf_euro{1,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('ECMWF')
hold off

subplot(1,3,3)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, merra_euro{1,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('MERRA')
hold off




figure
subplot(1,3,1)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, eobs_euro{2,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('E-OBS')
hold off

% subplot(1,3,2)
% imagesc(eobs_prec{1,8}, eobs_prec{1,7}, gpcc_euro{2,1})
% axis xy 
% axis square
% hold on
% plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
% title('GPCC')
% hold off

subplot(1,3,2)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, ecmwf_euro{2,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('ECMWF')
hold off

subplot(1,3,3)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, merra_euro{2,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('MERRA')
hold off




figure
subplot(1,3,1)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, eobs_euro{3,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('E-OBS')
hold off

% subplot(1,4,2)
% imagesc(eobs_prec{1,8}, eobs_prec{1,7}, gpcc_euro{3,1})
% axis xy 
% axis square
% hold on
% plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
% title('GPCC')
% hold off

subplot(1,3,2)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, ecmwf_euro{3,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('ECMWF')
hold off

subplot(1,3,3)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, merra_euro{3,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('MERRA')
hold off




figure
subplot(1,3,1)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, eobs_euro{4,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('E-OBS')
hold off

% subplot(1,4,2)
% imagesc(eobs_prec{1,8}, eobs_prec{1,7}, gpcc_euro{4,1})
% axis xy 
% axis square
% hold on
% plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
% title('GPCC')
% hold off

subplot(1,3,2)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, ecmwf_euro{4,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('ECMWF')
hold off

subplot(1,3,3)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, merra_euro{4,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('MERRA')
hold off



figure
subplot(1,3,1)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, eobs_euro{5,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('E-OBS')
hold off

% subplot(1,4,2)
% imagesc(eobs_prec{1,8}, eobs_prec{1,7}, gpcc_euro{5,1})
% axis xy 
% axis square
% hold on
% plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
% title('GPCC')
% hold off

subplot(1,3,2)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, ecmwf_euro{5,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('ECMWF')
hold off

subplot(1,3,3)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, merra_euro{5,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('MERRA')
hold off


figure
subplot(1,3,1)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, eobs_euro{6,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('E-OBS')
hold off

% subplot(1,4,2)
% imagesc(eobs_prec{1,8}, eobs_prec{1,7}, gpcc_euro{6,1})
% axis xy 
% axis square
% hold on
% plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
% title('GPCC')
% hold off

subplot(1,3,2)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, ecmwf_euro{6,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('ECMWF')
hold off

subplot(1,3,3)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, merra_euro{6,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('MERRA')
hold off


figure
subplot(1,3,1)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, eobs_euro{7,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('E-OBS')
hold off

% subplot(1,4,2)
% imagesc(eobs_prec{1,8}, eobs_prec{1,7}, gpcc_euro{7,1})
% axis xy 
% axis square
% hold on
% plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
% title('GPCC')
% hold off

subplot(1,3,2)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, ecmwf_euro{7,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('ECMWF')
hold off

subplot(1,3,3)
imagesc(eobs_t2{1,8}, eobs_t2{1,7}, merra_euro{7,1})
axis xy 
axis square
hold on
plot(long,lat,'k');
% colormap(precip_cmap);
% caxis([0 2000])
title('MERRA')
hold off











    


