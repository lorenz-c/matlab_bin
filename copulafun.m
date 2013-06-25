function [C u v theta] = copulafun(Family)

syms u v theta

if strcmp(Family, 'Gumbel')
    C = exp(-((-log(u))^theta + (-log(v))^theta)^(1/theta));
elseif strcmp(Family, 'Clayton')
    C = (u^-theta + v^-theta - 1)^(-1/theta);
elseif strcmp(Family, 'Frank')
    C = -(1/theta)*log(1 + ((exp(-theta*u)-1)*(exp(-theta*v)-1))/(exp(-theta) - 1));
end
