function [] = read_gleam(fnames)

for i = 1:length(fnames)
    dta = importdata(fnames{i});
    
    yr  = fnames{i}(15:18);
    mn  = fnames{i}(19:20);
    dy  = fnames{i}(21:22);
    
    intdte = str2num(yr)*10000 + str2num(mn)*100 + str2num(dy);
    
    lat = 89.875:-0.25:-89.875;
    lon = -179.875:0.25:179.875;

    dta(dta == -99) = -9999;
    
    outnme = [fnames{i}(1:end-3), 'nc'];

    
    ncid   = netcdf.create(outnme, 'NC_WRITE'); 
    
    time_dim_id = netcdf.defDim(ncid, 'time', 1);
    lon_dim_id  = netcdf.defDim(ncid, 'lon', length(lon));
    lat_dim_id  = netcdf.defDim(ncid, 'lat', length(lat));
    
    time_var_id = netcdf.defVar(ncid, 'time', 'double', time_dim_id);
    lon_var_id  = netcdf.defVar(ncid, 'lon', 'double', lon_dim_id);
    lat_var_id  = netcdf.defVar(ncid, 'lat', 'double', lat_dim_id);
    
    data_var_id = netcdf.defVar(ncid, 'EVAP', 'double', ...
                                    [lon_dim_id lat_dim_id time_dim_id]);
    netcdf.endDef(ncid);
    
    netcdf.putVar(ncid, time_var_id,  intdte);
    netcdf.putVar(ncid, lon_var_id, lon);
    netcdf.putVar(ncid, lat_var_id, lat);
    netcdf.putVar(ncid, data_var_id, dta');
    
    netcdf.reDef(ncid)
    netcdf.putAtt(ncid, time_var_id, 'units', 'days in YYYYMMDD');
    netcdf.putAtt(ncid, time_var_id, '_CoordinateAxisType', 'Time');
    
    netcdf.putAtt(ncid, lon_var_id, 'units', 'degrees_east');
    netcdf.putAtt(ncid, lon_var_id, 'long_name', 'Longitude');
    netcdf.putAtt(ncid, lon_var_id, '_CoordinateAxisType', 'Lon');
    
    netcdf.putAtt(ncid, lat_var_id, 'units', 'degrees_north');
    netcdf.putAtt(ncid, lat_var_id, 'long_name', 'Latitude');
    netcdf.putAtt(ncid, lat_var_id, '_CoordinateAxisType', 'Lat');
    
    netcdf.putAtt(ncid, data_var_id, 'units', 'mm/day');
    netcdf.putAtt(ncid, data_var_id, 'long_name', 'Evapotranspiration');
    netcdf.putAtt(ncid, data_var_id, 'missing_value', -9999);
    
    netcdf.close(ncid);
end
     
    