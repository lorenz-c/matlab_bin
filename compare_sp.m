clear all

flder = '/media/storage/Data/Surface Pressure/OPANL/original/';
flenm = 'ECMWF_opanl_ps_2002.nc';
PS_opanl = nj_varget([flder, flenm], 'var134');

flder = '/media/storage/Data/Surface Pressure/20th/original/';
flenm = 'pres.sfc.2002.nc';
PS_twenth = nj_varget([flder, flenm], 'pres');

flder = '/media/storage/Data/Surface Pressure/INTERIM/original/';
flenm = 'ECMWF_interim_ps_2002.nc';
PS_interim = nj_varget([flder, flenm], 'var134');

cd /home/lorenz-c/Dokumente/GRACE/SHBundle

l = standing(0:60);
tf = isotf(l, 'sp', 0, 0, 'grace');
tf = tf*ones(1, 121);

for i = 1:365
    sc_opanl{i,1} = cs2sc(gsha(shiftdim(PS_opanl(i,:,:)), 'ls', 'pole', 60));
    sc_opanl{i,2} = sc_opanl{i,1}./tf;
    sc_opanl{i,3} = degvar(sc_opanl{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
    
    sc_twenth{i,1} = cs2sc(gsha(shiftdim(PS_twenth(i,:,:)), 'ls', 'pole', 60));
    sc_twenth{i,2} = sc_twenth{i,1}./tf;
    sc_twenth{i,3} = degvar(sc_twenth{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
    
    sc_interim{i,1} = cs2sc(gsha(shiftdim(PS_interim(i,:,:)), 'ls', 'pole', 60));
    sc_interim{i,2} = sc_interim{i,1}./tf;
    sc_interim{i,3} = degvar(sc_interim{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
end
    

cd /media/storage/Analysis

save sc_twenth2002.mat sc_twenth
save sc_opanl2002.mat sc_opanl
save sc_interim2002.mat sc_interim

clear all


flder = '/media/storage/Data/Surface Pressure/OPANL/original/';
flenm = 'ECMWF_opanl_ps_2003.nc';
PS_opanl = nj_varget([flder, flenm], 'var134');

flder = '/media/storage/Data/Surface Pressure/20th/original/';
flenm = 'pres.sfc.2003.nc';
PS_twenth = nj_varget([flder, flenm], 'pres');

flder = '/media/storage/Data/Surface Pressure/INTERIM/original/';
flenm = 'ECMWF_interim_ps_2003.nc';
PS_interim = nj_varget([flder, flenm], 'var134');

cd /home/lorenz-c/Dokumente/GRACE/SHBundle

l = standing(0:60);
tf = isotf(l, 'sp', 0, 0, 'grace');
tf = tf*ones(1, 121);

for i = 1:365
    sc_opanl{i,1} = cs2sc(gsha(shiftdim(PS_opanl(i,:,:)), 'ls', 'pole', 60));
    sc_opanl{i,2} = sc_opanl{i,1}./tf;
    sc_opanl{i,3} = degvar(sc_opanl{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
    
    sc_twenth{i,1} = cs2sc(gsha(shiftdim(PS_twenth(i,:,:)), 'ls', 'pole', 60));
    sc_twenth{i,2} = sc_twenth{i,1}./tf;
    sc_twenth{i,3} = degvar(sc_twenth{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
    
    sc_interim{i,1} = cs2sc(gsha(shiftdim(PS_interim(i,:,:)), 'ls', 'pole', 60));
    sc_interim{i,2} = sc_interim{i,1}./tf;
    sc_interim{i,3} = degvar(sc_interim{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
end


cd /media/storage/Analysis

save sc_twenth2003.mat sc_twenth
save sc_opanl2003.mat sc_opanl
save sc_interim2003.mat sc_interim

clear all


flder = '/media/storage/Data/Surface Pressure/OPANL/original/';
flenm = 'ECMWF_opanl_ps_2004.nc';
PS_opanl = nj_varget([flder, flenm], 'var134');

flder = '/media/storage/Data/Surface Pressure/20th/original/';
flenm = 'pres.sfc.2004.nc';
PS_twenth = nj_varget([flder, flenm], 'pres');

flder = '/media/storage/Data/Surface Pressure/INTERIM/original/';
flenm = 'ECMWF_interim_ps_2004.nc';
PS_interim = nj_varget([flder, flenm], 'var134');

cd /home/lorenz-c/Dokumente/GRACE/SHBundle

l = standing(0:60);
tf = isotf(l, 'sp', 0, 0, 'grace');
tf = tf*ones(1, 121);

for i = 1:366
    sc_opanl{i,1} = cs2sc(gsha(shiftdim(PS_opanl(i,:,:)), 'ls', 'pole', 60));
    sc_opanl{i,2} = sc_opanl{i,1}./tf;
    sc_opanl{i,3} = degvar(sc_opanl{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
    
    sc_twenth{i,1} = cs2sc(gsha(shiftdim(PS_twenth(i,:,:)), 'ls', 'pole', 60));
    sc_twenth{i,2} = sc_twenth{i,1}./tf;
    sc_twenth{i,3} = degvar(sc_twenth{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
    
    sc_interim{i,1} = cs2sc(gsha(shiftdim(PS_interim(i,:,:)), 'ls', 'pole', 60));
    sc_interim{i,2} = sc_interim{i,1}./tf;
    sc_interim{i,3} = degvar(sc_interim{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
end

cd /media/storage/Analysis

save sc_twenth2004.mat sc_twenth
save sc_opanl2004.mat sc_opanl
save sc_interim2004.mat sc_interim

clear all




flder = '/media/storage/Data/Surface Pressure/OPANL/original/';
flenm = 'ECMWF_opanl_ps_2005.nc';
PS_opanl = nj_varget([flder, flenm], 'var134');

flder = '/media/storage/Data/Surface Pressure/20th/original/';
flenm = 'pres.sfc.2005.nc';
PS_twenth = nj_varget([flder, flenm], 'pres');

flder = '/media/storage/Data/Surface Pressure/INTERIM/original/';
flenm = 'ECMWF_interim_ps_2005.nc';
PS_interim = nj_varget([flder, flenm], 'var134');

cd /home/lorenz-c/Dokumente/GRACE/SHBundle

l = standing(0:60);
tf = isotf(l, 'sp', 0, 0, 'grace');
tf = tf*ones(1, 121);

for i = 1:365
    sc_opanl{i,1} = cs2sc(gsha(shiftdim(PS_opanl(i,:,:)), 'ls', 'pole', 60));
    sc_opanl{i,2} = sc_opanl{i,1}./tf;
    sc_opanl{i,3} = degvar(sc_opanl{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
    
    sc_twenth{i,1} = cs2sc(gsha(shiftdim(PS_twenth(i,:,:)), 'ls', 'pole', 60));
    sc_twenth{i,2} = sc_twenth{i,1}./tf;
    sc_twenth{i,3} = degvar(sc_twenth{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
    
    sc_interim{i,1} = cs2sc(gsha(shiftdim(PS_interim(i,:,:)), 'ls', 'pole', 60));
    sc_interim{i,2} = sc_interim{i,1}./tf;
    sc_interim{i,3} = degvar(sc_interim{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
end

cd /media/storage/Analysis

save sc_twenth2005.mat sc_twenth
save sc_opanl2005.mat sc_opanl
save sc_interim2005.mat sc_interim

clear all




flder = '/media/storage/Data/Surface Pressure/OPANL/original/';
flenm = 'ECMWF_opanl_ps_2006.nc';
PS_opanl = nj_varget([flder, flenm], 'var134');

flder = '/media/storage/Data/Surface Pressure/20th/original/';
flenm = 'pres.sfc.2006.nc';
PS_twenth = nj_varget([flder, flenm], 'pres');

flder = '/media/storage/Data/Surface Pressure/INTERIM/original/';
flenm = 'ECMWF_interim_ps_2006.nc';
PS_interim = nj_varget([flder, flenm], 'var134');

cd /home/lorenz-c/Dokumente/GRACE/SHBundle

l = standing(0:60);
tf = isotf(l, 'sp', 0, 0, 'grace');
tf = tf*ones(1, 121);

for i = 1:365
    sc_opanl{i,1} = cs2sc(gsha(shiftdim(PS_opanl(i,:,:)), 'ls', 'pole', 60));
    sc_opanl{i,2} = sc_opanl{i,1}./tf;
    sc_opanl{i,3} = degvar(sc_opanl{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
    
    sc_twenth{i,1} = cs2sc(gsha(shiftdim(PS_twenth(i,:,:)), 'ls', 'pole', 60));
    sc_twenth{i,2} = sc_twenth{i,1}./tf;
    sc_twenth{i,3} = degvar(sc_twenth{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
    
    sc_interim{i,1} = cs2sc(gsha(shiftdim(PS_interim(i,:,:)), 'ls', 'pole', 60));
    sc_interim{i,2} = sc_interim{i,1}./tf;
    sc_interim{i,3} = degvar(sc_interim{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
end

cd /media/storage/Analysis

save sc_twenth2006.mat sc_twenth
save sc_opanl2006.mat sc_opanl
save sc_interim2006.mat sc_interim

clear all




flder = '/media/storage/Data/Surface Pressure/OPANL/original/';
flenm = 'ECMWF_opanl_ps_2007.nc';
PS_opanl = nj_varget([flder, flenm], 'var134');

flder = '/media/storage/Data/Surface Pressure/20th/original/';
flenm = 'pres.sfc.2007.nc';
PS_twenth = nj_varget([flder, flenm], 'pres');

flder = '/media/storage/Data/Surface Pressure/INTERIM/original/';
flenm = 'ECMWF_interim_ps_2007.nc';
PS_interim = nj_varget([flder, flenm], 'var134');

cd /home/lorenz-c/Dokumente/GRACE/SHBundle

l = standing(0:60);
tf = isotf(l, 'sp', 0, 0, 'grace');
tf = tf*ones(1, 121);

for i = 1:365
    sc_opanl{i,1} = cs2sc(gsha(shiftdim(PS_opanl(i,:,:)), 'ls', 'pole', 60));
    sc_opanl{i,2} = sc_opanl{i,1}./tf;
    sc_opanl{i,3} = degvar(sc_opanl{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
    
    sc_twenth{i,1} = cs2sc(gsha(shiftdim(PS_twenth(i,:,:)), 'ls', 'pole', 60));
    sc_twenth{i,2} = sc_twenth{i,1}./tf;
    sc_twenth{i,3} = degvar(sc_twenth{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
    
    sc_interim{i,1} = cs2sc(gsha(shiftdim(PS_interim(i,:,:)), 'ls', 'pole', 60));
    sc_interim{i,2} = sc_interim{i,1}./tf;
    sc_interim{i,3} = degvar(sc_interim{i,2}, 60, 0, 'geoid', 0, 0, 'grace');
end

cd /media/storage/Analysis

save sc_twenth2007.mat sc_twenth
save sc_opanl2007.mat sc_opanl
save sc_interim2007.mat sc_interim

clear all





