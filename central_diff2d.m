function [dx, dy] = central_diff2d(inpt);
% The function computes the first derivative of a given input dataset
% according to the method of central differences.

dx = zeros(size(inpt));
dy = zeros(size(inpt));

tmp1 = [inpt(:, end) inpt(:,1:end-1)];
tmp2 = [inpt(:, 2:end) inpt(:,1)];

dx = (tmp2 - tmp1)/2;

clear tmp1 tmp2

tmp1 = inpt(1:end-2,:);
tmp2 = inpt(3:end,:);

dy(2:end-1,:) = (tmp2-tmp1)/2;

dy(1,:)   = inpt(2,:) - inpt(1,:);
dy(end,:) = inpt(end,:) - inpt(end-1,:);










