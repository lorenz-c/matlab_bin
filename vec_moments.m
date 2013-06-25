function [mu, sig, g1, g2] = vec_moments(ts, bswitch);

if nargin < 2, bswitch = 0; end

% Computes the curtosis and skewness of a matrix containting columns of 
% time-series, i.e. each row might be a map and each column a time-series 
% through a pixel

nts = size(ts, 1);


% Compute the mean (first moment)
mu = mean(ts, 1);

% Centralize the dataset
ts_c = ts - ones(nts, 1)*mu;

% Compute the population variance (second moment)
sig = 1/nts*sum(ts_c.^2);

% Compute the skewness (third moment)
g1 = (1/nts*sum(ts_c.^3))./((1/nts*sum(ts_c.^2)).^(3/2));

% Compute the curtosis (fourth moment)
g2 = (1/nts*sum(ts_c.^4))./((1/nts*sum(ts_c.^2)).^2) - 3;


if bswitch
    sig = (nts - 1)/nts * sig;
    g1 = sqrt(nts*(nts - 1))/(nts - 2)*g1;
    g2 = (nts - 1)/((nts - 2)*(nts - 3)) * ((nts + 1) * g2 + 6);
end
    
    