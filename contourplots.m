% First we do the CFSR-Stuff
mnth = 1;
yr   = 1989;

file1 = '/media/storage/Data/Mflux/CFSR/original/CFSR.VQ.1979-2009.nc';
file2 = '/media/storage/Data/Mflux/CFSR/original/CFSR.UQ.1979-2009.nc';

for i = 121:372
    cfsr_flx{i-120,3} = nj_varget(file1, 'VQ', [i 1 1], [1 inf inf]);
    cfsr_flx{i-120,4} = nj_varget(file2, 'UQ', [i 1 1], [1 inf inf]);
    cfsr_flx{i-120,1} = mnth;
    cfsr_flx{i-120,2} = yr;
    
    mnth = mnth + 1;
    
    if mnth == 13
        mnth = 1;
        yr   = yr + 1;
    end
end

lon       = nj_varget(file1, 'lon');
lon_units = nj_attget(file1, 'lon', 'units');
lon_name  = nj_attget(file1, 'lon', 'long_name');
lon_axis  = nj_attget(file1, 'lon', '_CoordinateAxisType');

lat       = nj_varget(file1, 'lat');
lat_units = nj_attget(file1, 'lat', 'units');
lat_name  = nj_attget(file1, 'lat', 'long_name');
lat_axis  = nj_attget(file1, 'lat', '_CoordinateAxisType');


% Now we compute the seasonal mean of the CFSR-fluxes
cfsr_v = comp_spat_mean(cfsr_flx, [1989, 2006], 'seasonal_1', [1 2 3], -9999);
cfsr_u = comp_spat_mean(cfsr_flx, [1989, 2006], 'seasonal_1', [1 2 4], -9999);
cfsr_v_ann = comp_spat_mean(cfsr_flx, [1989, 2006], 'annual_1', [1 2 3], -9999);
cfsr_u_ann = comp_spat_mean(cfsr_flx, [1989, 2006], 'annual_1', [1 2 4], -9999);

% Finally we compute the contour levels (i.e. the gradient)
for i = 1:4
    cfsr_c{i} = abs(cfsr_v{i} + cfsr_u{i});
end

savename{1} = 'cfsr_uq_jfm.nc';
savename{2} = 'cfsr_vq_jfm.nc';
savename{3} = 'cfsr_uq_jas.nc';
savename{4} = 'cfsr_vq_jas.nc';
savename{5} = 'cfsr_c_jfm.nc';
savename{6} = 'cfsr_c_jas.nc';
savename{7} = 'cfsr_uq_ann.nc';
savename{8} = 'cfsr_vq_ann.nc';


data{1} = cfsr_u{1};
data{2} = cfsr_v{1};
data{3} = cfsr_u{3};
data{4} = cfsr_v{3};
data{5} = cfsr_c{1};
data{6} = cfsr_c{3};
data{7} = cfsr_u_ann;
data{8} = cfsr_v_ann;

varname{1} = 'UQ_JFM';
varname{2} = 'VQ_JFM';
varname{3} = 'UQ_JAS';
varname{4} = 'VQ_JAS';
varname{5} = 'C_JFM';
varname{6} = 'C_JAS';
varname{7} = 'UQ_ANN';
varname{8} = 'VQ_ANN';

for i = 1:8
    ncid = netcdf.create(savename{i}, 'NC_WRITE');
    lon_dim_id  = netcdf.defDim(ncid, 'longitude', length(lon));
    lat_dim_id  = netcdf.defDim(ncid, 'latitude', length(lat));
    
    lon_var_id  = netcdf.defVar(ncid, 'longitude', 'double', lon_dim_id);
    lat_var_id  = netcdf.defVar(ncid, 'latitude', 'double', lat_dim_id);
    
    data_var_id = netcdf.defVar(ncid, varname{i}, 'double', [lon_dim_id lat_dim_id]);
    netcdf.endDef(ncid);

    netcdf.putVar(ncid, lon_var_id, lon);
    netcdf.putVar(ncid, lat_var_id, lat);
    netcdf.putVar(ncid, data_var_id, data{i}');
    
    netcdf.reDef(ncid)
    
    netcdf.putAtt(ncid, lon_var_id, 'units', lon_units);
    netcdf.putAtt(ncid, lon_var_id, 'long_name', lon_name);
    netcdf.putAtt(ncid, lon_var_id, '_CoordinateAxisType', lon_axis);
    
    
    netcdf.putAtt(ncid, lat_var_id, 'units', lat_units);
    netcdf.putAtt(ncid, lat_var_id, 'long_name', lat_name);
    netcdf.putAtt(ncid, lat_var_id, '_CoordinateAxisType', lat_axis);
    netcdf.close(ncid);
end


% Alright... Let's go for MERRA
clear all
clc


mnth = 1;
yr   = 1989;

for i = 121:372
   if yr < 1993
       stream = num2str(100);
   elseif yr >= 1993 & yr < 2001
       stream = num2str(200);
   elseif yr >= 2001
       stream = num2str(300);
   end
   
   if mnth < 10
       txtmnth = ['0', num2str(mnth)];
   else
       txtmnth = num2str(mnth);
   end
   
   fname = ['/media/storage/Data/Mflux/MERRA/original/MERRA', stream, ...
       '.prod.assim.tavgM_2d_int_Nx.', num2str(yr), txtmnth, '.SUB.nc'];
   
   merra_flx{i-120,3} = nj_varget(fname, 'vflxqv');
   merra_flx{i-120,4} = nj_varget(fname, 'uflxqv');
   
   merra_flx{i-120,1} = mnth;
   merra_flx{i-120,2} = yr;

   mnth = mnth + 1;
   if mnth == 13
       mnth = 1;
       yr = yr + 1;
   end
   
end
   

lon       = nj_varget(fname, 'longitude');
lon_units = nj_attget(fname, 'longitude', 'units');
lon_name  = nj_attget(fname, 'longitude', 'long_name');
lon_axis  = nj_attget(fname, 'longitude', '_CoordinateAxisType');

lat       = nj_varget(fname, 'latitude');
lat_units = nj_attget(fname, 'latitude', 'units');
lat_name  = nj_attget(fname, 'latitude', 'long_name');
lat_axis  = nj_attget(fname, 'latitude', '_CoordinateAxisType');


merra_v = comp_spat_mean(merra_flx, [1989, 2006], 'seasonal_1', [1 2 3], -9999);
merra_u = comp_spat_mean(merra_flx, [1989, 2006], 'seasonal_1', [1 2 4], -9999);


merra_v_ann = comp_spat_mean(merra_flx, [1989, 2006], 'annual_1', [1 2 3], -9999);
merra_u_ann = comp_spat_mean(merra_flx, [1989, 2006], 'annual_1', [1 2 4], -9999);

% Finally we compute the contour levels (i.e. the gradient)
for i = 1:4
    merra_c{i} = abs(merra_v{i} + merra_u{i});
end



savename{1} = 'merra_uq_jfm.nc';
savename{2} = 'merra_vq_jfm.nc';
savename{3} = 'merra_uq_jas.nc';
savename{4} = 'merra_vq_jas.nc';
savename{5} = 'merra_c_jfm.nc';
savename{6} = 'merra_c_jas.nc';
savename{7} = 'merra_uq_ann.nc';
savename{8} = 'merra_vq_ann.nc';

data{1} = merra_u{1};
data{2} = merra_v{1};
data{3} = merra_u{3};
data{4} = merra_v{3};
data{5} = merra_c{1};
data{6} = merra_c{3};
data{7} = merra_u_ann;
data{8} = merra_v_ann;

varname{1} = 'UQ_JFM';
varname{2} = 'VQ_JFM';
varname{3} = 'UQ_JAS';
varname{4} = 'VQ_JAS';
varname{5} = 'C_JFM';
varname{6} = 'C_JAS';
varname{7} = 'UQ_ANN';
varname{8} = 'VQ_ANN';


for i = 1:8
    ncid = netcdf.create(savename{i}, 'NC_WRITE');
    lon_dim_id  = netcdf.defDim(ncid, 'longitude', length(lon));
    lat_dim_id  = netcdf.defDim(ncid, 'latitude', length(lat));
    
    lon_var_id  = netcdf.defVar(ncid, 'longitude', 'double', lon_dim_id);
    lat_var_id  = netcdf.defVar(ncid, 'latitude', 'double', lat_dim_id);
    
    data_var_id = netcdf.defVar(ncid, varname{i}, 'double', [lon_dim_id lat_dim_id]);
    netcdf.endDef(ncid);

    netcdf.putVar(ncid, lon_var_id, lon);
    netcdf.putVar(ncid, lat_var_id, lat);
    netcdf.putVar(ncid, data_var_id, data{i}');
    
    netcdf.reDef(ncid)
    
    netcdf.putAtt(ncid, lon_var_id, 'units', lon_units);
    netcdf.putAtt(ncid, lon_var_id, 'long_name', lon_name);
    netcdf.putAtt(ncid, lon_var_id, '_CoordinateAxisType', lon_axis);
    
    
    netcdf.putAtt(ncid, lat_var_id, 'units', lat_units);
    netcdf.putAtt(ncid, lat_var_id, 'long_name', lat_name);
    netcdf.putAtt(ncid, lat_var_id, '_CoordinateAxisType', lat_axis);
    netcdf.close(ncid);
end

clear all

% 
% AND FINALLY... DA ECMWF SHIT
clear all

mnth = 1;
yr   = 1989;

fnme = '/media/storage/Data/Mflux/ECMWF/original/output.grib';

for i = 1:263
    ecmwf_flx{i,3} = nj_varget(fnme, 'Vertical_integral_of_northward_water_vapour_flux', [i 1 1], [1 inf inf]);
    ecmwf_flx{i,4} = nj_varget(fnme, 'Vertical_integral_of_eastward_water_vapour_flux', [i 1 1], [1 inf inf]);

    ecmwf_flx{i,1} = mnth;
    ecmwf_flx{i,2} = yr;
    
    mnth = mnth + 1;
    
    if mnth == 13
        mnth = 1;
        yr   = yr + 1;
    end
varname{7} = 'UQ_ANN';
varname{8} = 'VQ_ANN';

end

lon       = nj_varget(fnme, 'lon');
lon_units = nj_attget(fnme, 'lon', 'units');
lon_name  = nj_attget(fnme, 'lon', 'long_name');
lon_axis  = nj_attget(fnme, 'lon', '_CoordinateAxisType');

lat       = nj_varget(fnme, 'lat');
lat_units = nj_attget(fnme, 'lat', 'units');
lat_name  = nj_attget(fnme, 'lat', 'long_name');
lat_axis  = nj_attget(fnme, 'lat', '_CoordinateAxisType');


% Now we compute the seasonal mean of the CFSR-fluxes
ecmwf_v = comp_spat_mean(ecmwf_flx, [1989, 2006], 'seasonal_1', [1 2 3], -9999);
ecmwf_u = comp_spat_mean(ecmwf_flx, [1989, 2006], 'seasonal_1', [1 2 4], -9999);

ecmwf_v_ann = comp_spat_mean(ecmwf_flx, [1989, 2006], 'annual_1', [1 2 3], -9999);
ecmwf_u_ann = comp_spat_mean(ecmwf_flx, [1989, 2006], 'annual_1', [1 2 4], -9999);
% Finally we compute the contour levels (i.e. the gradient)
for i = 1:4
    ecmwf_c{i} = abs(ecmwf_v{i} + ecmwf_u{i});
end

savename{1} = 'ecmwf_uq_jfm.nc';
savename{2} = 'ecmwf_vq_jfm.nc';
savename{3} = 'ecmwf_uq_jas.nc';
savename{4} = 'ecmwf_vq_jas.nc';
savename{5} = 'ecmwf_c_jfm.nc';
savename{6} = 'ecmwf_c_jas.nc';
savename{7} = 'ecmwf_uq_ann.nc';
savename{8} = 'ecmwf_vq_ann.nc';

data{1} = ecmwf_u{1};
data{2} = ecmwf_v{1};
data{3} = ecmwf_u{3};
data{4} = ecmwf_v{3};
data{5} = ecmwf_c{1};
data{6} = ecmwf_c{3};
data{7} = ecmwf_u_ann;
data{8} = ecmwf_v_ann;

varname{1} = 'UQ_JFM';
varname{2} = 'VQ_JFM';
varname{3} = 'UQ_JAS';
varname{4} = 'VQ_JAS';
varname{5} = 'C_JFM';
varname{6} = 'C_JAS';
varname{7} = 'UQ_ANN';
varname{8} = 'VQ_ANN';


for i = 1:8
    ncid = netcdf.create(savename{i}, 'NC_WRITE');
    lon_dim_id  = netcdf.defDim(ncid, 'longitude', length(lon));
    lat_dim_id  = netcdf.defDim(ncid, 'latitude', length(lat));
    
    lon_var_id  = netcdf.defVar(ncid, 'longitude', 'double', lon_dim_id);
    lat_var_id  = netcdf.defVar(ncid, 'latitude', 'double', lat_dim_id);
    
    data_var_id = netcdf.defVar(ncid, varname{i}, 'double', [lon_dim_id lat_dim_id]);
    netcdf.endDef(ncid);

    netcdf.putVar(ncid, lon_var_id, lon);
    netcdf.putVar(ncid, lat_var_id, lat);
    netcdf.putVar(ncid, data_var_id, data{i}');
    
    netcdf.reDef(ncid)
    
    netcdf.putAtt(ncid, lon_var_id, 'units', lon_units);
    netcdf.putAtt(ncid, lon_var_id, 'long_name', lon_name);
    netcdf.putAtt(ncid, lon_var_id, '_CoordinateAxisType', lon_axis);
    
    
    netcdf.putAtt(ncid, lat_var_id, 'units', lat_units);
    netcdf.putAtt(ncid, lat_var_id, 'long_name', lat_name);
    netcdf.putAtt(ncid, lat_var_id, '_CoordinateAxisType', lat_axis);
    netcdf.close(ncid);
end
clear all

load /media/storage/Data/Mflux/CFSR/CFSR_VIMFD.mat
cf = comp_spat_mean(cfsr_vimfd, [1989 2006], 'annual_1', [4 5 9], -9999);
A = grid2gmt(-cf, 0.5);
save cfsr_vimfc_ann.txt A -ascii

load /media/storage/Data/Mflux/ECMWF/ECMWF_VIMFD.mat
cf = comp_spat_mean(ecmwf_vimfd, [1989 2006], 'annual_1', [4 5 9], -9999);
A = grid2gmt(-cf, 0.5);
save ecmwf_vimfc_ann.txt A -ascii

load /media/storage/Data/Mflux/MERRA/MERRA_VIMFD.mat
cf = comp_spat_mean(merra_vimfd, [1989 2006], 'annual_1', [4 5 9], -9999);
A = grid2gmt(-cf, 0.5);
save merra_vimfc_ann.txt A -ascii



% Alright... Let's go for MERRA