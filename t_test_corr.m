function PG = t_test_corr(R, n);
% 
% if nargin < 2
%     R = matrix_corr(inpt, 'pearson');
% end

PG = zeros(size(R));

for i = 1:size(R,1);
    PG(i, i:end) = R(i,i:end).*sqrt((n-2)./(1-R(i,i:end).^2));
end


Q = tinv(0.95, 119);
keyboard