function [dC, vals]  = evalcndcopula(dC, theta, u, v, theta_hat, var, uvval)

vals = linspace(0, 1, 1000);


dC = subs(dC, theta, theta_hat);

if strcmp(var, 'u')
    dC = subs(dC, u, uvval);
    dC = subs(dC, v, vals);
elseif strcmp(var, 'v')
    dC = subs(dC, v, uvval);
    dC = subs(dC, u, vals);
end

    