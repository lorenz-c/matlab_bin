function [R, S, K] = jbtest(F, p);

nts = size(F, 1);

chi_qntls = [0.005  0.01;
             0.010  0.02;
             0.025  0.05;
             0.050  0.10;
             0.100  0.21;
             0.500  1.39;
             0.900  4.61;
             0.950  5.99;
             0.975  7.38;
             0.990  9.21;
             0.995 10.60];

qntl = chi_qntls(find(chi_qntls(:, 1) == p), 2);

if isempty(qntl), error('Unknown propability!'),  end

F = F - ones(nts, 1)*mean(F);

S = ((1/nts)*sum(F.^3))./(1/nts*sum(F.^2)).^(3/2);
K = ((1/nts)*sum(F.^4))./(1/nts*sum(F.^2)).^2;

JB = nts/6*(S.^2 + ((K-3).^2)./4);

R = zeros(size(S));

R(JB < qntl) = 1;


