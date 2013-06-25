function F_lag = lagged_matrix(F, lags, method)

[nts, npts] = size(F);
nr_lags     = length(lags);


F_lag = zeros(nts - max(lags), nr_lags*npts);

if method == 1
    for i = 1:nr_lags
        indx = (lags(i)+1:nts-max(lags)+lags(i))';
        F_lag(:, (i-1)*npts + 1 : i*npts) = F(indx, :);
    end
elseif method == 2
    keyboard
    for i = 1:nr_lags
        
        indx(:, i) = (lags(i)+1:nts-max(lags)+lags(i))';
        F_lag(:, (i-1)*npts + 1 : i*npts) = F(indx, :);
    end
   
    end
end



        
    