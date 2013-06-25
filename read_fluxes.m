function UVflx = read_fluxes(dataset)




if strcmp(dataset, 'ecmwf')
    fname = '/media/storage/Data/Mflux/ECMWF/original/output.grib';
    varnme{1} = 'Vertical_integral_of_eastward_water_vapour_flux';
    varnme{2} = 'Vertical_integral_of_northward_water_vapour_flux';
    
    mnth = 1;
    yr   = 1989;
    
    for i = 1:263
        UVflx{i,1} = mnth;
        UVflx{i,2} = yr;
        UVflx{i,3} = nj_varget(fname, varnme{1}, [i 1 1], [1 inf inf]);
        UVflx{i,4} = nj_varget(fname, varnme{2}, [i 1 1], [1 inf inf]);
        
        mnth = mnth + 1;
        
        if mnth == 13
            mnth = 1;
            yr = yr + 1;
        end
    end
    
    lon       = nj_varget(fname, 'lon');
    lon_units = nj_attget(fname, 'lon', 'units');
    lon_axis  = nj_attget(fname, 'lon', '_CoordinateAxisType');

    lat       = nj_varget(fname, 'lat');
    lat_units = nj_attget(fname, 'lat', 'units');
    lat_axis  = nj_attget(fname, 'lat', '_CoordinateAxisType');
      
    otnme_u{1} = 'ecmwf_uflx_jan.nc';
    otnme_u{2} = 'ecmwf_uflx_jul.nc';
    otnme_v{1} = 'ecmwf_vflx_jan.nc';
    otnme_v{2} = 'ecmwf_vflx_jul.nc';
elseif strcmp(dataset, 'merra')
    
    mnth = 1;
    yr   = 1979;
    
    path = '/media/storage/Data/Mflux/MERRA/original/';
    varnme{1} = 'uflxqv';
    varnme{2} = 'vflxqv';
    
    for i = 1:372
        if mnth < 10
            txtmnth = ['0', num2str(mnth)];
        else
            txtmnth = num2str(mnth);
        end
        
        if yr < 1993
            
            fnme = [path, 'MERRA100.prod.assim.tavgM_2d_int_Nx.', ...
                        num2str(yr), txtmnth, '.SUB.nc'];
        elseif yr >= 1993 && yr < 2001
            fnme = [path, 'MERRA200.prod.assim.tavgM_2d_int_Nx.', ...
                        num2str(yr), txtmnth, '.SUB.nc'];
        elseif yr >= 2001
            fnme = [path, 'MERRA300.prod.assim.tavgM_2d_int_Nx.', ...
                        num2str(yr), txtmnth, '.SUB.nc'];
        end
        
        UVflx{i,1} = mnth;
        UVflx{i,2} = yr;
        UVflx{i,3} = nj_varget(fnme, varnme{1}, [1 1 1], [1 inf inf]);
        UVflx{i,4} = nj_varget(fnme, varnme{2}, [1 1 1], [1 inf inf]);
        
        mnth = mnth + 1;
        
        if mnth == 13
            mnth = 1;
            yr = yr + 1;
        end
        
        
    end
    
    lon       = nj_varget(fnme, 'longitude');
    lon_units = nj_attget(fnme, 'longitude', 'units');
    lon_axis  = nj_attget(fnme, 'longitude', '_CoordinateAxisType');

    lat       = nj_varget(fnme, 'latitude');
    lat_units = nj_attget(fnme, 'latitude', 'units');
    lat_axis  = nj_attget(fnme, 'latitude', '_CoordinateAxisType');

    otnme_u{1} = 'merra_uflx_jan.nc';
    otnme_u{2} = 'merra_uflx_jul.nc';
    otnme_v{1} = 'merra_vflx_jan.nc';
    otnme_v{2} = 'merra_vflx_jul.nc';
    
elseif strcmp(dataset, 'cfsr')
    
    mnth = 1;
    yr   = 1979;
    
    fname{1} = '/media/storage/Data/Mflux/CFSR/original/CFSR.UQ.1979-2009.nc';
    fname{2} = '/media/storage/Data/Mflux/CFSR/original/CFSR.VQ.1979-2009.nc';
    
    varnme{1} = 'UQ';
    varnme{2} = 'VQ';
    
    for i = 1:372
        UVflx{i,1} = mnth;
        UVflx{i,2} = yr;
        UVflx{i,3} = nj_varget(fname{1}, varnme{1}, [i 1 1], [1 inf inf]);
        UVflx{i,4} = nj_varget(fname{2}, varnme{2}, [i 1 1], [1 inf inf]);
        
        mnth = mnth + 1;
        
        if mnth == 13
            mnth = 1;
            yr = yr + 1;
        end
    end
    
    lon       = nj_varget(fname{1}, 'lon');
    lon_units = nj_attget(fname{1}, 'lon', 'units');
    lon_axis  = nj_attget(fname{1}, 'lon', '_CoordinateAxisType');

    lat       = nj_varget(fname{1}, 'lat');
    lat_units = nj_attget(fname{1}, 'lat', 'units');
    lat_axis  = nj_attget(fname{1}, 'lat', '_CoordinateAxisType');
    
    otnme_u{1} = 'cfsr_uflx_jan.nc';
    otnme_u{2} = 'cfsr_uflx_jul.nc';
    otnme_v{1} = 'cfsr_vflx_jan.nc';
    otnme_v{2} = 'cfsr_vflx_jul.nc';
end

mn_u = comp_spat_mean(UVflx, [1989 2006], 'monthly_1', [1 2 3], -9999, 1);
mn_v = comp_spat_mean(UVflx, [1989 2006], 'monthly_1', [1 2 4], -9999, 1);


% Writing the U-field of January
ncid   = netcdf.create(otnme_u{1}, 'NC_WRITE');
lon_dim_id  = netcdf.defDim(ncid, 'longitude', length(lon));
lat_dim_id  = netcdf.defDim(ncid, 'latitude', length(lat));

lon_var_id  = netcdf.defVar(ncid, 'longitude', 'double', lon_dim_id);
lat_var_id  = netcdf.defVar(ncid, 'latitude', 'double', lat_dim_id);
    
data_var_id = netcdf.defVar(ncid, 'uflx', 'double', [lon_dim_id lat_dim_id]);
netcdf.endDef(ncid);

netcdf.putVar(ncid, lon_var_id, lon);
netcdf.putVar(ncid, lat_var_id, lat);
netcdf.putVar(ncid, data_var_id, mn_u{1}');

netcdf.reDef(ncid)
netcdf.putAtt(ncid, lon_var_id, 'units', lon_units);
netcdf.putAtt(ncid, lon_var_id, '_CoordinateAxisType', lon_axis);
netcdf.putAtt(ncid, lat_var_id, 'units', lat_units);
netcdf.putAtt(ncid, lat_var_id, '_CoordinateAxisType', lat_axis);
netcdf.close(ncid);    

% Writing the U-field of July
ncid   = netcdf.create(otnme_u{2}, 'NC_WRITE');
lon_dim_id  = netcdf.defDim(ncid, 'longitude', length(lon));
lat_dim_id  = netcdf.defDim(ncid, 'latitude', length(lat));

lon_var_id  = netcdf.defVar(ncid, 'longitude', 'double', lon_dim_id);
lat_var_id  = netcdf.defVar(ncid, 'latitude', 'double', lat_dim_id);
    
data_var_id = netcdf.defVar(ncid, 'uflx', 'double', [lon_dim_id lat_dim_id]);
netcdf.endDef(ncid);

netcdf.putVar(ncid, lon_var_id, lon);
netcdf.putVar(ncid, lat_var_id, lat);
netcdf.putVar(ncid, data_var_id, mn_u{7}');

netcdf.reDef(ncid)
netcdf.putAtt(ncid, lon_var_id, 'units', lon_units);
netcdf.putAtt(ncid, lon_var_id, '_CoordinateAxisType', lon_axis);
netcdf.putAtt(ncid, lat_var_id, 'units', lat_units);
netcdf.putAtt(ncid, lat_var_id, '_CoordinateAxisType', lat_axis);
netcdf.close(ncid);    


% Writing the V-field of January
ncid   = netcdf.create(otnme_v{1}, 'NC_WRITE');
lon_dim_id  = netcdf.defDim(ncid, 'longitude', length(lon));
lat_dim_id  = netcdf.defDim(ncid, 'latitude', length(lat));

lon_var_id  = netcdf.defVar(ncid, 'longitude', 'double', lon_dim_id);
lat_var_id  = netcdf.defVar(ncid, 'latitude', 'double', lat_dim_id);
    
data_var_id = netcdf.defVar(ncid, 'vflx', 'double', [lon_dim_id lat_dim_id]);
netcdf.endDef(ncid);

netcdf.putVar(ncid, lon_var_id, lon);
netcdf.putVar(ncid, lat_var_id, lat);
netcdf.putVar(ncid, data_var_id, mn_v{1}');

netcdf.reDef(ncid)
netcdf.putAtt(ncid, lon_var_id, 'units', lon_units);
netcdf.putAtt(ncid, lon_var_id, '_CoordinateAxisType', lon_axis);
netcdf.putAtt(ncid, lat_var_id, 'units', lat_units);
netcdf.putAtt(ncid, lat_var_id, '_CoordinateAxisType', lat_axis);
netcdf.close(ncid);   



% Writing the V-field of July
ncid   = netcdf.create(otnme_v{2}, 'NC_WRITE');
lon_dim_id  = netcdf.defDim(ncid, 'longitude', length(lon));
lat_dim_id  = netcdf.defDim(ncid, 'latitude', length(lat));

lon_var_id  = netcdf.defVar(ncid, 'longitude', 'double', lon_dim_id);
lat_var_id  = netcdf.defVar(ncid, 'latitude', 'double', lat_dim_id);
    
data_var_id = netcdf.defVar(ncid, 'vflx', 'double', [lon_dim_id lat_dim_id]);
netcdf.endDef(ncid);

netcdf.putVar(ncid, lon_var_id, lon);
netcdf.putVar(ncid, lat_var_id, lat);
netcdf.putVar(ncid, data_var_id, mn_v{7}');

netcdf.reDef(ncid)
netcdf.putAtt(ncid, lon_var_id, 'units', lon_units);
netcdf.putAtt(ncid, lon_var_id, '_CoordinateAxisType', lon_axis);
netcdf.putAtt(ncid, lat_var_id, 'units', lat_units);
netcdf.putAtt(ncid, lat_var_id, '_CoordinateAxisType', lat_axis);
netcdf.close(ncid);   
    
                    
                    
             
    
        
        