function [R E sig] = taylor_stats(r, varargin);

if size(r, 2) > 1, r = r'; end
% for i = 1:length(varargin)
ndta = numel(varargin); 
   
% keyboard
% [rr cr] = size(r);

% Compute a big matrix containing all the time-series
ts_mat(:,1) = r;
for i = 1:ndta
    tmp = varargin{i};
    if size(tmp, 2) > 1, tmp = tmp'; end
    
    ts_mat(:,i+1) = varargin{i};
end

% Look for NaNs in the Time-series and remove the appropriate rows
[nan_r, nan_c] = find(isnan(ts_mat));
ts_mat(nan_r, :) = [];

nts = size(ts_mat, 1);

mn  = mean(ts_mat, 1);
sig = std(ts_mat, 1);
ts_mat_c = ts_mat - ones(nts, 1)*mn;
C        = (ts_mat_c'*ts_mat)./(nts*sig'*sig);
R        = C(1,:);
E        = sqrt(1/nts*sum((ts_mat_c - ts_mat_c(:,1)*ones(1, ndta+1)).^2));








