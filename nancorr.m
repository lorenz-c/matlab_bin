function C = nancorr(X, Y)
% NANCORR calculates the sample correlation coefficient
%    for the series with NaNs expected.
%    X is the one series, Y is another.

[r1, c1] = size(X);
[r2, c2] = size(Y);

if r1 ~= r2 | c1 ~= c2
    error('The samples must be of the same size')
end

% Set the missing values to NaN
Y(isnan(X)) = NaN;
X(isnan(Y)) = NaN;

% Compute the mean
Xm=nanmean(X);
Ym=nanmean(Y);

num = nansum((X - ones(r1, 1)*Xm).*(Y - ones(r1, 1)*Ym));
den = nansum((X - ones(r1, 1)*Xm).^2).*nansum((Y - ones(r1, 1)*Ym).^2);         

C   = num./sqrt(den);