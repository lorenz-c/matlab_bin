function [] = mat2netcdf(inpt, varname, lat, lon, clms, outnme, mval)



time = [cell2mat(inpt(:,clms(1))) cell2mat(inpt(:,clms(2)))];





for i = 1:size(time,1)
    
    if time(i,1) < 10
        outnme_f = [outnme, num2str(time(i,2)), '0', num2str(time(i,1)), '.nc'];
    else
        outnme_f = [outnme, num2str(time(i,2)), num2str(time(i,1)), '.nc'];
    end
    
    ncid   = netcdf.create(outnme_f, 'NOCLOBBER'); 
    time_dim_id = netcdf.defDim(ncid, 'time', 1);
    lon_dim_id  = netcdf.defDim(ncid, 'lon', length(lon));
    lat_dim_id  = netcdf.defDim(ncid, 'lat', length(lat));
    
    time_var_id = netcdf.defVar(ncid, 'time', 'double', time_dim_id);
    lon_var_id  = netcdf.defVar(ncid, 'lon', 'double', lon_dim_id);
    lat_var_id  = netcdf.defVar(ncid, 'lat', 'double', lat_dim_id);
    
    data_var_id = netcdf.defVar(ncid, varname{1}, 'double', ...
                                    [lon_dim_id lat_dim_id time_dim_id]);
    netcdf.endDef(ncid);
    
    netcdf.putVar(ncid, time_var_id,  0);
    netcdf.putVar(ncid, lon_var_id, lon);
    netcdf.putVar(ncid, lat_var_id, lat);
    netcdf.putVar(ncid, data_var_id, inpt{i,clms(3)}');
    
    netcdf.reDef(ncid)
    netcdf.putAtt(ncid, time_var_id, 'units', 'hours since 1');
    netcdf.putAtt(ncid, time_var_id, '_CoordinateAxisType', 'Time');
    
    netcdf.putAtt(ncid, lon_var_id, 'units', 'degrees_east');
    netcdf.putAtt(ncid, lon_var_id, 'long_name', 'Longitude');
    netcdf.putAtt(ncid, lon_var_id, '_CoordinateAxisType', 'Lon');
    
    netcdf.putAtt(ncid, lat_var_id, 'units', 'degrees_north');
    netcdf.putAtt(ncid, lat_var_id, 'long_name', 'Latitude');
    netcdf.putAtt(ncid, lat_var_id, '_CoordinateAxisType', 'Lat');
    
    netcdf.putAtt(ncid, data_var_id, 'units', inpt{1,clms(4)});
    netcdf.putAtt(ncid, data_var_id, 'long_name', varname{2});
    netcdf.putAtt(ncid, data_var_id, 'missing_value', mval);
    
    netcdf.close(ncid);
end
    
    
    