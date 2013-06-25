function i = isvector(a)

% ISVECTOR(a) tests whether a is a vector (nx1 matrix).
%     Returns 1 (true) or 0 (false).
%     Note that a scalar is considered a vector as well.
%
% Nico Sneeuw,
% Munich, 22/07/94

i = (min(size(a)) == 1);
