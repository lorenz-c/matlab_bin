function tau = matrix_corr(inpt, type)





% keyboard

if strcmp(type, 'kendall')
    
    [in1_srt, indx] = sort(inpt, 2, 'descend');

    for i = 1:size(inpt,1)
        tmp = tiedrank(inpt(i,:));
        ranks(i,:) = -tmp + max(tmp) + 1;
    end
    tau = zeros(size(inpt,1), size(inpt,1));
    n = size(inpt,2);

    for i = 1:size(ranks,1)
        tmp = ranks(i:end, indx(i,:));
        Q = zeros(size(tmp,1), 1);
        q = zeros(size(tmp));
    
        for j = 1:size(tmp,1)
            for k = 1:size(tmp,2)
                tmp2 = zeros(1, length(tmp(j, k+1:end)));
                tmp2(tmp(j, k+1:end) <= tmp(j, k)) = 1;
                q(j, k) = sum(tmp2);
            end
        end
        Q    = sum(q,2);
        tau(i, i:end) = 1-4*Q'/(n*(n-1));
    end
    
elseif strcmp(type, 'spearman')
    
elseif strcmp(type, 'pearson')
    A   = inpt - mean(inpt, 2)*ones(1, size(inpt,2));
    std = sum(A.*A,2)
    num = A*A';
    den = std*std';
    tau = num./den;
    
end


% tau = tau + tau' - 
% % 
% [in2_srt, indx2] = sort(indx, 'ascend');



