function [a b] = fitline(X, Y, weights)

% The function fits a line in the two datasets X and Y (for a scatterplot)
if nargin < 3
    weights = ones(length(X), 1);
end
    

if find(isnan(X))
    weights = weights(~isnan(X));
    Y = Y(~isnan(X));
    X = X(~isnan(X));   
elseif find(isnan(Y))
    weights = weights(~isnan(Y));
    X = X(~isnan(Y));
    Y = Y(~isnan(Y));
end


A = [X ones(length(X), 1)];
P = diag(weights);

xht = inv(A'*P*A)*A'*P*Y;

a = xht(1);
b = xht(2);