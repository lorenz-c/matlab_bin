function otpt = tsmovav(inpt, wndw)

% The function computes the moving average of a matrix of which the columns
% contain time-series

lag = (length(wndw)-1)/2;

fld = [repmat(inpt(1, :), lag, 1); inpt; repmat(inpt(end, :), lag, 1)];

for i = 1:size(inpt, 2)
    fld_f(:, i) = conv(fld(:, i), wndw);
end

otpt = fld_f(lag+2:end-lag-1, :);
