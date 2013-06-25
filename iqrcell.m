function Q = iqrcell(inpt, mask, period, clms)

if nargin < 4, clms = [3 4 8]; end


inpt        = findtstps(inpt, period, clms(2));
[F, cindx]  = cell2catchmat(inpt(:, clms(3)), mask);

tmp = iqr(F, 1);
tmp = catchmat2cell(tmp, cindx, 360, 720, NaN);

Q = tmp{1};



