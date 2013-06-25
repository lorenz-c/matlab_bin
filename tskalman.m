clear all



load indexfile3.asc

% -------------------------------------------------------------------------
%             Compute the temporal covariance from a model
% -------------------------------------------------------------------------
% Note: This is still "under construction".....
% -------------------------------------------------------------------------
load /media/storage/Data/Precipitation/MERRA_LND/MERRA_LND_PREC_360x720.mat
load /media/storage/Data/Evaporation/MERRA_LND/MERRA_LND_ET_360x720.mat
load /media/storage/Data/Runoff/MERRA_LAND/MERRA_LND_R_360x720.mat

mask = zeros(360, 720);
mask(indexfile3 == 193) = 1;

mnths = cell2mat(merra_lnd_prec(:, 3));
yr    = cell2mat(merra_lnd_prec(:, 4));

% Compute P - E - R from MERRA-land
for i = 1:384
    PER{i,1} = merra_lnd_prec{i,8} - merra_lnd_et{i,8} - merra_lnd_r{i,8};
    PER{i,1}(isnan(PER{i,1})) = -9999;
end
clear merra*

[F_catch, c_indx] = cell2catchmat(PER, mask);

% Remove the mean and the trend from the catchment matrix
F_catch = detrend(F_catch);
F_catch = F_catch - ones(384,1)*mean(F_catch, 1);

for i = 1:12
    indx = find(mnths == i);
    mnth_mn = mean(F_catch(indx, :), 1);
    F_catch(indx, :) = F_catch(indx, :) - ones(32,1)*mnth_mn;
end




% Until this step, the computation is (hopefully) correct

% The "innovative" part:
% Compute the temporal covariance
covswitch = 3;
if covswitch == 1
    mdl_cov = 1/384*F_catch'*F_catch;            % Temporal autocorrelation
elseif covswitch == 2
    for i = 1:84
        mdl_cov{i,1} = F_catch(:,i)'*F_catch(:,i);
    end
elseif covswitch == 3
    % The Kurtenbach approach
    cov1    = 1/384*(F_catch'*F_catch);
    cov2    = 1/383*(F_catch(2:end,:)'*F_catch(1:end-1,:));
    
    % As cov1 is highly undertermined (rank cov1 = 372), a regularization
    % factor is applied
    cov1    = cov1 + eye(1529);
    
    mdl_cov = cov1 - cov2*inv(cov1)*cov2';
    B       = cov2*inv(cov1);
end

% Cleaning up....
clear F_catch PER i indx mnth_mn mnth yr



% -------------------------------------------------------------------------
%                 Compute the "observed" time-series 
% -------------------------------------------------------------------------
load /media/storage/Data/Runoff/GRDC/GRDC_R.mat
load /media/storage/Data/Mflux/MERRA/MERRA_VIMFD.mat

R = grdc_r(278:361,4);


vimfd = spataggmn(merra_vimfd, indexfile3, 193, 'clms', [4 5 9], ...
                              'theta', (89.75:-0.5:-89.75)');

% Check for the correct times...                          
grdc_r(278,1:2)
grdc_r(361,1:2)
vimfd(290,1:2)
vimfd(373,1:2)

vimfd = vimfd(290:373,4);

dSdt = -vimfd-R;

keyboard
% Cleaning up...
clear grdc_r merra* vimfd i R




% -------------------------------------------------------------------------
%                 Prepare the GRACE time-series 
% -------------------------------------------------------------------------
load /media/storage/Data/GRACE/casmmass.mat
grace = [casmmass(7:12,5); zeros(360, 720); casmmass(13:91,5)];

% Interpolate to fill the gap in June 2003...
grace{7,1} = 1/2*(grace{6,1}+grace{8,1}); 

% Compute the derivatives through central differences
for i = 2:length(grace)-1
    dMdt{i-1,1} = (grace{i+1} - grace{i-1})/2;
    dMdt{i-1,1} = [dMdt{i-1,1}(:, 361:end) dMdt{i-1,1}(:, 1:360)];
end

dmdt_catch = cell2catchmat(dMdt, mask);
dmdt_catch = dmdt_catch';

% keyboard
% Cleaning up...
clear grace casmmass i 


% -------------------------------------------------------------------------
%                 Set up the variables for the Kalman Filter
% -------------------------------------------------------------------------

% Initial state vector
x_0 = dmdt_catch(:,1);

% Process noise
Q   = cov2/1000;

% Observation noise
R   = [1; ones(length(x_0),1)/400];

% Compute the observation relation matrix
A = area_wghts((89.75:-0.5:-89.75)', 0.5, 'mat', 'haversine');
A_vec     = A(:);
mask_vec  = mask(:);

catch_vec = A_vec(c_indx).*mask_vec(c_indx);
catch_vec = catch_vec/sum(catch_vec);

H = [catch_vec'; eye(length(x_0))];

% Compute the observation vectors
y = [dSdt'; dmdt_catch];

% Cleaning up...
clear A A_vec mask_vec catch_vec 


% -------------------------------------------------------------------------
%                           Start filtering........
% -------------------------------------------------------------------------
for i = 1:20
    % Predictor step
    if i == 1
        x_p(:,i) = x_0;
        if covswitch == 1 | covswitch == 3
            P_p      = Q;
        elseif covswitch == 2
            P_p      = Q{1};
        end
    else
       
        if covswitch == 1
            x_p(:,i) = x_k(:,i-1);
            P_p      = P_k{i-1} + Q;
            
        elseif covswitch == 2
            x_p(:,i) = x_k(:,i-1);
            P_p      = P_k{i-1} + Q{i};
        elseif covswitch == 3
            x_p(:,i) = B*x_k(:,i-1);
            P_p      = B*P_k{i-1}*B' + Q;
        end
    end

    % Corrector step
    v_k = y(:,i) - H*x_p(:,i);
    S_k = H*P_p*H' + diag(R);
    K_k = P_p*H'*inv(S_k);
 
    x_k(:,i) = x_p(:,i) + K_k*v_k;
    P_k{i}   = P_p - K_k*S_k*K_k';
    
    % Cleaning up....
    clear v_k S_k K_k P_p
end
clear i




% -------------------------------------------------------------------------
%                    Doing the ugly analysis part...
% -------------------------------------------------------------------------
F_out = catchmat2cell(x_k', c_indx, 360, 720);
F_in  = catchmat2cell(dmdt_catch', c_indx, 360, 720);

for i = 1:84
    F_out{i,2} = F_out{i,1}(165:225, 200:250);
    F_in{i,2}  = F_in{i,1}(165:225, 200:250);
end


% Create some nice plots..
plotswitch = 1;

if plotswitch == 1
    theta = 89.75:-0.5:-89.75;
    lambda = -179.75:0.5:179.75;
    load coast
    
    for i = 1:12
        subplot(4,3,i)
        h = worldmap(F_out{i,2}, [2 7.75 -80.25]);
        geoshow(flipud(F_out{i,2}), [2, 7.75, -80.25], 'DisplayType', 'texturemap')
        geoshow(lat, long)
        caxis([-250 250])
    end
    
    for i = 13:24
        subplot(4,3,i-12)
        h = worldmap(F_out{i,2}, [2 7.75 -80.25]);
        geoshow(flipud(F_out{i,2}), [2, 7.75, -80.25], 'DisplayType', 'texturemap')
        geoshow(lat, long)
        caxis([-250 250])
    end
    
    for i = 25:36
        subplot(4,3,i-24)
        h = worldmap(F_out{i,2}, [2 7.75 -80.25]);
        geoshow(flipud(F_out{i,2}), [2, 7.75, -80.25], 'DisplayType', 'texturemap')
        geoshow(lat, long)
        caxis([-250 250])
    end
end


    
    















    


















































% function [] = tskalman(modlts, obsts)

% % Remove the trend and the mean from the TS
% modlts_c = modlts - mean(modlts);
% obsts_c  = obsts - mean(obsts);
% 
% 
% 
% % modlts_c = detrend(modlts_c);
% % obsts_c  = detrend(obsts_c);
% 
% n = length(modlts);
% 
% for i = 2:n
%     A(i-1,1) = modlts_c(i)/modlts_c(i-1);
% end
% 
% sig_r = 5;
% x_0 = 0;
% 
% R = 5;
% Q = 5;
% 
% for i = 1:n
%     % Predictor step
%     if i == 1
%         x_p(1) = x_0;
%         P_p(1) = R;
%     else
%         x_p(i) = A(i-1)*x_k(i-1);
%         P_p(i) = A(i-1)*P_k(i-1)*A(i-1) + R;
%     end
%     
%     % Corrector step
%     y_k = obsts_c(i) - x_p(i);
%     S_k = P_p(i) + Q;
%     K_k = P_p(i)/S_k;
%     
%     x_k(i) = x_p(i) + K_k*y_k;
%     P_k(i) = P_p(i) - K_k*S_k*K_k;
% end
% keyboard
% 
% 
% % [rsdl, estts, mn, trnd, yrcle] = centerts(modlts_c);
% % 
% % 
% % xht = [yrcle];
% % keyboard
% % sig_r = 5;
% % x_0 = 0;
% % 
% % B = [repmat(eye(12), [n/12, 1])];
% % 
% % keyboard           
% % for i = 1:n
% %     % Predictor step
% %     if i == 1
% %         x_p(1) = x_0 + B(i,:)*xht + rsdl(i);
% %         P_p(1) = rsdl(1);
% %     else
% %         x_p(i) = x_k(i-1) + B(i,:)*xht + rsdl(i);
% %         P_p(i) = P_k(i-1) + rsdl(i);
% %     end
% %     
% %     % Corrector step
% %     y_k = obsts_c(i) - x_p(i);
% %     S_k = P_p(i) + sig_r;
% %     K_k = P_p(i)/S_k;
% %     
% %     x_k(i) = x_p(i) + K_k*y_k;
% %     P_k(i) = P_p(i) - K_k*S_k*K_k;
% % end
% % 
% % keyboard
% 
% 
% 
% 
