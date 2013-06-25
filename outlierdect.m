function flags = outlierdect(ts, kappa, tau)


flags = zeros(length(ts));

for i = 1+kappa:length(ts)-kappa
    tmp = median(ts(i-kappa:i+kappa));
    
    if ts(i) - tmp < tau
        flags(i) = 0;
    else
        flags(i) = 1;
    end
end
    
    
    

