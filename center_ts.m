function [otpt, A, x, comps] = center_ts(inpt, method, mval, mnswitch)

if nargin < 4, mnswitch = 1;     end
if nargin < 3, mval     = -9999; end
if nargin < 2, method   =     4; end

[nlats, nlons] = size(inpt{1});
nts = length(inpt);

for i = 1:nts
    F(i,:) = inpt{i}(:);
end

c_m = find(F(1,:) == mval);
c_v = find(F(1,:) ~= mval);

otpt_t = F;
otpt_t(:, c_m) = [];


if mnswitch
    mn     = mean(otpt_t, 1);
    otpt_t = otpt_t - ones(nts, 1)*mn;
end

[nts, ngrd] = size(F);

t = (0:nts-1)';
if method == 1
    A = ones(nts, 1);
elseif method == 2
    A = [ones(nts, 1) t];
elseif method == 3
    A = [ones(nts,1) t cos(pi/6*t) sin(pi/6*t)];
elseif method == 4
    A = [ones(nts,1) t cos(pi/6*t) sin(pi/6*t) cos(pi/3*t) sin(pi/3*t)];
elseif method == 5
    otpt_t = detrend(otpt_t);
    A = [cos(pi/6*t) sin(pi/6*t) cos(pi/3*t) sin(pi/3*t) cos(pi/2*t) sin(pi/2*t)];
end

for i = 1:size(otpt_t, 2)
	x(:,i) = inv(A'*A)*A'*otpt_t(:, i);
end

rem = A*x;

ncomps = size(x, 1);
comps = zeros(ncomps, ngrd);
for i = 1:ncomps
    tmp = x(i,:);
    comps(i, c_m) = mval;
    comps(i, c_v) = tmp;
end

otpt = zeros(nts, ngrd);
otpt(:, c_m) = mval;
otpt(:, c_v) = otpt_t - rem;

        
            

    

    
    

            
            
            
            
            
            
            
            
            



























