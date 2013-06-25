function A = area_wghts(theta, dlambda, otpt, method, R)

% area.m computes the area of a particular pixel (or a vector with pixel
% center coordinates) according to its co-latitude and angular side length
%--------------------------------------------------------------------------
% Input:        n         [1 x 1]   angular side length of a pixel [deg]
%                                   (default: n = 0.5°)   
%               theta     [n x 1]   co-latitude of the pixel center [deg] 
%                                        
% Output:       A         [n x 1]   area of the pixels on the surface
%                                   of the Earth [m^2]          
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   January 2008
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------

if nargin < 5, R = 6378137; end
if nargin < 4, method = 'regular'; end
if nargin < 3, otpt = 'vec'; end
if nargin < 2, dlambda = abs(theta(2) - theta(1)); end

rho = pi/180;



dlat = abs(theta(2) - theta(1));

lat1 = (theta + dlat/2)*rho;
lat2 = (theta - dlat/2)*rho;

dlat = dlat*rho;
dlon = dlambda*rho;


if strcmp(method, 'haversine')
    
    for i = 1:length(theta)
        sn(i,1) = haversine(lat1(i), lat1(i), dlambda*rho);
        ss(i,1) = haversine(lat2(i), lat2(i), dlambda*rho);
        sew(i,1) = haversine(lat1(i), lat2(i), 0);
    end
    
    A = 1/2*(sn + ss).*sew;
    

    
elseif strcmp(method, 'regular')

    A = abs(dlon*R^2.*(sin(lat1) - sin(lat2)))';
    
elseif strcmp(method, 'cos')

    A = cos(theta*pi/180)';
    
elseif strcmp(method, 'vincenty')
    
    for i = 1:length(theta)
        sn(i,1)  = vincenty(lat1(i), lat1(i), dlambda*rho);
        ss(i,1)  = vincenty(lat2(i), lat2(i), dlambda*rho);
        sew(i,1) = vincenty(lat1(i), lat2(i), 0);
    end

    % Interpolation for equatorial values
    snnan = find(isnan(sn));
    ssnan = find(isnan(ss));
    
    sn(snnan) = (sn(snnan-1) + sn(snnan+1))/2;
    ss(ssnan) = (ss(ssnan-1) + ss(ssnan+1))/2;
    
    A = 1/2*(sn + ss).*sew;
end


if strcmp(otpt, 'mat')
    A = A*ones(1,360/(dlambda));
end

    


  