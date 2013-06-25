function [gpcc_prec gpcc_ngaug] = read_gpcc(fnames)
% The function reads a file from GPCC and stores its values and the
% appropriate deviations in a structure variable


h = waitbar(0,'','Name','...% datafiles processed'); 
nr_files = length(fnames);

gpcc = cell(nr_files,4);

for i = 1:nr_files
    
    d    = importdata(fnames{i}, ' ', 14);
    dte  = fnames{i}(31:36);
    mnth = str2num(dte(1:2));
    yr   = str2num(dte(3:6));
%     fld = reshape(d.data(:,1), [720, 360]);
%     ers = reshape(d.data(:,2), [720, 360]);
    ngs = reshape(d.data(:,3), [720, 360]);
    
%     gpcc_prec{i,1} = 'GPCC v6.0';
%     gpcc_prec{i,2} = 'P';
%     gpcc_prec{i,3} = mnth;
%     gpcc_prec{i,4} = yr;
%     gpcc_prec{i,5} = 'Global';
%     gpcc_prec{i,6} = (89.75:-0.5:-89.75)';
%     gpcc_prec{i,7} = (-179.75:0.5:179.75)';
%     gpcc_prec{i,8} = fld';
%     gpcc_prec{i,9} = ers';
%     gpcc_prec{i,10} = '[mm/month]';
    
    gpcc_ngaug{i,1} = 'GPCC v6.0';
    gpcc_ngaug{i,2} = 'Nr of Gauges';
    gpcc_ngaug{i,3} = mnth;
    gpcc_ngaug{i,4} = yr;
    gpcc_ngaug{i,5} = 'Global'; 
    gpcc_ngaug{i,6} = (89.75:-0.5:-89.75)';
    gpcc_ngaug{i,7} = (-179.75:0.5:179.75)';
    gpcc_ngaug{i,8} = ngs';
    gpcc_ngaug{i,9} = '[gauges/gridcell]';
    
    
    
    waitbar(i/nr_files, h, [int2str((i*100)/nr_files) '%'])
end
gpcc_prec = 1;

close(h)    
    



