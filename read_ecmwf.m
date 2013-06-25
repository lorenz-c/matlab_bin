function ecmwf = read_ecmwf(fname, varname)


nr_files = length(fname);

for i = 1:nr_files
    
    yr = str2num(fname{i}(1:4));
    mnth = str2num(fname{i}(5:6));
    
    ncid = netcdf.open(fname{i}, 'nowrite');
    dta  = netcdf.getvar(ncid, 3);
    
    ecmwf{i,1}  = 'ECMWF';
    ecmwf{i,2}  = varname;
    ecmwf{i,3}  = 1;
    ecmwf{i,4}  = mnth;
    ecmwf{i,5}  = yr;
    ecmwf{i,6}  = 'Global';
    ecmwf{i,7}  = 89.75:-0.5:-89.75;
    ecmwf{i,8}  = -179.75:0.5:179.75;
    ecmwf{i,9}  = double(flipud(dta'));
    ecmwf{i,10} = '[mm/month]';
    
end
        