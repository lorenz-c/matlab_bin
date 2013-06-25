function corr = matrix_corr(inpt, type)

% The function computes a correlation-matrix depending on the input matrix
% inpt. The rows of this matrix are defined by different pixels while the
% column dimension corresponds to the time-steps according to the following
% example:
% inpt = [p1(t1) p1(t2) ... p1(tm);
%         p2(t1) p2(t2) ...       ;
%                   .
%                   .
%                   .
%         pn(t1) pn(t2) ... pn(tm)];
% where row i with i=1,...,n corresponds to the pixel i and column j
% represents the time-step j with j=1,...,m.
% The function allows the computation of the three widely used correlation
% coefficients according to Pearson (default), Spearman and Kendall. Due to
% their definition, the computation of the two rank correlation coefficients 
% Searman's rho and Kendall's tau are computationally demanding. 
%--------------------------------------------------------------------------
% Input:        inpt     [m x n]    input matrix with m time-series
%                                   containing n time-steps 
%               type     string     desired correlation coefficient:
%                                   'pearson'  -> Pearson's r
%                                   'spearman' -> Spearman's rho
%                                   'kendall'  -> Kendall's tau

% Output:       corr     [m x m]   Correlation matrix       
%--------------------------------------------------------------------------
% Author: Christof Lorenz, IMK-IFU Garmisch-Partenkirchen
% Date:   June 2011
%--------------------------------------------------------------------------
% Uses: tiedrank.m (for spearman and kendall, intrinsic function)
%--------------------------------------------------------------------------

if nargin < 2
    type = 'pearson';
end

if strcmp(type, 'pearson')
    % Matrix with the deviations from the mean value in each pixel
    A   = inpt - mean(inpt, 2)*ones(1, size(inpt,2));
    % Squared standard deviations
    std = sum(A.*A,2);
    % Compute the numerator
    num = A*A';
    % Compute the denominator
    den = (std*std').^(1/2);
    % Correlation is given by corr = cov(x,y)/(sqrt(var(x))*sqrt(var(y)))
    corr = num./den;

elseif strcmp(type, 'kendall')
    
    % Sort the input data in descending order and save the original indices
    [in1_srt, indx] = sort(inpt, 2, 'descend');

    % Compute the ranks of the input data
    for i = 1:size(inpt,1)
        tmp = tiedrank(inpt(i,:));
        % tiedrank.m computes the ranks in descending order but we need an
        % ascending order
        ranks(i,:) = -tmp + max(tmp) + 1;
    end
    
    corr = zeros(size(inpt,1), size(inpt,1));
    n = size(inpt,2);

    for i = 1:size(ranks,1)
        tmp = ranks(i:end, indx(i,:));
        Q = zeros(size(tmp,1), 1);
        q = zeros(size(tmp));
    
        for j = 1:size(tmp,1)
            for k = 1:size(tmp,2)
                tmp2 = zeros(1, length(tmp(j, k+1:end)));
                tmp2(tmp(j, k+1:end) <= tmp(j, k)) = 1;
                q(j, k) = sum(tmp2);
            end
        end
        Q    = sum(q,2);
        corr(i, i:end) = 1-4*Q'/(n*(n-1));
    end
    
elseif strcmp(type, 'spearman')
    

end






