function divfld = flx2div(flx_U, flx_V, dx, dy, theta);
% The function computes divergences from the u- and v-components of a flux
% field. 
%--------------------------------------------------------------------------
% Input:   flx_U, flx_V    u- and v-components of a flux field
%          dx, dy          angular distance between two grid-cells [°]
%          theta           vector of latitudes for the correction of
%                          meridional convergence [°]
% Output:  div             divergence field
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   August 2011
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------

rho = pi/180;                         % Conversion factor from [°] to [rad]
R   = 6371000;                        % Earth radius [m]

if size(theta,2) > 1
    theta = theta';
end

theta = theta*ones(1,720);

dy  = (dy*rho)*R;                     % Metric distance between two    
dx  = (dx*rho)*R*cos(theta*rho);      % gridcells [m]
% keyboard
qv_n   = zeros(size(flx_U));
qv_s   = zeros(size(flx_U));
qu_w   = zeros(size(flx_U));
qu_e   = zeros(size(flx_U));
div_x  = zeros(size(flx_U));
div_y  = zeros(size(flx_U));
divfld = zeros(size(flx_U));

% Computation of the flow from the northern and southern adjacent gridcells
qv_n(2:end-1,:)     = (flx_V(2:end-1,:) + flx_V(1:end-2,:))/2;
qv_s(2:end-1,:)     = (flx_V(2:end-1,:) + flx_V(3:end,:))/2;

% Computation of the flow from the eastern and western adjacent gridcells
qu_w(2:end-1,2:end) = (flx_U(2:end-1,2:end) + flx_U(2:end-1,1:end-1))/2;
qu_w(2:end-1,1)     = (flx_U(2:end-1,1) + flx_U(2:end-1,end))/2;
        
qu_e(2:end-1,1:end-1) = (flx_U(2:end-1,1:end-1) + flx_U(2:end-1,2:end))/2;
qu_e(2:end-1,end)     = (flx_U(2:end-1,end) + flx_U(2:end-1,1))/2;

% Computation of the correction factor for meridional convergence
corr  = 1/2*(qv_n + qv_s).*tan(theta*rho)/R;  

% Partial derivatives of the flux field with respect to the east-west
% and north-south components respectively
div_x = (qu_e - qu_w)./dx;
div_y = (qv_n - qv_s)/dy;
    
divfld = div_x + div_y - corr;