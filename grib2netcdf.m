function [] = grib2netcdf(fname, varname, outnme, sdate)


if nargin < 4
    mnth = 1;
    yr   = 1979;
else
    mnth = sdate(1);
    yr   = sdate(2);
end

tme       = nj_varget(fname, 'time');
tme_axis  = nj_attget(fname, 'time', '_CoordinateAxisType');


lon       = nj_varget(fname, 'lon');
lon_units = nj_attget(fname, 'lon', 'units');
lon_name  = nj_attget(fname, 'lon', 'long_name');
lon_axis  = nj_attget(fname, 'lon', '_CoordinateAxisType');

lat       = nj_varget(fname, 'lat');
lat_units = nj_attget(fname, 'lat', 'units');
lat_name  = nj_attget(fname, 'lat', 'long_name');
lat_axis  = nj_attget(fname, 'lat', '_CoordinateAxisType');

unit = nj_attget(fname, varname, 'units');
name = nj_attget(fname, varname, 'long_name');
mval = nj_attget(fname, varname, 'missing_value');



for i = 1:length(tme)
    
    tmp = nj_varget(fname, varname, [i  1 1], [1 inf inf]);
    tmp = tmp';
    
    data(1,:,:) = tmp;
    
    
    tme_units = ['days since ', num2str(yr), '-', num2str(mnth), '-1 0'];
    
    if mnth < 10
        outnme_f = [outnme, num2str(yr), '0', num2str(mnth), '.nc'];
    else
        outnme_f = [outnme, num2str(yr), num2str(mnth), '.nc'];
    end
    
    
    ncid   = netcdf.create(outnme_f, 'NC_WRITE');
    
    time_dim_id = netcdf.defDim(ncid, 'time', 1);
    lon_dim_id  = netcdf.defDim(ncid, 'longitude', length(lon));
    lat_dim_id  = netcdf.defDim(ncid, 'latitude', length(lat));

    time_var_id = netcdf.defVar(ncid, 'time', 'double', time_dim_id);
    lon_var_id  = netcdf.defVar(ncid, 'longitude', 'double', lon_dim_id);
    lat_var_id  = netcdf.defVar(ncid, 'latitude', 'double', lat_dim_id);
    
    data_var_id = netcdf.defVar(ncid, varname, 'double', ...
                                    [lon_dim_id lat_dim_id time_dim_id]);
    
    
    netcdf.endDef(ncid);
    
    netcdf.putVar(ncid, time_var_id,  0);
    netcdf.putVar(ncid, lon_var_id, lon);
    netcdf.putVar(ncid, lat_var_id, lat);
    netcdf.putVar(ncid, data_var_id, data);
    
    netcdf.reDef(ncid)
    netcdf.putAtt(ncid, time_var_id, 'units', tme_units);
    netcdf.putAtt(ncid, time_var_id, '_CoordinateAxisType', tme_axis);
    
    
    netcdf.putAtt(ncid, lon_var_id, 'units', lon_units);
    netcdf.putAtt(ncid, lon_var_id, 'long_name', lon_name);
    netcdf.putAtt(ncid, lon_var_id, '_CoordinateAxisType', lon_axis);
    
    
    netcdf.putAtt(ncid, lat_var_id, 'units', lat_units);
    netcdf.putAtt(ncid, lat_var_id, 'long_name', lat_name);
    netcdf.putAtt(ncid, lat_var_id, '_CoordinateAxisType', lat_axis);
    
    
    netcdf.putAtt(ncid, data_var_id, 'units', unit);
    netcdf.putAtt(ncid, data_var_id, 'long_name', name);
    netcdf.putAtt(ncid, data_var_id, 'missing_value', mval);
    
    netcdf.close(ncid);
    
    mnth = mnth + 1;
    if mnth == 13 
        mnth = 1;
        yr = yr + 1;
    end
end
    
    
    
    
    
    
    
    
    