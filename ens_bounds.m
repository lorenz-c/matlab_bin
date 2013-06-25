function [mins, maxs] = ens_bounds(varargin)


nts = size(varargin{1}, 1);

for i = 1:nts
    for j = 1:length(varargin)
        tmp(j, :) = varargin{j}(i, :);
    end
    mins(i, :) = min(tmp);
    maxs(i, :) = max(tmp);
end
