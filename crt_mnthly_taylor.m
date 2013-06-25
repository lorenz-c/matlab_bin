% R_ja = [];
% R_ju = [];
% E_ja = [];
% E_ju = [];
% S_ja = [];
% S_ju = [];
% 
% load /media/storage/Data/Precipitation/GPCC/GPCC_PRECv4.0.mat
% [R_ja, R_ju, E_ja, E_ju, S_ja, S_ju] = crt_taylorARSCHFOTZE(R_ja, R_ju, E_ja, E_ju, S_ja, S_ju, 1, gpcc_prec, gpcc_prec);
% 
% sprintf('GPCC done')
% 
% load /media/storage/Data/Precipitation/GPCP/GPCP_PRECv2.1.mat 
% [R_ja, R_ju, E_ja, E_ju, S_ja, S_ju] = crt_taylorARSCHFOTZE(R_ja, R_ju, E_ja, E_ju, S_ja, S_ju, 2, gpcc_prec, gpcp_prec);
% clear gpcp_prec
% sprintf('GPCP done')
% 
% load /media/storage/Data/Precipitation/CRU3/CRU3_PRECv3.0.mat
% [R_ja, R_ju, E_ja, E_ju, S_ja, S_ju] = crt_taylorARSCHFOTZE(R_ja, R_ju, E_ja, E_ju, S_ja, S_ju, 3, gpcc_prec, cru_prec);
% clear cru_prec
% sprintf('CRU done')
% 
% load /media/storage/Data/Precipitation/CPC/CPC_PREC.mat
% [R_ja, R_ju, E_ja, E_ju, S_ja, S_ju] = crt_taylorARSCHFOTZE(R_ja, R_ju, E_ja, E_ju, S_ja, S_ju, 4, gpcc_prec, cpc_prec);
% clear cpc_prec
% sprintf('CPC done')
% 
% load /media/storage/Data/Precipitation/ECMWF/ECMWF_PREC.mat
% [R_ja, R_ju, E_ja, E_ju, S_ja, S_ju] = crt_taylorARSCHFOTZE(R_ja, R_ju, E_ja, E_ju, S_ja, S_ju, 5, gpcc_prec, ecmwf_prec);
% clear ecmwf_prec
% sprintf('ECMWF done')
% 
% 
% load /media/storage/Data/Precipitation/MERRA/MERRA_PREC.mat
% [R_ja, R_ju, E_ja, E_ju, S_ja, S_ju] = crt_taylorARSCHFOTZE(R_ja, R_ju, E_ja, E_ju, S_ja, S_ju, 6, gpcc_prec, merra_prec);
% clear merra_prec
% sprintf('MERRA done')
% 
% 
% load /media/storage/Data/Precipitation/CFSR/CFSR_PREC.mat
% [R_ja, R_ju, E_ja, E_ju, S_ja, S_ju] = crt_taylorARSCHFOTZE(R_ja, R_ju, E_ja, E_ju, S_ja, S_ju, 7, gpcc_prec, cfsr_prec);
% clear cfsr_prec
% clear gpcc_prec
% sprintf('CFSR done')
% % 
% % keyboard
% save taylor_stats.mat
clear all
close all
load taylor_stats.mat

for i = 1:10
    E_ja{i} = E_ja{i}./(S_ja{i}(:,1)*ones(1,7));
    S_ja{i} = S_ja{i}./(S_ja{i}(:,1)*ones(1,7));
    
    E_ju{i} = E_ju{i}./(S_ju{i}(:,1)*ones(1,7));
    S_ju{i} = S_ju{i}./(S_ju{i}(:,1)*ones(1,7));   
end



fname_ja{1} = 'tlr_glb_ja.eps';
fname_ja{2} = 'tlr_nh_ja.eps';
fname_ja{3} = 'tlr_sh_ja.eps';
fname_ja{4} = 'tlr_tr_ja.eps';
fname_ja{5} = 'tlr_na_ja.eps';
fname_ja{6} = 'tlr_sa_ja.eps';
fname_ja{7} = 'tlr_e_ja.eps';
fname_ja{8} = 'tlr_af_ja.eps';
fname_ja{9} = 'tlr_as_ja.eps';
fname_ja{10} = 'tlr_au_ja.eps'



fname_ju{1} = 'tlr_glb_ju.eps';
fname_ju{2} = 'tlr_nh_ju.eps';
fname_ju{3} = 'tlr_sh_ju.eps';
fname_ju{4} = 'tlr_tr_ju.eps';
fname_ju{5} = 'tlr_na_ju.eps';
fname_ju{6} = 'tlr_sa_ju.eps';
fname_ju{7} = 'tlr_e_ju.eps';
fname_ju{8} = 'tlr_af_ju.eps';
fname_ju{9} = 'tlr_as_ju.eps';
fname_ju{10} = 'tlr_au_ju.eps';

tle_ja{1} = 'Global land January';
tle_ja{2} = 'Northern hemisphere January';
tle_ja{3} = 'Southern hemisphere January';
tle_ja{4} = '15S - 15N January';
tle_ja{5} = 'North America January';
tle_ja{6} = 'South America January';
tle_ja{7} = 'Europe January';
tle_ja{8} = 'Africa January';
tle_ja{9} = 'Asia January';
tle_ja{10} = 'Australia January';

tle_ju{1} = 'Global land July';
tle_ju{2} = 'Northern hemisphere July';
tle_ju{3} = 'Southern hemisphere July';
tle_ju{4} = '15S - 15N July';
tle_ju{5} = 'North America July';
tle_ju{6} = 'South America July';
tle_ju{7} = 'Europe July';
tle_ju{8} = 'Africa July';
tle_ju{9} = 'Asia July';
tle_ju{10} = 'Australia July';


%%
for i = 1:10
    h = figure('papersize', [4.5 4], 'paperunits', 'centimeters')
    axis([0 1 0 2]);
    
    [hp ht axl] = taylordiag_new(S_ja{1,i}, E_ja{1,i}, R_ja{1,i}, ...
                   'labelDTA', 0, 'tickrms', 0:0.25:1.25, 'titleSTD', 1, 'showlabelsRMS', 1);
    if i == 1
         grr = legend(hp(1,:), 'GPCC', 'GPCP', 'CRU', 'CPC', 'INTERIM', 'MERRA', 'CFSR');
         set(grr, 'fontsize', 20,'fontweight','bold')
         set(grr, 'location', 'Best')
         keyboard
    end
%     xlabel(tle_ja{i}, 'fontsize', 28)
%     set(get(axl(1,1).handle, 'Ylabel'), 'standard deviation (normalized)', 'fontsize', 14, 'Position', [1 2 3])
    print(fname_ja{i}, '-depsc2')
    close all
    
    h = figure('papersize', [4.5 4], 'paperunits', 'centimeters')
    axis([0 1 0 2]);
    [hp ht axl] = taylordiag_new(S_ju{1,i}, E_ju{1,i}, R_ju{1,i}, ...
                   'labelDTA', 0, 'tickRMS', 0:0.25:1.25, 'titleSTD', 1, 'showlabelsRMS', 1);
%     xlabel(tle_ju{i}, 'fontsize', 28)    
%     ylabel('standard deviation (normalized)', 'fontsize', 14)
    print(fname_ju{i}, '-depsc2')
    close all
    
end
               
               
    
    
    
           









