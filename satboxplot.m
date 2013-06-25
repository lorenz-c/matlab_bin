function h=satboxplot(x, y, bincentres, outlierstyle, varargin)

% satboxplot Modified boxplot
%
% Alternative boxplot. Bins the data (in y) according to bins (in xbin).
% For each bin, plots the median (by default a horizontal red line),
% a box connecting to the 25th and 75th percentile, and whiskers extending
% to the 1st and 99th percentile. All other data are considered outliers
% and plotted individually. To change what the result looks like, add
% additional arguments that will be passed on to <a href="matlab:help boxplot">boxplot</a>
%
% FORMAT
%
%   h = satboxplot(x, y, xbin, outlierstyle, ...)
%
% IN
%
%   x               numeric array
%                   Data according to which y is binned.
%   y               numeric array
%                   Data for which statistics are carried out, binned
%                   according to the values of x, etc.
%   bincentres      Bin centres for x 
%   outlierstyle    Style for outliers, e.g. 'kx'
%   ...     all additional arguments passed on to <a href="matlab:help boxplot">boxplot</a>
%
% OUT
%
%  h                numeric scalar, plot handle
%                   handle to outliers (for other handles, see <a href="matlab:help boxplot">boxplot</a>)
%
% $Id$

binedges = [-inf (bincentres(1:end-1)+bincentres(2:end))/2 inf];
values_cell = bin(x, y, binedges);
% convert values to a matrix with binned values in the columns, rest nans
maxsize = max(cellfun(@length, values_cell));
vals_mapped = cellfun(@(v) [v; nan(maxsize-length(v), 1)], values_cell(1:end-1), 'UniformOutput', false);
values = horzcat(vals_mapped{:});

q = quantile(values, [0.01 0.25 0.5 0.75 0.99]);

for c = 1:size(values, 2)
    toosmall = values(:, c) < q(1, c);
    toolarge = values(:, c) > q(5, c);
    outliers = [values(toosmall, c); values(toolarge, c)];
    all_outliers(1:length(outliers), c) = outliers;
end

all_outliers(all_outliers==0)=nan;
hold on;
boxplot(q, bincentres, 'positions', bincentres, 'labelorientation', 'inline', 'whisker', inf, varargin{:});
set(gca,'xtickmode','auto','xticklabelmode','auto');
if ~isempty(all_outliers)
    h=plot(bincentres, all_outliers, outlierstyle);
else
    h = -1;
end
