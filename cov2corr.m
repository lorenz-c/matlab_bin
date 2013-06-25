function C = cov2corr(Q)
% The function transforms a covariance matrix Q in a correlation matrix C
% by dividing each matrix element by the correct product of the main
% diagonal elements
[r, c] = size(Q);

for i = 1:r
    for j = 1:c
        C(i, j) = Q(i, j)/(sqrt(Q(i,i))*sqrt(Q(j,j)));
    end
end
keyboard