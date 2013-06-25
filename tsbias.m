function B = tsbias(obs, sim, type);

[obs, sim] = find_sim_tspts(obs, sim);
fld1 = obs(2:end, 4:end);
fld2 = sim(2:end, 4:end);

mask = ones(size(fld1));

mask(isnan(fld1)) = 0;
mask(isnan(fld2)) = 0;

fld1(mask == 0) = 0;
fld2(mask == 0) = 0;

if strcmp(type, 'rel')
    B = (sum(fld1) - sum(fld2))./sum(fld1);
elseif strcmp(type, 'abs')
    B = (sum(fld1) - sum(fld2))./sum(mask);
end
