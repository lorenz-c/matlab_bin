function file_vars = read_netcdf(fname)

ncid = netcdf.open(fname, 'nowrite')

% Read the number of variables and global attributes
[ndims,nvars,ngatts,unlimdimid] = netcdf.inq(ncid);


% Read the name, etc. of the different variables
for i = 0:nvars-1
    [file_vars{i+1,1}, xtype, dimids, numatts] = netcdf.inqVar(ncid,i);
    file_vars{i+1,2} = netcdf.getVar(ncid,i);
    
    for j = 0:numatts-1
        file_vars{i+1,3}{j+1,1} = netcdf.inqAttName(ncid,i,j);
        file_vars{i+1,3}{j+1,2} = netcdf.getAtt(ncid,i, ...
                                                  file_vars{i+1,3}{j+1,1});                                 
    end
end
        