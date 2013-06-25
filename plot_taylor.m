c_indx = [7 6 3 8 9 1];

fname{1} = 'P_taylor_NA';
fname{2} = 'P_taylor_SA';
fname{3} = 'P_taylor_E';
fname{4} = 'P_taylor_AF';
fname{5} = 'P_taylor_AS';
fname{6} = 'P_taylor_AU';

clr{1} = 'k';
clr{2} = 'm';
clr{3} = 'c';
clr{4} = 'b';
clr{5} = 'r';
clr{6} = 'g';

% for i = 1:6
%     for k = 1:2
    h = figure('papersize', [4.5 4], 'paperunits', 'centimeters')
    
%     [hp ht axl] = taylordiag_new(sig_n{k,c_indx(i)}, E_n{k,c_indx(i)},   ...
%                       R{k,c_indx(i)}, 'colRMS', 'k', 'colSTD', 'k',   ...
%                       'colCOR', 'k', 'styleRMS', '-', 'tickSTD',         ...
%                       0:0.25:2, 'tickRMS', 0:0.25:1.25, 'limSTD', 2, ... 
%                       'titleCOR', 'Correlation', 'titleSTD', ' ', ...
%                       'titleRMS', ' ', 'labeldta', 0, 'pointclr', clr )
    [hp ht axl] = taylordiag_new(sig_n_jan, E_n_jan,   ...
                      R_jan, 'colRMS', 'k', 'colSTD', 'k',   ...
                      'colCOR', 'k', 'styleRMS', '-', 'tickSTD',         ...
                      0:0.25:2, 'tickRMS', 0:0.25:1.25, 'limSTD', 2, ... 
                      'titleCOR', 'Correlation', 'titleSTD', ' ', ...
                      'titleRMS', ' ', 'labeldta', 0, 'pointclr', clr )

              
%     set(axl(1,1).handle, 'string', '\sigma_P', 'fontsize', 20)
%     if i == 1 && k == 1
        yps = legend(hp(1,:), 'GPCC', 'CRU', 'CPC', 'ECMWF', 'MERRA', 'CFSR')
        set(yps, 'fontsize', 20, 'location', 'southwest')
        keyboard
        print(h, '-depsc2', 'cont_mean_jan.eps')   
     

     h = figure('papersize', [4.5 4], 'paperunits', 'centimeters')
    
%     [hp ht axl] = taylordiag_new(sig_n{k,c_indx(i)}, E_n{k,c_indx(i)},   ...
%                       R{k,c_indx(i)}, 'colRMS', 'k', 'colSTD', 'k',   ...
%                       'colCOR', 'k', 'styleRMS', '-', 'tickSTD',         ...
%                       0:0.25:2, 'tickRMS', 0:0.25:1.25, 'limSTD', 2, ... 
%                       'titleCOR', 'Correlation', 'titleSTD', ' ', ...
%                       'titleRMS', ' ', 'labeldta', 0, 'pointclr', clr )
    [hp ht axl] = taylordiag_new(sig_n_jul, E_n_jul,   ...
                      R_jul, 'colRMS', 'k', 'colSTD', 'k',   ...
                      'colCOR', 'k', 'styleRMS', '-', 'tickSTD',         ...
                      0:0.25:2, 'tickRMS', 0:0.25:1.25, 'limSTD', 2, ... 
                      'titleCOR', 'Correlation', 'titleSTD', ' ', ...
                      'titleRMS', ' ', 'labeldta', 0, 'pointclr', clr )

              
%     set(axl(1,1).handle, 'string', '\sigma_P', 'fontsize', 20)
%     if i == 1 && k == 1
%         yps = legend(hp(1,:), 'GPCC', 'CRU', 'CPC', 'ECMWF', 'MERRA', 'CFSR')
%         set(yps, 'fontsize', 20, 'location', 'southwest')
%         keyboard
     print(h, '-depsc2', 'cont_mean_jul.eps')   
%     end
% %     if k == 1
%         fnme = ['cont_mean_, '_Jan.eps'];
%     elseif k == 2
%         fnme = [fname{i}, '_Jul.eps'];
%     elseif k == 3
%         fnme = [fname{i}, '_JAS.eps'];
%     elseif k == 4
%         fnme = [fname{i}, '_OND.eps'];
% %     end
%     print(h, '-depsc2', fnme)
%     close all
%     end
% end
%     
    