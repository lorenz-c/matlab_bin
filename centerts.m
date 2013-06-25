function [rsdl, estts, mn, trnd, yrcle] = centerts(inpt)

n = length(inpt);

% Remove the mean
A  = ones(length(inpt), 1);
mn = 1/n*(A'*inpt);

cntr = inpt - mn;

% Estimate the trend and the annual cycle
tmp = eye(12);
A = [(1:n)' repmat(tmp, [n/12, 1])];
xht = A\cntr;
estts = A*xht + mn;

rsdl  = inpt - estts;
trnd  = xht(1);
yrcle = xht(2:end);




