function R = corrmaps(ref, evl, dim)

[n, p] = size(ref{1});


if strcmp(dim, 'time')
    
    for i = 1:length(ref)
        F_ref(i,:) = ref{i}(:)';
        F_evl(i,:) = evl{i}(:)';
    end

elseif strcmp(dim, 'space')
    
    for i = 1:length(ref)
        F_ref(:,i) = ref{i}(:);
        F_evl(:,i) = evl{i}(:);
    end
    
end


tmp = corrcoef(F_ref, F_evl)

