function otpt = xy2gmt(y, x, scle);

if nargin < 2
    x(:,1) = 1:1:length(y);
end

if size(y,2) > 1
    y = y';
end

otpt = [x y ones(length(x),1)*scle];

