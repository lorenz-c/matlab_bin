function maps = corrmaps_eof(data, pcs, lams, method, mnflg)

if nargin < 4
    method = 'corr';
end

if nargin < 5
    mnflg = true;
end

if iscell(data)
    [rws, cls] = size(data{1});
    for i = 1:length(data)
        F(i,:) = data{i}(:)';
    end

else
    F = data;
end

[n_F, p_F] = size(F);
[n_P, p_P] = size(pcs);


if mnflg == true
    F = F - ones(n_F,1)*mean(F);
end

if n_F ~= n_P
    error('Data and PCs must have the same number of time-steps')
end

if strcmp(method, 'corr')
    F_n  = F./(ones(n_F,1)*sqrt(var(F)));
    PC_n = pcs./(ones(n_P,1)*sqrt(var(pcs)));
    
    map_mtrx = 1/n_F*(F_n'*PC_n);
    
elseif strcmp(method, 'cov')
    
    map_mtrx = 1/n_F*(F'*PC);
    
end


if iscell(data)
    keyboard
    for i = 1:size(map_mtrx,2)
        maps{i,1} = reshape(map_mtrx(:,i), rws, cls);
    end
else
    maps = map_mtrx;
end

        
        