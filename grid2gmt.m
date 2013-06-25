function A = grid2gmt(A_old, n, Phi, Lambda)

% grid2gmt.m transforms a grid field into a format, which is readable by
% GMT. The function either transforms the whole input field (default) or
% only a particular area, defined by the corners Theta_min, Theta_max,
% Lambda_min and Lambda_max
%--------------------------------------------------------------------------
% Input:        A_old     [k x j]  180/n x 360/n matrix 
%               n         [1 x 1]  angular side length of a pixel 
%                                  (default: n = 0.5)
%               lim       [1 x 4]  optional vector with four corners, 
%                                  i.e. Theta_min, Theta_max,Lambda_min and 
%                                  Lambda_max
%
% Output:       A         [h x 3]  Matrix which can be safed as .txt file. 
%                                  The output is readable by GMT
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   8. Sep. 08
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------

[r c] = size(A_old);
max_A = r*c;

A = zeros(max_A, 3);

A(:,3) = reshape(flipud(A_old), max_A, 1);

if nargin < 2 
     n = 0.5; 
end

if nargin < 3
     Phi = -90+n/2:n:90-n/2;
     Lambda = -180+n/2:n:180;
end

k1 = ones(1, length(Phi));
k2 = ones(1, length(Lambda));
Lambda_ = Lambda'*k1;
Phi_ = Phi'*k2;

A(:,1) = reshape(Lambda_', max_A, 1);
A(:,2) = reshape(Phi_, max_A, 1);





