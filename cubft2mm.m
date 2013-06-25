function R = cubft2mm(inpt, area)

% 1 foot = 0.000189393939 miles
% 
% 
% area = area 
% 
% A = inpt*2446.58;    % -> Cubic meters per day
% B = A./area;      % -> m/day

% Convert drainage are to square feet
A = area*27878400;

% Cubic feet per second -> cubic feet per day
B = 86400;

% Combine A and B
C = B/A;
C = C*12*25.4;

R = inpt.*C;




