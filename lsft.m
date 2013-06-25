function [a b] = lsft(y,t,T);
% The function computes a least-squares fit to estimate the a and b
% coefficients of a fourier series. It should be used when the data has
% gaps, i.e. when a normal fft can not be performed. 
% Note that the first coefficient a_0 is not estimated, i.e. the mean
% should be already removed from the data.
%--------------------------------------------------------------------------
% Input (mandatory):
% - y  [t x 1]      Vector containing the data 
% 
% Input (optional):
% - t  [t x 1]      Vector containing the time-steps (i.e. the sampling
%                   times) of the data vector y.
% - T  scalar       Period of the lowest frequency (i.e. the fundamental
%                   frequency). In general, T equals the length of the 
%                   GAP-FREE time-series
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   January 201
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------



if nargin < 4
    showfit = true;
end

if nargin < 3
    T = length(y); 
    if nargin < 2
        t = (0:T-1)';
    else
        if size(t,1) ~= 1
            t = t';
        end
    end
end

% Fundamental frequency
omega_0 = 2*pi/T;

n = 1:T/2;
N = max(n);

omega_n = n*omega_0;

A = [cos(t*omega_n) sin(t*omega_n)];
x_hat = inv(A'*A)*A'*y;

a = x_hat(1:N);
b = x_hat(N+1:end);

if showfit == true
    figure
    t_nw = 0:1:T-1;
    
    plot(t, y)
    hold on
    plot(t_nw, A*x_hat, 'r')
end





