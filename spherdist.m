function [d d_r] = spherdist(la_A, th_A, la_B, th_B)

% spherdist.m computes the spherical distance between two points A and B, 
% which are given in spherical longitude lambda and co-latitude theta.
%--------------------------------------------------------------------------
% Input:        la_A, th_A   [1 x 1] longitude and co-latitude of A [deg]      
%               la_B, th_B   [1 x 1] longitude and co-latitude of B [deg]     
%
% Output:       d            [1 x 1] spherical distance between A and B [m]
%               d_r          [1 x 1] angular distance between A and B [rad]                    
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   8. Sep. 08
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------

if nargin < 4
    dlon = dlat;
end

la_A = la_A*pi/180;
th_A = th_A*pi/180;
la_B = la_B*pi/180;
th_B = th_B*pi/180;

% Radius of the Earth
R = 6378137;

% Angular distance between A and B [rad]
d_r = acos(sin(th_A).*sin(th_B).*cos(la_A - la_B) + cos(th_A).*cos(th_B));

% Spherical distance between A and B [m]
d   = R*d_r;
