function [] = cell2netcdf(inpt, theta, lambda)
% The function converts a cell array in Matlab into a netcdf file.
% Currently it supports daily and monthly datasets, depending on the number
% of columns of inpt:
% - 3 columns: monthly data 
% - 4 columns: daily data
% Latitude and Longitude must be provided as well. If these are not known,
% the output file does not match the netcdf-conventions. For such data, use
% the function mat2netcdf.
%--------------------------------------------------------------------------
% Input (mandatory):
% - inpt  {m x 3}      Cell array which contains monthly input fields. 
%                      The first two columns must contain month and year,
%                      the third column must contain the (i x j) data field
%         {m x 4}      Cell array which contains daily input fields. 
%                      The first three columns must contain day, month, and
%                      year, the fourth column must contain the data field 
% - theta    i         Vector containing the latitudes of the fields
% - lambda   j         Vector containing the longitudes of the fields
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   January 2013
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------
fprintf('\n')
fprintf('---------------------------------------------------- \n')
fprintf('Conversion from a MATLAB-cell-array to a netcdf-file \n')
fprintf('---------------------------------------------------- \n')
fprintf(' \n')
outnme  = input('Enter output filename: ', 's');
varnme  = input('Enter variable name for netcdf-file: ', 's');
units   = input('Enter units of variable: ', 's');
longnme = input('Enter variable description: ', 's');
mval    = input('Enter identifier for missing values: ', 's');
fprintf('---------------------------------------------------- \n')
fprintf('Computing.... ')

% Get the size of the input cell array
% n -> number of timesteps
% p -> number of input columns 
[n,p] = size(inpt);

% Set all the missing elements to -99999
if ~isnan(mval)
    for i = 1:n
        inpt{i,p}(inpt{i,p} == str2num(mval)) = -99999;
    end
end

% Compute the integer-time for the time-steps of the input dataset.
% Afterwards, Jan 15 2010 would look like 20100115.
if p == 4    % Daily dataset
    dys   = cell2mat(inpt(:,1));
    mnths = cell2mat(inpt(:,2));
    yrs   = cell2mat(inpt(:,3));
    inttme = yrs*10000 + mnths*100 + dys;
    
    for i = 1:n
        bigmat(:,:,i) = inpt{i,4}';
    end


    
elseif p == 3 % Monthly dataset
    mnths = cell2mat(inpt(:,1));
    yrs   = cell2mat(inpt(:,2));
    inttme = yrs*10000 + mnths*100 + ones(n,1)*15;
    
    for i = 1:n
        bigmat(:,:,i) = inpt{i,3}';
    end
    
       
end

% Rearrange the cell-array in a big 3D-matrix

% Create a netcdf-file and set the correct dimensions and dimension
% variables
ncid   = netcdf.create(outnme, 'CLOBBER');

time_dim_id = netcdf.defDim(ncid, 'time', length(inttme));
lon_dim_id  = netcdf.defDim(ncid, 'longitude', length(lambda));
lat_dim_id  = netcdf.defDim(ncid, 'latitude', length(theta));

time_var_id = netcdf.defVar(ncid, 'time', 'double', time_dim_id);
lon_var_id  = netcdf.defVar(ncid, 'longitude', 'double', lon_dim_id);
lat_var_id  = netcdf.defVar(ncid, 'latitude', 'double', lat_dim_id);

% Create the data variable with the correct dimensions
data_var_id = netcdf.defVar(ncid, varnme, 'double', [lon_dim_id ...
                                                     lat_dim_id ...
                                                     time_dim_id]);


% Set the attributes of the variables
netcdf.putAtt(ncid, time_var_id, '_CoordinateAxisType', 'Time');

netcdf.putAtt(ncid, lon_var_id, 'units', 'degrees_east');
netcdf.putAtt(ncid, lon_var_id, 'long_name', 'longitude');
netcdf.putAtt(ncid, lon_var_id, '_CoordinateAxisType', 'Lon');
    
netcdf.putAtt(ncid, lat_var_id, 'units', 'degrees_north');
netcdf.putAtt(ncid, lat_var_id, 'long_name', 'latitude');
netcdf.putAtt(ncid, lat_var_id, '_CoordinateAxisType', 'Lat');

netcdf.putAtt(ncid, data_var_id, 'units', units);
netcdf.putAtt(ncid, data_var_id, 'long_name', longnme);
netcdf.putAtt(ncid, data_var_id, 'missing_value', -99999);

netcdf.endDef(ncid);

% Write the variables to the netcdf-file
netcdf.putVar(ncid, time_var_id,  inttme);
netcdf.putVar(ncid, lon_var_id, lambda);
netcdf.putVar(ncid, lat_var_id, theta);
netcdf.putVar(ncid, data_var_id, bigmat);

netcdf.close(ncid);

fprintf('Done \n')