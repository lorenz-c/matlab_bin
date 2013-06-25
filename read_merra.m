function merra = read_merra(fnames, variable)


nr_files = size(fnames,1);

if strcmp(variable, 'PREC')
    nc_var = 'prectot'
    unit   = '[mm/month]';
elseif strcmp(variable, 'T2')
    nc_var = 't2m';
    unit   = '[°C]';
elseif strcmp(variable, 'TS')
    nc_var = 'ts';
    unit   = '[°K]';
elseif strcmp(variable, 'TQV')
    nc_var = 'tqv';
    unit   = '[mm]';
elseif strcmp(variable, 'TQI')
    nc_var = 'tqi';
    unit   = '[mm]';
elseif strcmp(variable, 'TQL')
    nc_var = 'tql';
    unit   = '[mm]';
end


merra = cell(nr_files,10);

h = waitbar(0,'','Name','Reading progress...');

for i = 1:nr_files
    ncid   = netcdf.open(fnames{i}, 'nowrite');
    year   = fnames{i}(end-12:end-9);
    month  = fnames{i}(end-8:end-7);
%     keyboard
    nr_days = daysinmonth(str2num(month), str2num(year));
    
    varid  = netcdf.inqVarID(ncid, nc_var);
    tmp    = netcdf.getvar(ncid, varid);
    netcdf.close(ncid)
    
    tmp    = double(tmp);
    tmp    = flipud(tmp');
    
    if strcmp(variable, 'PREC')
        tmp    = tmp * 3600 * 24 * nr_days;
    end
    
%     tmp    = resizem(tmp, [360, 720], 'bilinear');
     
    merra{i,1}  = 'MERRA';
    merra{i,2}  = variable;
    merra{i,3}  = 1;
    merra{i,4}  = str2num(month);
    merra{i,5}  = str2num(year);
    merra{i,6}  = 'Global';
%     merra{i,7}  = 89.75:-0.5:-89.75;
%     merra{i,8}  = -179.75:0.5:179.75;
    merra{i,9}  = tmp;
%     merra{i,10} = unit;
    
    waitbar(i/nr_files, h, [int2str(i) '/' int2str(nr_files) ' files'])
    sprintf([fnames{i}, '...Ok'])
end

close(h)