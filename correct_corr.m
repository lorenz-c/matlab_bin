function Cc = correct_corr(C);

[V, D] = eig(C);

D = max(D, 0);

T = diag(1./(V.^2 * diag(D)));

B = V*sqrt(D);

B = sqrt(T)*B;

Cc = B*B';
% keyboard