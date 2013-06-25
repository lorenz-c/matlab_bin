function R = acf_mtrx(Z, l_max, cr_flg);

% 0. 
[n, p] = size(Z);

% 1. Compute the mean 
mn = mean(Z);

% 2. Remove the mean
Z_c = Z - ones(n, 1)*mn;

for l = 0:l_max
    R(l+1, :) = 1/(n-l) * sum(Z_c(1:n-l,:).*Z_c(1+l:end,:));
end

if cr_flg == 1
    R = R./(ones(size(R, 1), 1)*var(Z_c));
end

