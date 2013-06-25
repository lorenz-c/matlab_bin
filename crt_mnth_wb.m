function wb = crt_mnth_wb(set, cswitch)

% A = area_wghts(0.25:0.5:179.75, 0.5);
% A = A'; 
% A = A*ones(1,720);

if cswitch == 1
    if strcmp(set, 'cfsr')
    load /media/storage/Data/Precipitation/CFSR/CFSR_PREC.mat
    P_l = comp_glob_quant(cfsr_prec, [1989 2006], 1, 'monthly', [4 5 9], -9999, 1);
%     P_o = comp_glob_quant(cfsr_prec, [1989 2006], 2, 'monthly', [4 5 9], -9999, 1);
    clear cfsr_prec

    load /media/storage/Data/Evaporation/CFSR/CFSR_ET.mat
    ET_l = comp_glob_quant(cfsr_et, [1989 2006], 1, 'monthly', [4 5 9], -9999, 1);
%     ET_o = comp_glob_quant(cfsr_et, [1989 2006], 2, 'monthly', [4 5 9], -9999, 1);
    clear cfsr_et

    load /media/storage/Data/Runoff/CFSR/CFSR_R.mat
    R  = comp_glob_quant(cfsr_r, [1989 2006], 1, 'monthly', [4 5 9], 'NaN', 1);
    clear cfsr_r

    load /media/storage/Data/Mflux/CFSR/CFSR_VIMFD.mat
    DQ_l = comp_glob_quant(cfsr_vimfd, [1989 2006], 1, 'monthly', [4 5 9], -9999, 1);
%     DQ_o = comp_glob_quant(cfsr_vimfd, [1989 2006], 2, 'monthly', [4 5 9], -9999, 1);
    clear cfsr_vimfd
    
    load /media/storage/Data/Total_water_atm/CFSR/CFSR_TQV.mat
    dwdt = central_diff(cfsr_tqv, [1989, 2006], [4 5 9]);
    DW_l = comp_glob_quant(dwdt, [1989 2006], 1, 'monthly', [1 2 3], -9999, 1);
%     DW_o = comp_glob_quant(dwdt, [1989 2006], 2, 'monthlyl', [1 2 3], -9999, 1);
    clear cfsr_tqv dwdt
    
elseif strcmp(set, 'merra')
    load /media/storage/Data/Precipitation/MERRA/MERRA_PREC.mat
    P_l = comp_glob_quant(merra_prec, [1989 2006], 1, 'monthly', [4 5 9], -9999, 1);
%     P_o = comp_glob_quant(merra_prec, [1989 2006], 2, 'annual', [4 5 9], -9999, 1);
    clear merra_prec

    load /media/storage/Data/Evaporation/MERRA/MERRA_ET.mat
    ET_l = comp_glob_quant(merra_et, [1989 2006], 1, 'monthly', [4 5 9], -9999, 1);
%     ET_o = comp_glob_quant(merra_et, [1989 2006], 2, 'annual', [4 5 9], -9999, 1);
    clear merra_et

    load /media/storage/Data/Runoff/MERRA/MERRA_R.mat
    R  = comp_glob_quant(merra_r, [1989 2006], 1, 'monthly', [4 5 9], 'NaN', 1);
    clear merra_r

    load /media/storage/Data/Mflux/MERRA/MERRA_VIMFD.mat
    DQ_l = comp_glob_quant(merra_vimfd, [1989 2006], 1, 'monthly', [4 5 9], -9999, 1);
%     DQ_o = comp_glob_quant(merra_vimfd, [1989 2006], 2, 'annual', [4 5 9], -9999, 1);
    clear merra_vimfd
    
    load /media/storage/Data/Total_water_atm/MERRA/CFSR_TQV.mat
    dwdt = centra_diff(merra_tqv, [1989, 2006], [4 5 9]);
    DW_l = comp_glob_quant(dwdt, [1989 2006], 1, 'monthly', [1 2 3], -9999, 1);
%     DW_o = comp_glob_quant(dwdt, [1989 2006], 2, 'annual', [1 2 3], -9999, 1);
    clear merra_tqv dwdt
    
elseif strcmp(set, 'ecmwf')
    load /media/storage/Data/Precipitation/ECMWF/ECMWF_PREC.mat
    P_l = comp_glob_quant(ecmwf_prec, [1989 2006], 1, 'monthly', [4 5 9], -9999, 1);
%     P_o = comp_glob_quant(ecmwf_prec, [1989 2006], 2, 'annual', [4 5 9], -9999, 1);
    clear ecmwf_prec

    load /media/storage/Data/Evaporation/ECMWF/ECMWF_ET.mat
    ET_l = comp_glob_quant(ecmwf_et, [1989 2006], 1, 'monthly', [4 5 9], -9999, 1);
%     ET_o = comp_glob_quant(ecmwf_et, [1989 2006], 2, 'annual', [4 5 9], -9999, 1);
    clear ecmwf_et

    load /media/storage/Data/Runoff/ECMWF/ECMWF_R.mat
    R  = comp_glob_quant(ecmwf_r, [1989 2006], 1, 'monthly', [4 5 9], 'NaN', 1);
    clear ecmwf_r

    load /media/storage/Data/Mflux/ECMWF/ECMWF_VIMFD.mat
    DQ_l = comp_glob_quant(ecmwf_vimfd, [1989 2006], 1, 'monthly', [4 5 9], -9999, 1);
%     DQ_o = comp_glob_quant(ecmwf_vimfd, [1989 2006], 2, 'annual', [4 5 9], -9999, 1);
    clear ecmwf_vimfd
    
    load /media/storage/Data/Total_water_atm/ECMWF/ECMWF_TQV.mat
    dwdt = central_diff(ecmwf_tqv, [1989, 2006], [4 5 9]);
    DW_l = comp_glob_quant(dwdt, [1989 2006], 1, 'monthly', [1 2 3], -9999, 1);
%     DW_o = comp_glob_quant(dwdt, [1989 2006], 2, 'annual', [1 2 3], -9999, 1);
    clear ecmwf_tqv dwdt
    wb = [P_l' ET_l' R' DQ_l' DW_l'];
    end
elseif cswitch == 2
    
    if strcmp(set, 'cfsr')
    load /media/storage/Data/Precipitation/CFSR/CFSR_PREC.mat
    load /media/storage/Data/Evaporation/CFSR/CFSR_ET.mat
    
    for i = 1:length(cfsr_et)
        emnp{i,1} = cfsr_et{i,4};
        emnp{i,2} = cfsr_et{i,5};
        emnp{i,3} = cfsr_et{i,9} - cfsr_prec{i,9};
    end
    
    E_P = comp_cont_quant(emnp, [1989 2006], 'monthly', [1 2 3], -9999, 1);
    clear cfsr_* emnp


    load /media/storage/Data/Runoff/CFSR/CFSR_R.mat
    R  = comp_cont_quant(cfsr_r, [1989 2006],  'monthly', [4 5 9], 'NaN', 1);
    clear cfsr_r

    load /media/storage/Data/Mflux/CFSR/CFSR_VIMFD.mat
    DQ_l = comp_cont_quant(cfsr_vimfd, [1989 2006],'monthly', [4 5 9], -9999, 1);
%     DQ_o = comp_glob_quant(cfsr_vimfd, [1989 2006], 2, 'monthly', [4 5 9], -9999, 1);
    clear cfsr_vimfd
    
    load /media/storage/Data/Total_water_atm/CFSR/CFSR_TQV.mat
    dwdt = central_diff(cfsr_tqv, [1989, 2006], [4 5 9]);
    DW_l = comp_cont_quant(dwdt, [1989 2006], 'monthly', [1 2 3], -9999, 1);
%     DW_o = comp_glob_quant(dwdt, [1989 2006], 2, 'monthlyl', [1 2 3], -9999, 1);
    clear cfsr_tqv dwdt
    
elseif strcmp(set, 'merra')
    load /media/storage/Data/Precipitation/MERRA/MERRA_PREC.mat
    load /media/storage/Data/Evaporation/MERRA/MERRA_ET.mat
   
    for i = 1:length(merra_et)
        emnp{i,1} = merra_et{i,4};
        emnp{i,2} = merra_et{i,5};
        emnp{i,3} = merra_et{i,9} - merra_prec{i,9};
    end
    E_P = comp_cont_quant(emnp, [1989 2006], 'monthly', [1 2 3], -9999, 1);
    clear merra_* emnp


    load /media/storage/Data/Runoff/MERRA/MERRA_R.mat
    R  = comp_cont_quant(merra_r, [1989 2006], 'monthly', [4 5 9], 'NaN', 1);
    clear merra_r

    load /media/storage/Data/Mflux/MERRA/MERRA_VIMFD.mat
    DQ_l = comp_cont_quant(merra_vimfd, [1989 2006], 'monthly', [4 5 9], -9999, 1);
%     DQ_o = comp_glob_quant(merra_vimfd, [1989 2006], 2, 'annual', [4 5 9], -9999, 1);
    clear merra_vimfd
    
    load /media/storage/Data/Total_water_atm/MERRA/CFSR_TQV.mat
    dwdt = centra_diff(merra_tqv, [1989, 2006], [4 5 9]);
    DW_l = comp_cont_quant(dwdt, [1989 2006], 'monthly', [1 2 3], -9999, 1);
%     DW_o = comp_glob_quant(dwdt, [1989 2006], 2, 'annual', [1 2 3], -9999, 1);
    clear merra_tqv dwdt
    
elseif strcmp(set, 'ecmwf')
    
    load /media/storage/Data/Precipitation/ECMWF/ECMWF_PREC.mat
    load /media/storage/Data/Evaporation/ECMWF/ECMWF_ET.mat
    
    for i = 1:length(ecmwf_et)
        emnp{i,1} = ecmwf_et{i,4};
        emnp{i,2} = ecmwf_et{i,5};
        emnp{i,3} = ecmwf_et{i,9} - ecmwf_prec{i,9};
    end
    E_P = comp_cont_quant(emnp, [1989 2006], 'monthly', [1 2 3], -9999, 1);
    clear ecmwf_* emnp

    load /media/storage/Data/Runoff/ECMWF/ECMWF_R.mat
    R  = comp_cont_quant(ecmwf_r, [1989 2006], 'monthly', [4 5 9], 'NaN', 1);
    clear ecmwf_r

    load /media/storage/Data/Mflux/ECMWF/ECMWF_VIMFD.mat
    DQ_l = comp_cont_quant(ecmwf_vimfd, [1989 2006],  'monthly', [4 5 9], -9999, 1);
%     DQ_o = comp_glob_quant(ecmwf_vimfd, [1989 2006], 2, 'annual', [4 5 9], -9999, 1);
    clear ecmwf_vimfd
    
    load /media/storage/Data/Total_water_atm/ECMWF/ECMWF_TQV.mat
    dwdt = central_diff(ecmwf_tqv, [1989, 2006], [4 5 9]);
    DW_l = comp_cont_quant(dwdt, [1989 2006], 'monthly', [1 2 3], -9999, 1);
%     DW_o = comp_glob_quant(dwdt, [1989 2006], 2, 'annual', [1 2 3], -9999, 1);
    clear ecmwf_tqv dwdt
    end
    
    wb{1} = E_P;
    wb{2} = R;
    wb{3} = DQ_l;
    wb{4} = DW_l;
    
end






