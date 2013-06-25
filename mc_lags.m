function M = mc_lags(maxlag, nrit, usezero)


for i = 1:nrit
    % Compute the number of lags (i.e. the window length)
    nr_lags = randi([0 maxlag], 1);
    
    if nr_lags == 0
        M{i} = 0;
    else
        tmp = randi([0 maxlag], [1 nr_lags]);
        tmp = sort(unique(tmp), 'ascend');
        if usezero == true
            if tmp(1) ~= 0
                tmp = [0 tmp];
            end
        end
        M{i} = tmp;
    end
end



