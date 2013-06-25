function [box_data, outliers] = boxplot_data(bxplt_id);

% As MATLAB does (originally) not provide a function to compute the
% elements of a boxplot directly, this function extracts the boxplot data
% (median, upper/lower whisker, the 25% and 75% quantiles and the outliers)
% and stores them in two output matrices. The elements of these matrices
% are as follows:
%
% box_data =  group_id | median | lower_whisker | 25% | 75% |upper_whisker
% outliers =  group_id | outlier_value
% 
% This format can be directly saved as an ascii file and used e.g. for
% creating a box-and-whisker-plot in GMT.
%
%
%              Outlier testing (taken from the MATLAB-help)
%
% The default is a w of 1.5. Points are drawn as outliers if they are 
% larger than q3 + w(q3 – q1) or smaller than q1 – w(q3 – q1), where q1 and 
% q3 are the 25th and 75th percentiles, respectively. The default of 1.5 
% corresponds to approximately +/–2.7σ and 99.3 coverage if the data are 
% normally distributed.
%--------------------------------------------------------------------------
% Input:        bxplt_id     Handle to the boxplot from which the data
%                            shall be extracted
%                            e.g. h = boxplot(data) -> bxplot_id = h
%                                        
% Output:       box_data     median, upper/lower whisker, the 25% and 
%                            75% quantiles of the plotted data
%               outliers     Contains the outliers
%
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   August 2012
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------


% Define handles for the different boxplot elements
h1 = findobj(bxplt_id, 'tag', 'Median');
h2 = findobj(bxplt_id, 'tag', 'Upper Whisker');
h3 = findobj(bxplt_id, 'tag', 'Lower Whisker');
h4 = findobj(bxplt_id, 'tag', 'Outliers');

% Extract the data from the handles
y1 = get(h1, 'YData');      % Median
y2 = get(h2, 'YData');      % Upper Whisker, 75% quantile
y3 = get(h3, 'YData');      % Lower Whisker, 25% quantile
y4 = get(h4, 'YData');      % Outliers

outliers = [];

for i = 1:length(y1)
    box_data(i, 1) = i;
    box_data(i, 2) = y1{i}(1, 1);
    box_data(i, 3) = y3{i}(1, 1);
    box_data(i, 4) = y3{i}(1, 2);
    box_data(i, 5) = y2{i}(1, 1);
    box_data(i, 6) = y2{i}(1, 2);
    
    tmp = [ones(length(y4{i}), 1)*i y4{i}(:)];
    outliers = [outliers; tmp];
end




