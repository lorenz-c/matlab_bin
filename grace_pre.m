function otpt = prep_grace(inpt, type, clms, seyrs)

% GRACE-Preprocessing function which can remove a mean field, but also
% e.g. a trend 

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

maxdeg = size(signal{1}, 1);

if strcmp(type, 'mean')
    mn_sig = zeros(size(signal{1}));
    mn_err = zeros(size(error{1}));
    
    for i = 1:n
        mn_sig = mn_sig + signal{i};
        mn_err = mn_err + error{i}.^2;
    end
    
    mn_sig = mn_sig/n;
    mn_err = mn_err/n^2;
       
    for i = 1:n
        otpt{i,1} = mnth(i);
        otpt{i,2} = yr(i);
        otpt{i,3} = signal{i} - mn_sig;
        otpt{i,4} = sqrt(error{i} + mn_err);
        otpt{i,5} = degvar(otpt{i,3}, maxdeg, 0, 'none', 0, 0);
        otpt{i,6} = degvar(otpt{i,4}, maxdeg, 0, 'none', 0, 0);
    end

    
 end

    
    
    
    
    
    