function [nudat,xg,yg] = regrid(olddat,oldlat,oldz,nulat,nuz,del,nrng)
% newdat = regrid(olddat, oldx, oldy, newx, newy, del, nrng)
%
% this function regrids olddat with corresponding x and y (ordinate and
% abcissa, respectively) onto a new grid newx and newy.  This function uses 
% the zgrid program which resides in this same directory. Try 'help zgrid'
% with this directory on your path to learn more about the many features of 
% zgrid (not to be confused with matlab's own 'zgrid').
% Values for del and nrng
%   del     :     d << 1 to interpolate mainly in x
%           :     suggest .1 for adcp data and 10 for ctd data 
%  nrng     :     interpolate/extrapolate no more than
%           :         nrng grid points away from a data point
%           :     suggest 3 for adcp data
%
% example from adcpsect output.  Note sizes:
% data      (NO x NA)
% abcissa   (1  x NA)        new abcissa (1 x NEWA)
% ordinate  (NO x  1)        new ordinate(NEWO x 1)
%
%  u = regrid(uv(:,1:2:end),xyt(2,:),zc,lat,zc,1,3);
% 
%
%



if nargin<7
 nrng=2;
end

[xb, yb] = blank(oldz, oldlat, olddat);

[zg,xg,yg,zb]=zgrid(oldz,oldlat,olddat,nuz,nulat,...
                    'cay',1,'del',del,'nrng',nrng,xb,yb);

nudat = zg;

%------------------------------
function [xb, yb] = blank(x, y, Z)
[nr, nc] = size(Z);

[y, ii] = sort(y);
Z = Z(:,ii);

% dx and dy are used to push the polygon out a bit, to
% avoid unwanted blanking due to roundoff.
dx = min(abs(diff(x(:))))*0.01;
% assuming x is depth, positive downward.
% y is increasing; it has been sorted.
dy = min(abs(diff(y(:))))*0.01;

X = x(:,ones(nc,1));
badmask = isnan(Z);

X(badmask) = NaN;
xmax = max(X) + dx;
xmin = min(X) - dx;

ii = isnan(xmax);
xmax(ii) = max(xmin);
xmin(ii) = xmax(ii)-dx;

xmax(2:(end-1)) = max([ xmax(1:(end-2)); xmax(2:(end-1)); xmax(3:end)]);
xmin(2:(end-1)) = min([ xmin(1:(end-2)); xmin(2:(end-1)); xmin(3:end)]);

y(1) = y(1) - dy;
y(end) = y(end) + dy;

xb = [xmax xmin(end:-1:1) xmax(1)];
yb = [y       y(end:-1:1) y(1)];
