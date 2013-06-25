function [ ] = prep_grace_cov(inames, type, Q_mean, onames)

% Pre-processing of GRACE-covariance matrices. This function can be used 
% to e.g. compute the mean over a given time-period or compute the
% derivative of the GRACE coefficients. The mean is computed according to
% the laws of error propagation
%--------------------------------------------------------------------------
% Input:        fnames    'cell'    List of filenames which should be
%                                   loaded and preprocessed.
%
%               type      'string'  Defines the type of preprocessing:
%                                   'mean'  -> mean is removed
%                                   'derr'  -> derivatives are computed (TBI)
%                                        
% Output:       otpt      {n x 4}   pre-processed GRACE data containing
%                                   month/year/signal/error
%--------------------------------------------------------------------------
% Author: Christof Lorenz, IMK-IFU Garmisch-Partenkirchen
% Date:   October 20011
%--------------------------------------------------------------------------
% Uses: mod01.m
%--------------------------------------------------------------------------

if nargin < 2
    type = 'mean';
end


n = length(inames);

load(Q_mean);

if isstruct(Q_mean)
    Q_mean = [Q_mean.NW Q_mean.SW'; Q_mean.SW Q_mean.SE];
end

hwb    = waitbar(0,'Percentage of covariance matrices processed ...');
set(hwb,'NumberTitle','off','Name','Covariance preprocessing ')

for i = 1:n
    
    load(inames{i});
    
    if isstruct(Q)
        Qn = [Q.NW Q.SW'; Q.SW Q.SE] + Q_mean;
    else
        Qn = Q + Q_mean;
    end
    
    clear Q
    
    Q.NW = Qn(1:1891, 1:1891);
    Q.SW = Qn(1892:end, 1:1891);
    Q.SE = Qn(1892:end, 1892:end);
    
    save(onames{i}, 'Q');
    
    waitbar((i)/(n))
    
end

close(hwb)
    
    
    
    
   