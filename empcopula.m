function C = empcopula(r, s, disc)

if nargin < 3, disc = 100; end

n = 1/disc;
u = 0+n/2:n:1-n/2;
v = u;




% [Xs, r]  = sort(X, 'ascend');
% [Ys, s]  = sort(Y, 'ascend');

n = length(r);

% n = length(X);

% for i = 1:length(u)
%     for j = 1:length(v)
%         C(i, j) = sum((r/(n+1)<=u(i)).*(s/(n+1)<=v(j)))/n;
%     end
% end
for i = 1:length(u)
    for j = 1:length(v)
        C(i, j) = sum((r<=u(i)).*(s<=v(j)))/n;
    end
end