function [eofs, pcs, lams] = eof_simple(F, mxmde);


[n, p] = size(F);

if nargin < 2
    mxmde = p;
end

% Removing the mean
F_prime = F - ones(n,1)*mean(F,1);

% Computation of the (small) covariance matrix
L = F_prime*F_prime';

% Eigenvectors and eigenvalues for the covariance matrix
if mxmde == p
    [U, P, V] = svd(F);
else
    [U, P, V] = svds(F, mxmde);
end

lams(:,1) = diag(P).^2;
lams(:,2) = lams/sum(lams);

eofs = V;
pcs  = F*eofs;


