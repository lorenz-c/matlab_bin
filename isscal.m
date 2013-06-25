function i = isscalar(a)

% ISSCALAR(a) tests whether a is a scalar (1x1 matrix).
%     Returns 1 (true) or 0 (false).
%
% Nico Sneeuw,
% Munich, 22/07/94

i = (length(a) == 1);
