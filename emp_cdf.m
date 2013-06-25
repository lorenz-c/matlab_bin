function [cn, sn] = emp_cdf(a, b, pltflg);
% Estimate the EMPIRICAL cdf from the fourier coefficients a and b. Note
% that there are more accurate approaches than the simple brut-force
% method.
%--------------------------------------------------------------------------

if nargin < 3
    pltflg = false;
end

[n, p] = size(a);

% Estimate the power spectral density
c = a.^2 + b.^2;
% c = sqrt(c);
% c = c./(f'*ones(1, p));
cn = c./(ones(n, 1)*sum(c));
sn = cumsum(cn);


f_ny = 6;
f    = (1:n)/n*f_ny;
if pltflg == true
    figure
    subplot(1,2,1)
    plot(f, cn, 'linewidth', 1.5)
    xlabel('[cycles/year]')
    ylabel('[ ]')
    title('Normalized PSD')
    axis square

    subplot(1,2,2)
    plot(f, sn)
    xlabel('[cycles/year]', 'linewidth', 1.5)
    ylabel('[ ]')
    title('Normalized CDF')
    axis square
end



