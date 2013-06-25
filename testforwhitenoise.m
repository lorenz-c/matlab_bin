function Q_ks = testforwhitenoise(inpt, rema0)
% The function tests a time-series (or a matrix of time-series) for white
% noise. Therefore, the time-series is first transformed to the spectral
% domain. From the fourier-coefficients, the PSD and the CDF are computed.
% With these, the function performs a KS-test.
%--------------------------------------------------------------------------
if nargin < 2
    rema0 = true;
end

[a, b]   = spec(inpt);
[n, p]   = size(a);

if rema0 == true
    a = a(2:end, :);
    b = b(2:end, :);
end


[cn, sn] = emp_cdf(a, b);
keyboard
Q_ks = emp_ks_tst(sn);


scrsz = get(0,'ScreenSize');
figure('OuterPosition',[1 scrsz(4)/2 scrsz(3)/4 scrsz(4)/4])
title('KS Test for white noise')
plot(Q_ks(1,:), 'o', 'MarkerEdgeColor', 'k', ...
                     'MarkerFaceColor', 'b', ...
                     'MarkerSize', 8);
ytick{1} = 'H_0 Rejected';
ytick{2} = 'H_0 Accepted';

set(gca, 'ytick', [0 1]);
set(gca, 'yticklabel', ytick);
xlabel('# of time-series')
axis([1 p 0 1])
pbaspect([size(a,2)/2 2 1])


