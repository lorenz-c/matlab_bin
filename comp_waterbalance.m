function [wb1 wb2] = comp_waterbalance(set)

load continents.asc

A = area_wghts(0.25:0.5:179.75, 'mat');

mask_l = gen_mask(1);
mask_o = gen_mask(2);

A_lnd = sum(sum(mask_l.*A));
A_ocn = sum(sum(mask_o.*A));


if strcmp(set, 'cfsr')
    load /media/storage/Data/Precipitation/CFSR/CFSR_PREC.mat
    P = spataggmn(cfsr_prec, mask_l, [1, 0], 'clms', [4 5 9]);
    tmp = spataggmn(cfsr_prec, ones(360, 720), 1, 'clms', [4 5 9]);
    P = [P tmp(:,end)];
    clear cfsr*
    
    load /media/storage/Data/Evaporation/CFSR/CFSR_ET.mat
    ET = spataggmn(cfsr_et, mask_l, [1 0], 'clms', [4 5 9]);
    tmp = spataggmn(cfsr_et, ones(360, 720), 1, 'clms', [4 5 9]);
    ET = [ET tmp(:,end)];
    clear cfsr*
    
    load /media/storage/Data/Runoff/CFSR/CFSR_R.mat
    R  =  spataggmn(cfsr_r, mask_l, 1, 'clms', [4 5 9]);
    clear cfsr*
        
    load /media/storage/Data/Mflux/CFSR/CFSR_VIMFD.mat
    DQ = spataggmn(cfsr_vimfd, mask_l, [1 0], 'clms', [4 5 9]);
    tmp = spataggmn(cfsr_vimfd, ones(360, 720), 1, 'clms', [4 5 9]);
    DQ = [DQ tmp(:,end)];
    clear cfsr*
    
    load /media/storage/Data/Total_water_atm/CFSR/CFSR_TQV.mat
    DW = spataggmn(cfsr_tqv, mask_l, [1 0], 'clms', [4 5 9]);
    tmp = spataggmn(cfsr_tqv, ones(360, 720), 1, 'clms', [4 5 9]);
    DW = [DW tmp(:,end)];
    
    DWDT = cdiffts(DW(2:end,:), [1 1989 12 2006], 'clms', [1 2 4]);
    clear cfsr_tqv DW
    keyboard

    
elseif strcmp(set, 'merra')
    load /media/storage/Data/Precipitation/MERRA/MERRA_PREC.mat
    P = spataggmn(merra_prec, mask_l, [1, 0], 'clms', [4 5 9]);
    tmp = spataggmn(merra_prec, ones(360, 720), 1, 'clms', [4 5 9]);
    P = [P tmp(:,end)];
    clear cfsr*
    
    load /media/storage/Data/Evaporation/MERRA/MERRA_ET.mat
    ET = spataggmn(merra_et, mask_l, [1 0], 'clms', [4 5 9]);
    tmp = spataggmn(merra_et, ones(360, 720), 1, 'clms', [4 5 9]);
    ET = [ET tmp(:,end)];
    clear cfsr*
    
    load /media/storage/Data/Runoff/MERRA/MERRA_R.mat
    R  =  spataggmn(merra_r, mask_l, 1, 'clms', [4 5 9]);
    clear cfsr*
        
    load /media/storage/Data/Mflux/MERRA/MERRA_VIMFD.mat
    DQ = spataggmn(merra_vimfd, mask_l, [1 0], 'clms', [4 5 9]);
    tmp = spataggmn(merra_vimfd, ones(360, 720), 1, 'clms', [4 5 9]);
    DQ = [DQ tmp(:,end)];
    clear cfsr*
    
    load /media/storage/Data/Total_water_atm/MERRA/MERRA_TQV.mat
    DW = spataggmn(merra_tqv, mask_l, [1 0], 'clms', [4 5 9]);
    tmp = spataggmn(merra_tqv, ones(360, 720), 1, 'clms', [4 5 9]);
    DW = [DW tmp(:,end)];
    
    DWDT = cdiffts(DW(2:end,:), [1 1989 12 2006], 'clms', [1 2 4]);
    clear cfsr_tqv DW
    keyboard

elseif strcmp(set, 'ecmwf')
    load /media/storage/Data/Precipitation/ECMWF/ECMWF_PREC.mat
    P_l = comp_glob_quant(ecmwf_prec, [1989 2006], 1, 'annual', [4 5 9], -9999, 0);
    P_o = comp_glob_quant(ecmwf_prec, [1989 2006], 2, 'annual', [4 5 9], -9999, 0);
    P_c = comp_glob_quant(ecmwf_prec, [1989 2006], 0, 'annual', [4 5 9], -9999, 0);
    clear ecmwf_prec

    load /media/storage/Data/Evaporation/ECMWF/ECMWF_ET.mat
    ET_l = comp_glob_quant(ecmwf_et, [1989 2006], 1, 'annual', [4 5 9], -9999, 0);
    ET_o = comp_glob_quant(ecmwf_et, [1989 2006], 2, 'annual', [4 5 9], -9999, 0);
    ET_c = comp_glob_quant(ecmwf_et, [1989 2006], 0, 'annual', [4 5 9], -9999, 0);
    clear ecmwf_et

    load /media/storage/Data/Runoff/ECMWF/ECMWF_R.mat
    R  = comp_glob_quant(ecmwf_r, [1989 2006], 1, 'annual', [4 5 9], 'NaN', 0);
    clear ecmwf_r

    load /media/storage/Data/Mflux/ECMWF/ECMWF_VIMFD.mat
    DQ_l = comp_glob_quant(ecmwf_vimfd, [1989 2006], 1, 'annual', [4 5 9], -9999, 0);
    DQ_o = comp_glob_quant(ecmwf_vimfd, [1989 2006], 2, 'annual', [4 5 9], -9999, 0);
    DQ_c = comp_glob_quant(ecmwf_vimfd, [1989 2006], 0, 'annual', [4 5 9], -9999, 0);
    clear ecmwf_vimfd
    
    load /media/storage/Data/Total_water_atm/ECMWF/ECMWF_TQV.mat
    dwdt = cdiffcell(ecmwf_tqv, 'time', [1979 2009], 'clms', [4 5 9]);
    DW_l = comp_glob_quant(dwdt, [1989 2006], 1, 'annual', [1 2 3], -9999, 0);
    DW_o = comp_glob_quant(dwdt, [1989 2006], 2, 'annual', [1 2 3], -9999, 0);
    DW_c = comp_glob_quant(dwdt, [1989 2006], 0, 'annual', [1 2 3], -9999, 0);
    clear ecmwf_tqv dwdt
      
    
end

% keyboard

% Absolute quantities
wb2(1) = mean(P_l(:,2))*12*A_lnd;                 % Continental prec.
wb2(2) = mean(ET_l(:,2))*12*A_lnd;                % Continental evap.
wb2(3) = mean(R(:,2))*12*A_lnd;                   % Runoff
wb2(4) = mean(DQ_l(:,2))*12*A_lnd;                % Continental moist. flx.
wb2(5) = mean(DW_l(:,2))*12*A_lnd;                % Continental wat. vap.

wb2(6) = mean(P_o(:,2))*12*A_ocn;                 % Oceanic pre.
wb2(7) = mean(ET_o(:,2))*12*A_ocn;                % Oceanic evap.
wb2(8) = mean(DQ_o(:,2))*12*A_ocn;                % Oceanic moist. flx.
wb2(9) = mean(DW_o(:,2))*12*A_ocn;                % Oceanic wat. vap. 

wb2(10) = mean(P_c(:,2))*12*(A_ocn+A_lnd);        % Global prec.
wb2(11) = mean(ET_c(:,2))*12*(A_ocn+A_lnd);       % Global evap.
wb2(12) = mean(DQ_c(:,2))*12*(A_ocn+A_lnd);       % Global moist. flx.
wb2(13) = mean(DW_c(:,2))*12*(A_ocn+A_lnd);       % Global wat. vap. 

% Budget terms  
wb2(14) = wb2(1) - wb2(2);                        % Continental P - E
wb2(15) = wb2(6) - wb2(7);                        % Oceanic P - E
wb2(16) = wb2(10) - wb2(11);                      % Global P - E



% Absolute quantities
% wb1(:,1) = P_l(:,2)*A_lnd;                     % Continental prec.
% wb1(:,2) = ET_l(:,2)*A_lnd;                    % Continental evap.
% wb1(:,3) = R(:,2)*A_lnd;                       % Runoff
% wb1(:,4) = -DQ_l(:,2)*A_lnd;                    % Continental moist. flx.
% wb1(:,5) = DW_l(:,2)*A_lnd;                    % Continental wat. vap.
% 
% wb1(:,6) = P_o(:,2)*A_ocn;                     % Oceanic pre.
% wb1(:,7) = ET_o(:,2)*A_ocn;                    % Oceanic evap.
% wb1(:,8) = -DQ_o(:,2)*A_ocn;                    % Oceanic moist. flx.
% wb1(:,9) = DW_o(:,2)*A_ocn;                    % Oceanic wat. vap. 
% 
% wb1(:,10) = P_c(:,2)*(A_lnd+A_ocn);            % Global prec.
% wb1(:,11) = ET_c(:,2)*(A_lnd+A_ocn);           % Global evap.
% wb1(:,12) = -DQ_c(:,2)*(A_lnd+A_ocn);           % Global moist. flx.
% wb1(:,13) = DW_c(:,2)*(A_lnd+A_ocn);           % Global wat. vap. 
% 
% % Budget terms  
% wb1(:,14) = wb1(:,1) - wb1(:,2);                  % Continental P - E
% wb1(:,15) = wb1(:,6) - wb1(:,7);                  % Oceanic P - E
% wb1(:,16) = wb1(:,10) - wb1(:,11);                % Global P - E




wb1(:,1) = P_l(:,2)*12*A_lnd;                     % Continental prec.
wb1(:,2) = ET_l(:,2)*12*A_lnd;                    % Continental evap.
wb1(:,3) = R(:,2)*12*A_lnd;                       % Runoff
wb1(:,4) = -DQ_l(:,2)*12*A_lnd;                    % Continental moist. flx.
wb1(:,5) = DW_l(:,2)*12*A_lnd;                    % Continental wat. vap.

wb1(:,6) = P_o(:,2)*12*A_ocn;                     % Oceanic pre.
wb1(:,7) = ET_o(:,2)*12*A_ocn;                    % Oceanic evap.
wb1(:,8) = -DQ_o(:,2)*12*A_ocn;                    % Oceanic moist. flx.
wb1(:,9) = DW_o(:,2)*12*A_ocn;                    % Oceanic wat. vap. 

wb1(:,10) = P_c(:,2)*12*(A_ocn+A_lnd);            % Global prec.
wb1(:,11) = ET_c(:,2)*12*(A_ocn+A_lnd);           % Global evap.
wb1(:,12) = -DQ_c(:,2)*12*(A_ocn+A_lnd);          % Global moist. flx.
wb1(:,13) = DW_c(:,2)*12*(A_ocn+A_lnd);           % Global wat. vap. 

% Budget terms  
wb1(:,14) = wb1(:,1) - wb1(:,2);                  % Continental P - E
wb1(:,15) = wb1(:,6) - wb1(:,7);                  % Oceanic P - E
wb1(:,16) = wb1(:,10) - wb1(:,11);                % Global P - E

