function gpcp = read_gpcp(fnames)
% The function reads a file from GPCC and stores its values and the
% appropriate deviations in a structure variable


h = waitbar(0,'','Name','...% datafiles processed'); 
nr_files = length(fnames);

gpcp = [];

for i = 1:nr_files
    ncid = netcdf.open(fnames{i}, 'nowrite');
    year = str2num(fnames{i}(6:9));
    
    sig = netcdf.getvar(ncid, 3);
    err = netcdf.getvar(ncid, 4);
    
    for j = 1:size(sig,3)
        
        sig_tmp = double(flipud(sig(:,:,j)'));
        err_tmp = double(flipud(err(:,:,j)'));
           
        tmp{j,1} = 'GPCPv2.1';
        tmp{j,2} = 'PREC';
        tmp{j,3} = 1;
        tmp{j,4} = j;
        tmp{j,5} = year;
        tmp{j,6} = 'Global';
        tmp{j,7} = 89.75:-0.5:-89.75;
        tmp{j,8} = -179.75:0.5:179.75;
        tmp{j,9} = sig_tmp;
        tmp{j,10} = err_tmp;
        tmp{j,11} = '[mm/month]';
        
    end
        
    gpcp = [gpcp; tmp];
    netcdf.close(ncid)
    clear tmp
    waitbar(i/nr_files, h, [int2str((i*100)/nr_files) '%'])
end
close(h)    
    



