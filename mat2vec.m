function Q_ = mat2vec(Q)

% mat2vec.m transforms a matrix in the c\s or s|c -format into a Colombo 
% ordered vector
%--------------------------------------------------------------------------
% Input:        Q         [n x n]     matrix in c\s format 
%               
%
% Output:       Q_        [n^2 x 1]   Colombo ordered vector
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   8. Sep. 08
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------
% Updates: - 11.10.2011: Removed the for-loops, added support for
%                           s|c-format (CL)

[r, c] = size(Q);
lmx    = r - 1;

Qclm = [];
Qslm = [];

if r == c                                 % Input dataset is in c\s-format
   
    Qclm = tril(Q, 0) + triu(ones(r,c),1)*-9999;
    Qslm = (triu(Q, 1) + tril(ones(r,c),0)*-9999)';   
    
elseif r == (c-1)/2 + 1                   % Input dataset is in s|c-format 
    
    Qclm = tril(Q(:, lmx+1:end), 0) + triu(ones(r,lmx+1),1)*-9999;
    Qslm = tril(fliplr(Q(:, 1:lmx)), -1) + triu(ones(r,lmx),0)*-9999;
    
end


Q_ = [Qclm(Qclm ~= -9999); Qslm(Qslm ~= -9999)];


