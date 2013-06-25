function [] = ts2netcdf(inpt, areanms)
% The function reads data from a cell-array and stores its elements in a
% netcdf-file. Some 
fprintf('\n')
fprintf('---------------------------------------------------- \n')
fprintf('Conversion from a MATLAB-cell-array to a netcdf-file \n')
fprintf('---------------------------------------------------- \n')
fprintf(' \n')
outnme  = input('Enter output filename: ', 's');
units   = input('Enter units of variable: ', 's');
longnme = input('Enter variable description: ', 's');
mval    = input('Enter identifier for missing values: ', 's');
fprintf('---------------------------------------------------- \n')
fprintf('Computing.... ')

mnths  = inpt(2:end, 1);
yrs    = inpt(2:end, 2);
inttme = yrs*10000 + mnths*100 + ones(length(mnths),1)*15;



ncid   = netcdf.create(outnme, 'CLOBBER');
time_dim_id = netcdf.defDim(ncid, 'time', length(inttme));
time_var_id = netcdf.defVar(ncid, 'time', 'double', time_dim_id);
netcdf.putAtt(ncid, time_var_id, '_CoordinateAxisType', 'Time');


lon_dim_id  = netcdf.defDim(ncid, 'longitude', 1);
lat_dim_id  = netcdf.defDim(ncid, 'latitude', 1);
lon_var_id  = netcdf.defVar(ncid, 'longitude', 'double', lon_dim_id);
lat_var_id  = netcdf.defVar(ncid, 'latitude', 'double', lat_dim_id);


for i = 1:length(areanms)
    data_var_id(i) = netcdf.defVar(ncid, areanms{i}, 'double', [time_dim_id]);
    netcdf.putAtt(ncid, data_var_id(i), 'units', units);
    netcdf.putAtt(ncid, data_var_id(i), 'long_name', longnme);
    netcdf.putAtt(ncid, data_var_id(i), 'missing_value', -99999);
end

netcdf.endDef(ncid);
netcdf.putVar(ncid, time_var_id,  inttme);
netcdf.putVar(ncid, lon_var_id, 0);
netcdf.putVar(ncid, lat_var_id, 0);

for i = 1:length(areanms)
    netcdf.putVar(ncid, data_var_id(i), inpt(2:end, i+3));
end

netcdf.close(ncid);

fprintf('Done \n')
