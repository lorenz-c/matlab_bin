function [] = mat2netcdf(mtrx, fname, varnme, theta, lambda, mval, unit)

ncid        = netcdf.create(fname, 'CLOBBER');
lon_dim_id  = netcdf.defDim(ncid, 'longitude', length(lambda));
lat_dim_id  = netcdf.defDim(ncid, 'latitude' , length(theta));

lon_var_id  = netcdf.defVar(ncid, 'longitude', 'double', lon_dim_id);
lat_var_id  = netcdf.defVar(ncid, 'latitude', 'double', lat_dim_id);
data_var_id = netcdf.defVar(ncid, varnme, 'double', [lon_dim_id lat_dim_id]);

netcdf.endDef(ncid)  
netcdf.putVar(ncid, lon_var_id, lambda);
netcdf.putVar(ncid, lat_var_id, theta);
netcdf.putVar(ncid, data_var_id, mtrx');

netcdf.reDef(ncid)
netcdf.putAtt(ncid, lon_var_id, 'units', 'degrees_east');
netcdf.putAtt(ncid, lon_var_id, 'long_name', 'longitude coordinate');
netcdf.putAtt(ncid, lon_var_id, '_CoordinateAxisType', 'Lon');
    
netcdf.putAtt(ncid, lat_var_id, 'units', 'degrees_north');
netcdf.putAtt(ncid, lat_var_id, 'long_name', 'latitude coordinate');
netcdf.putAtt(ncid, lat_var_id, '_CoordinateAxisType', 'Lat');

netcdf.putAtt(ncid, data_var_id, '_CoordinateAxes', 'Lon Lat');







% 
% netcdf.reDef(ncid)
 

    
    
    