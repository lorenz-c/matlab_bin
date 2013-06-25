function Q_ks = emp_ks_tst(Sn, Pn, alpha)



[N, C] = size(Sn);

if nargin < 3
    alpha = 0.05;
end

if N < 41
    load kstable.txt
    if alpha == 0.1
        d_alpha = kstable(N, 2);
    elseif alpha == 0.05
        d_alpha = kstable(N, 3);
    elseif alpha == 0.025
        d_alpha = kstable(N, 4);
    elseif alpha == 0.01
        d_alpha = kstable(N, 5);
    elseif alpha == 0.005
        d_alpha = kstable(N, 6);
    else
        error('Alpha-value unknown... ')
    end
else
    if alpha == 0.1
        d_alpha = 1.07/sqrt(N);
    elseif alpha == 0.05
        d_alpha = 1.22/sqrt(N);
    elseif alpha == 0.025
        d_alpha = 1.36/sqrt(N);
    elseif alpha == 0.01
        d_alpha = 1.52/sqrt(N);
    elseif alpha == 0.005
        d_alpha = 1.63/sqrt(N);
    else
        error('Alpha-value unknown... ')
    end
end
    
        
% If no distribution is provided, the test assumes the cdf for white noise
if nargin < 2
    Pn = (0:1:N-1)'/(N);
end



deltaCDF  =  abs(Sn - Pn*ones(1,C));
KSstatistic   =  max(deltaCDF);


% doi_max     = max(Sn - Pn*ones(1, C));
% doi_min     = min(Sn - Pn*ones(1, C));
% 
% doi         = max(abs(Sn - Pn*ones(1, C)));
% 
% Q_ks = zeros(3, C);
% Q_ks(1, doi < d_alpha)  = 0;
% Q_ks(1, doi >= d_alpha) = 1;
% Q_ks(2, doi_max > abs(doi_min))   = 1;
% Q_ks(2, doi_max < abs(doi_min))   = -1;
% Q_ks(2, doi_max == abs(doi_min))   = 0;
% Q_ks(3, :) = doi;

lambda =  max((sqrt(N^2/(2*N)) + 0.12 + 0.11/sqrt(N^2/(2*N))).* KSstatistic , 0);
pValue  =  exp(-2.*lambda.*lambda);

% Q_ks = zeros(3, C);
% Q_ks(1, alpha >= pValue) = 

Q_ks = alpha >= pValue;


fprintf('Testing for white noise... \n');
fprintf('Test value: %g \n', d_alpha(1))








