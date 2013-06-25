function vimfd = flx2vimfd(inpt, uflx_c, vflx_c, con)

% -------------------------------------------------------------------------
% The funciton computes maps of vertically integraded moisture flux 
% divergences from fields of eastward and northward specific humidity
% -------------------------------------------------------------------------
% Input:   inpt    [n x m]     cell-array which contains month, year,
%                              eastward and northward component of specific 
%                              humidity
%          uflx_c  [1 x 1]     column in which the fields of the eastward 
%                              component of specific humidity is stored   
%          vflx_c  [1 x 1]     column in which the fields of the northward 
%                              component of specific humidity is stored
%
% Output:  vimfd   [n x 3]     cell-structure which contains the month and 
%                              year of a specific dataset in the first two 
%                              columns and the fields of vertically 
%                              integraded moisture flux divergences in the 
%                              third column
%                           
% -------------------------------------------------------------------------
% Christof Lorenz, IMK-IFU Garmisch-Partenkirchen
% September 2010
% -------------------------------------------------------------------------
% Uses: 
% -------------------------------------------------------------------------

R_e = 6370;

uflx = inpt(:,uflx_c);
vflx = inpt(:,vflx_c);

if nargin < 4 
    con = 0;
end

if nargin < 2
    uflx_c = 3;
    vflx_c = 4;
end



dim = size(uflx{1,1});

n_lats  = dim(1);
n_longs = dim(2);

d_lat   = 180/n_lats;
d_long  = 360/n_longs;

lat(:,1) = 90-d_lat/2:-d_lat:-90+d_lat/2;
lon(1,:) = -180+d_long/2:d_long:180-d_long/2;


distx(:,1) = cos(lat*pi/180)*((R_e*pi*2/360)*0.5) * 1000;

disty = (((R_e*pi*2/360)*0.5) * 1000);

f_n  = zeros(size(uflx{1,1}));
f_s  = zeros(size(uflx{1,1}));
f_w  = zeros(size(uflx{1,1}));
f_e  = zeros(size(uflx{1,1}));
corr = zeros(size(uflx{1,1}));

%  -------fn-------
%  |              |
%  |              |
% fw    vimfd    fe 
%  |              |
%  |              |
%  -------fs-------

dist_x_mask = distx*ones(1,720);
lat_mask    = lat*ones(1,720);

for i = 1:length(uflx)
    
    vimfd{i,1} = inpt{i,1};
    vimfd{i,2} = inpt{i,2};
    vimfd{i,3} = zeros(size(uflx{1,1}));
    
    f_n(2:end-1,:) = (vflx{i}(2:end-1,:) + vflx{i}(1:end-2,:))/2;
    f_s(2:end-1,:) = (vflx{i}(2:end-1,:) + vflx{i}(3:end,:))/2;
    
    f_w(2:end-1, 2:end-1) = (uflx{i}(2:end-1,2:end-1) + uflx{i}(2:end-1, 1:end-2))/2;
    f_e(2:end-1, 2:end-1) = (uflx{i}(2:end-1,2:end-1) + uflx{i}(2:end-1, 3:end))/2;
    
    f_w(2:end-1, 1)   = (uflx{i}(2:end-1,1)     + uflx{i}(2:end-1,end))/2;
    f_w(2:end-1, end) = (uflx{i}(2:end-1,end-1) + uflx{i}(2:end-1,end))/2;
    
    f_e(2:end-1, 1)   = (uflx{i}(2:end-1,1) + uflx{i}(2:end-1,2))/2;
    f_e(2:end-1, end) = (uflx{i}(2:end-1,end) + uflx{i}(2:end-1,1))/2;
            
    % Correction factors
    corr(2:end-1,:) = ((f_n(2:end-1,:)+f_s(2:end-1,:))*0.5.*tan(lat_mask(2:end-1,:)*pi/180))/(R_e*1000);
   
    div_x = (f_e-f_w)./dist_x_mask;
    div_y = (f_n-f_s)/disty;

    vimfd{i,3}(:,:)   = div_x + div_y - corr; 
    vimfd{i,3}(1,:)   = mean(vimfd{i,3}(1,:));
    vimfd{i,3}(end,:) = mean(vimfd{i,3}(end,:));
    
    if con == 1
        vimfd{i,3} = vimfd{i,3}*(-1);
    end
    
end
