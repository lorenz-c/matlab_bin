function iia = isinteger(a,tol)

% ISINTEGER checks whether the elements of a matrix are integer. 
%    Returns a mask, which can be used as a single Boolean, in the sense that 
%    IIA is true when IIA = ones(size(A)). Otherwise IIA is false.
%
%    IIA = ISINTEGER(A)         - strong form
%    IIA = ISINTEGER(A,tol)     - weak form
%
% See also FLUSHINT
%    
% Nico Sneeuw                  Munich                   02/05/94

% rev. 15/01/97: definitions changed. Functionality still the same

if nargin == 1
   iia = ~rem(a,1);
else
   iia = abs(round(a)-a) < tol;
end
