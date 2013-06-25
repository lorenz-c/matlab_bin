function R = sampleacf(inpt, lam)
    
% Computes the autocorrelation function of a matrix 
nts = size(inpt, 1);

mn   = mean(inpt, 1);
den  = sum((inpt - ones(nts, 1)*mn).^2);

for i = 0:lam
    indx1 = i+1:nts;
    indx2 = 1:nts-i;
    
    R(i+1, :) =  sum((inpt(indx1, :) - ones(length(indx1),1) * mn).* ...
                     (inpt(indx2, :) - ones(length(indx1),1) * mn))./ ...
                     den;
end
