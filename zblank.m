function z = zblank(x,y,xp,yp)

% Interface to the mex file polymx.c
% This is a primitive version, with no argument checking.
% Its main purpose is to be sure polymx gets monotonically
% increasing x and y, as required.  It also converts the
% zeros and ones to Nans and zeros, respectively.  This
% functionality could, of course, be added to polymx.c;
% but it is fast enough this way.

if (isempty(xp))
   z = zeros(length(x), length(y));
   return
end

rev_x = 0;
if diff(x(1:2)) < 0,
   rev_x = 1;
   x = x(end:-1:1);
end
rev_y = 0;
if diff(y(1:2)) < 0,
   rev_y = 1;
   y = y(end:-1:1);
end

z = polymx(x,y,xp,yp);

   imask = (z == 0);
   z(find(imask)) = NaN;
   z(find(~imask)) = 0;


if rev_x,
   z = z(end:-1:1,:);
end

if rev_y,
   z = z(:,end:-1:1);
end