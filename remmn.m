function [A, mn] = remmn(inpt, clms, type);

if nargin < 2, clms = [1 2 4]; end
if nargin < 3, type = 'full'; end


A = zeros(size(inpt));

if strcmp(type, 'full')
    A(1, :) = inpt(1, :);
    A(2:end, 1:3) = inpt(2:end, 1:3);
    
    nts = size(inpt, 1) - 1;
    
    mn = nanmean(inpt(2:end, clms(3):end));
    
    A(2:end, 4:end) = inpt(2:end, 4:end) - ones(nts, 1)*mn;
end
