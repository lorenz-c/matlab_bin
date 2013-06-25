function [Qs, scle] = scalecov(Q, dg_std)
% The function scales a e.g. simulated covariance matrix Q with the
% magnitude of some errors sdevs depending on their autocovariances.
%--------------------------------------------------------------------------
% Input:        Q         [n x n]   Covariance matrix

%               sdevs     [m x m]   
%                                        
% Output:       A         [n x 1]   area of the pixels on the surface
%                                   of the Earth [m^2]          
%--------------------------------------------------------------------------
% Author: Christof Lorenz, IMK-IFU Garmisch-Partenkirchen
% Date:   October 20011
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------

% Checking the input format of the simulated errors and rearange the 
% elements in a column-vector
% [frmt, lmx, dg_std] = chkfrmt(sdevs, 'cvec');

% Create a column-vector from the diagonal elements of Q
dg_Q   = sqrt(diag(Q));

% Auto-covariance of the simulated covariance matrix
AK_Q   = dg_Q*dg_Q';

% Auto-covariance of the errors
AK_std = dg_std*dg_std';

% Computing the scale-factor
scle   = AK_std./AK_Q;

% Re-scaling the simulated covariance matrix
Qs     = Q.*scle;











