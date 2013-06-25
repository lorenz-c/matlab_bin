function [a, b] = plfit(x,y,w,xmin,xmax)

% This function computes the parameters a and b of a power law y = a*x^b.
% Therefore, the input data and the computation points are first
% transformed to the logarithmic scale, where a power law can be
% approximated by a straight line according to
%
%    y(x) = a*x^b -> log10(y) = log10(a*x^b) = log10(a) + k*log10(x)
%                   with log10(x) = u and log10(y) = v 
%                           v = b*u + log10(a)
%                           
%--------------------------------------------------------------------------
% Input:     x   [n x 1]    computation points
%            y   [m x 1]    data
%            w   [m x 1]    weights (if no weights should be applied,
%                                w = 1), (default)
%
% Output     xht [2 x 1]    Estimated parameters of the power law where
%                           xht = [a b]' and A = exp(a)
%            yht [m x 1]    Adjusted observations
%            sig [2 x 1]    Standard deviations of the estimated parameters
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   September 2008
%--------------------------------------------------------------------------
% Uses:   
%--------------------------------------------------------------------------
% Updates: - 11.10.2011: Added the parameter w to do a weighted estimation
%                        Added some help text. (CL)


% Checking the input arguments
if length(x) ~= length(y)
    error('X and Y must have the same size!')
end

if size(x,2) > 1; x = x'; end
if size(y,2) > 1; y = y'; end

if nargin < 3
    w = 1;
elseif length(w) ~= length(y) & size(w) ~= 1
    error('Y and W must have the same size!')
elseif size(w) == 1
    w = ones(length(y));
end

sind = find(x == xmin)
if nargin < 5
    [tmp, eind] = min(y(sind+1:end));
    eind
else
    eind = find(x == xmax)    
end
    



v = log10(y(sind:eind));
u = log10(x(sind:eind));

% Data-size
n = length(u); 

% Set up the coefficient matrix
A = [ones(n, 1) u];

% Arrange the weights in a diagonal matrix (no correlations between the
% power-law coefficients are assumed)
P = diag(w(sind:eind));

% Computation of the normal matrix
N = inv(A'*P*A);

% Estimation of the power-law parameters
xht = N*A'*P*v;

% Compute the adjusted observations
yht = A*xht;

% Compute the standard deviations of the estimated parameters
sig = sqrt(diag(N));

a = 10^xht(1);
b = xht(2);







