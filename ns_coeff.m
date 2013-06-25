function E = ns_coeff(obs, mdl, tscale)

if nargin < 3, tscale = 'monthly'; end

if strcmp(tscale, 'monthly')
  
    [obs, mdl] = find_sim_tspts(obs, mdl);

    obs = obs(2:end, 4:end);
    mdl = mdl(2:end, 4:end);
    
elseif strcmp(tscale, 'mean_monthly')
    obs = obs(2:end, 2:end);
    mdl = mdl(2:end, 2:end);
end


d1 = (obs - mdl).^2;
d2 = (obs - ones(size(obs, 1), 1)*nanmean(obs, 1)).^2;


E = 1 - nansum(d1)./nansum(d2);


% keyboard