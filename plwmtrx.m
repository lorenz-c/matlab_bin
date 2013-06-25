function K = plwmtrx(a, b, lmx, otpt, quant)

% The function generates (inverse) degree variances or (inverse) rms-values
% from an estimated polynomial fit signal covariance with the coefficients 
% p. The output can be arranged in any format (matrix, vector, sc, cs or 
% only the coefficients for the desired oder m). 
%--------------------------------------------------------------------------
% Input:  p       [1 x k]   vector with the power law parameters 
%                           (e.g. p = [a b] for a fitted power law)
%                               
%         lmx     [1 x 1]   maximal degree of expansion 
%                           (default: lmx = 60)
%         otpt              Defines the output format:
%                           'cs'    -> K is a (lmax+1) x (lmax+1) matrix in
%                                      cs-format
%                           'sc'    -> K is a (lmax+1) x (2*lmax + 1) matrix
%                                      in sc-format
%                           'vec'   -> K is a (lmax+1)^2 x 1 vector
%         quant             Defines the output quantity
%                           'dv'    -> K contains degree variances
%                           'dv_1'  -> K contains inverse squared degree 
%                                      variances
%                           'rms'   -> K contains rms-values
%                           'rms_1' -> K contains inverse squared rms-values
%                           default: otpt = 'dv'
% Output: K       [n x n]   coefficients of the estimated signal covariance 
%                           in the desired output format 
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   4.12.2009
%--------------------------------------------------------------------------
% Uses: mat2vec.m, sc2cs.m, cs2sc.m
%--------------------------------------------------------------------------
% Updates: - 11.10.2011: Code brush up (CL)

if nargin < 2 
    lmx = 60;
end

if nargin < 3
    otpt = 'mat'
end

if nargin < 5
    quant = [];
end

% Creating a vector with logarithmic degree values
l = standing(0:lmx);

% Evaluation of the polynomial at the computation points l
tmpsig = a*l.^b;

% Compute the desired output quantity
if strcmp(quant, 'dv_1')                     % Inverse degree variances
    tmpsig = 1./tmpsig;
elseif strcmp(quant, 'rms')                  % Degree-rms
    tmpsig = sqrt(tmpsig./(2*l+1));
elseif strcmp(quant, 'rms_1')                % Inverse (squared) degree-rms
    tmpsig = 1./(tmpsig./(2*l+1));
end


% Adding zeros as deg. 0 and 1 values and rearange the coefficients in the
% s/c-format
tmpsig = repmat([0; 0; tmpsig(3:end)], 1, 2*lmx+1).* ...
        [fliplr(tril(ones(lmx+1, lmx), -1)) tril(ones(lmx+1, lmx+1), 0)]; 

% Rearranging the values into the desired output format
if strcmp(otpt, 'vec')
    K = mat2vec(tmpsig);
elseif strcmp(otpt, 'cs')
    K = sc2cs(tmpsig);
elseif strcmp(otpt, 'sc')
    K = tmpsig;
end
