function [dC u v theta] = condcopula(Family, var)


[C u v theta] = copulafun(Family);


if strcmp(var, 'u')
    dC = diff(C, u);
elseif strcmp(var, 'v')
    dC = diff(C, v);
end