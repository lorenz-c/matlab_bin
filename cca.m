function [wx, wy, lam] = cca(X, Y);

% Canonical correlation analysis for the two [m x n] data matrices X and Y 
% which containn n samples of two m-dimensional random variables.


[rx, cx] = size(X);
[ry, cy] = size(Y);

if rx ~= ry | cx ~= cy
    error('Data matrices must have the same dimension');
end


% 1. Removing the mean
Ax = X - ones(rx, 1)*mean(X,1);
Ay = Y - ones(ry, 1)*mean(Y,1);

% Performing an svd for the data matrices
[Ux, Dx, Vx] = svd(Ax, 'econ');
[Uy, Dy, Vy] = svd(Ay, 'econ');

K = Ux'*Uy;

[U, D, V] = svd(K, 'econ');


wx = Vx*inv(Dx)*U;
wy = Vy*inv(Dy)*V;

lam = diag(D).^2;



