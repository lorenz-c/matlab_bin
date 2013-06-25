function [otpt, mn_pwr] = prep_grace(inpt, type, clms, seyrs)

% Pre-processing of GRACE-data. This function can be used to e.g. compute
% the mean over a given time-period, to remove a trend or compute the
% derivative of the GRACE coefficients. It also removes the degree
% 0/1-coefficients from the data. 
%--------------------------------------------------------------------------
% Input:        inpt      {n x m}   Cell-array containing
%                                   month/year/signal/error
%
%               type      'string'  Defines the type of preprocessing:
%                                   'mean'  -> mean is removed
%                                   'trend' -> trend is removed (TBI)
%                                   'derr'  -> derivatives are computed (TBI)
%               clms      [1 x 4]   columns in inpt containing month, year,
%                                   signal and errors
%               seyrs     [1 x 2]   start- and end-year of the considered
%                                   time-series
%                                        
% Output:       otpt      {n x 4}   pre-processed GRACE data containing
%                                   month/year/signal/error
%--------------------------------------------------------------------------
% Author: Christof Lorenz, IMK-IFU Garmisch-Partenkirchen
% Date:   October 20011
%--------------------------------------------------------------------------
% Uses: mod01.m
%--------------------------------------------------------------------------

if nargin < 4
    seyrs = [2003 2010];
end

if nargin < 3 
    clms = [5 4 9 10];
end

if nargin < 2
    type = 'mean';
end


mnth = cell2mat(inpt(:, clms(1)));
yr   = cell2mat(inpt(:, clms(2)));

s_ind = find(mnth == 1  & yr == seyrs(1));
e_ind = find(mnth == 12 & yr == seyrs(2)); 

mnth = mnth(s_ind:e_ind);
yr   = yr(s_ind:e_ind);

n = length(mnth);

signal = inpt(s_ind:e_ind, clms(3));
error  = inpt(s_ind:e_ind, clms(4));

maxdeg = size(signal{1}, 1)-1;


if strcmp(type, 'mean')
    
    mnth = cell2mat(inpt(:, clms(1)));
    yr   = cell2mat(inpt(:, clms(2)));

    s_ind = find(mnth == 1  & yr == seyrs(1));
    e_ind = find(mnth == 12 & yr == seyrs(2)); 

    mnth = mnth(s_ind:e_ind);
    yr   = yr(s_ind:e_ind);

    n = length(mnth);
    
    signal = inpt(s_ind:e_ind, clms(3));
    error  = inpt(s_ind:e_ind, clms(4));


    
    mn_sig = zeros(size(signal{1}));
    mn_err = zeros(size(error{1}));
    
    for i = 1:n
        mn_sig = mn_sig + signal{i};
        mn_err = mn_err + error{i}.^2;
    end
    
    mn_sig = mn_sig/n;
    mn_err = mn_err/(n^2);
    
    mnth = cell2mat(inpt(:, clms(1)));
    yr   = cell2mat(inpt(:, clms(2)));
    
    n = length(mnth);
    
    signal = inpt(1:end, clms(3));
    error  = inpt(1:end, clms(4));


  
    
    mn_pwr = zeros(maxdeg+1,2);
    
    for i = 1:n
        
        otpt{i,1} = mnth(i);
        otpt{i,2} = yr(i);
        tmp = signal{i} - mn_sig;
        otpt{i,3} = mod01(tmp, 'rep');
        tmp = sqrt(error{i}.^2 + mn_err);
        otpt{i,4} = mod01(tmp, 'rep');
        
        otpt{i,5} = degvar(otpt{i,3}, maxdeg, 0, 'none', 0, 0);
        otpt{i,6} = degvar(otpt{i,4}, maxdeg, 0, 'none', 0, 0);
        
        mn_pwr(:,2) = mn_pwr(:,2) + log10(otpt{i,5}(:,2));
        
        
    end
    mn_pwr(:,1) = standing(0:maxdeg);
    mn_pwr(:,2) = mn_pwr(:,2)/n;
    
    
 end

    
    
    
    
    
    