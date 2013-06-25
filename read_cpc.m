function cpc = read_cpc(fnames)
% The function reads a file from GPCC and stores its values and the
% appropriate deviations in a structure variable


h = waitbar(0,'','Name','...% datafiles processed'); 
nr_files = length(fnames);

cpc = [];

for i = 1:nr_files
    yr      = str2num(fnames{i}(5:8));

    ncid = netcdf.open(fnames{i}, 'nowrite');
    data = netcdf.getvar(ncid,3);
    
    for j = 1:12
        tmp{j,1} = 'CPC';
        tmp{j,2} = 'PREC';      
        tmp{j,3} = 1;
        tmp{j,4} = j;
        tmp{j,5} = yr;
        tmp{j,6} = 'Global';
        tmp{j,7} = 89.75:-0.5:-89.75;
        tmp{j,8} = -179.75:0.5:179.75;
        
        tmp{j,9} = data(:,:,j);
        tmp{j,9} = flipud(double(tmp{j,9}'));
        tmp{j,9} = [tmp{j,9}(:, 361:end) tmp{j,9}(:,1:360)];
        
        tmp{j,10} = '[mm/month]';
        
    end
    
    cpc = [cpc; tmp];
    clear tmp
    
    waitbar(i/nr_files, h, [int2str((i*100)/nr_files) '%'])
end
close(h)    
    



