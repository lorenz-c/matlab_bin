function [xht, yht] = trend(inpt, deg);


n = length(inpt);
x = (0:n-1)';

A = ones(n,1);

for i = 1:deg
    A = [A x.^i];
end


xht = inv(A'*A)*A'*inpt;
yht = A*xht;


