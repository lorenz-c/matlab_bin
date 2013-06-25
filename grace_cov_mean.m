function Q_mean = grace_cov_mean(inames, type, oname)

% The function computes a full mean covariance matrix of GRACE. It can be
% chosen between deviations from the mean or derivatives .
%--------------------------------------------------------------------------
% Input:        fnames    'cell'    List of filenames which should be
%                                   incorporated in the mean field
%
%               type      'string'  Defines the type of preprocessing:
%                                   'mean'  -> mean is removed
%                                   'derr'  -> derivatives are computed (TBI)
%               oname     'string'  Filename where the mean covariance
%                                   matrix should be saved
%                                        
% Output:       Q_mean     [n x n]  Mean covariance matrix
%--------------------------------------------------------------------------
% Author: Christof Lorenz, IMK-IFU Garmisch-Partenkirchen
% Date:   October 20011
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------

if nargin < 3
    oname = 'Q_mean.mat';
end

if nargin < 2
    type = 'mean';
end


n = length(inames);

load(inames{1});

if isstruct(Q)
    Q_mean = [Q.NW Q.SW'; Q.SW, Q.SE];
else
    Q_mean = Q;
end


hwb    = waitbar(0,'Percentage of covariance matrices processed ...');
set(hwb,'NumberTitle','off','Name','Mean covariance matrix ')

waitbar((1)/(n))
for i = 2:n
    load(inames{i});
    
    if isstruct(Q)
        Q_mean = Q_mean + [Q.NW Q.SW'; Q.SW Q.SE];
    else
        Q_mean = Q_mean + Q;
    end
    
    clear Q
    waitbar((i)/(n))
end

tmp = Q_mean/(n^2);
clear Q_mean

Q_mean.NW = tmp(1:1891, 1:1891);
Q_mean.SW = tmp(1892:end, 1:1891);
Q_mean.SE = tmp(1892:end, 1892:end);

save(oname, 'Q_mean');
close(hwb)



