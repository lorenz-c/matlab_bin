function [Zg, Xo, Yo, Zb] = zgrid(xi, yi, zi, xo, yo, varargin)
% function [Zg, Xo, Yo, Zb] = zgrid(xi, yi, zi, xo, yo, varargin)
%
% Inputs:   xi, yi are vectors or matrices with (x,y) coordinates.
%           zi is "elevation" at (x,y).
%                  xi, yi, zi can all have the same dimensions,
%                  or if zi is a matrix, xi can be the x values of
%                  the row dimension, yi the y values of the column
%                  dimension.  (i.e., x corresponds to the first
%                  index of zi, y to the second.)
%            xo, yo are (1) vectors defining UNIFORM new grids in the
%                  x and y directions.  Uniformity is not checked,
%                  but the results will not be correct without it.
%                  (2) Either may instead be scalar, in
%                  which case it will be the target number of
%                  segments into which the original grid, xi
%                  or yi, will be divided by the "stretch.m"
%                  routine.  xi or yi must in that case be a
%                  vector with the row or column dimension of
%                  zi.  Additional parameters for stretch
%                  may then be given as follows.
%            varargin represents any or all of several optional
%                  argument pairs:
%            1) stretch arguments:
%            'nsegmin', n  min number of segments; default
%                          2, min is 1
%            'nsegmax', n  max number of segments in initial
%                          segmentation; actual max may exceed this
%                          locally; default is the same as
%                          the target.
%            'dyfrac', d   maximum relative change in grid
%                          spacing.  Number of segments is increased
%                          locally until the relative change is below
%                          this.  Default 0.5.
%            2) zgridmx arguments:
%            'cay', c      c = 0 for Laplacian, c >> 1 for pure spline
%            'del', d      d << 1 to interpolate mainly in x
%            'nrng', n     interpolate/extrapolate no more than
%                                nrng grid points away from a data point
%            bpx, bpy      vectors with x, y coordinates of vertices
%                                of a CLOSED blanking polygon; grid
%                                points OUTSIDE the polygon will be NaN
%                                on output
% Outputs:   Zg is the matrix of zi gridded on xo and yo.
%                  It is NaN beyond "nrng" or the blanking polygon.
%            Xo, Yo are a matrices with the same dimensions as Zg,
%                  giving the x, y coordinates of the grid.
%            Zb is an array of the same dimensions with 0 in the
%                  unblanked region, NaN where the grid is blanked.
%

%
% (Matlab 5 only)
% This is a shell for the zgridmx.c mex file, which in turn is a
% C translation of Roger Lukas's Fortran zgrid routine as taken
% from the UH Fortran contour program.
%
%  Eric Firing, 97/04/26
%

% defaults:
cay = 1;
del = 1;
nrng = 3;
bpx = [];
bpy = [];
nsegmin = 1;
dyfrac = 0.5;
nsegmax = 0;  % dummy default; actual is set based on input

% use while loop; it is more flexible in case we don't have
% arguments always in pairs.
i = 1;
while i < length(varargin) % less than, because all args come in pairs
   arg = varargin{i};
   arg1 = varargin{i+1};
   if isstr(arg)
      if strcmp(arg, 'cay')
         cay = arg1;
      elseif strcmp(arg, 'del')
         del = arg1;
      elseif strcmp(arg, 'nrng')
         nrng = arg1;
      elseif strcmp(arg, 'nsegmin')
         nsegmin = arg1;
      elseif strcmp(arg, 'nsegmax')
         nsegmax = arg1;
      elseif strcmp(arg, 'dyfrac')
         dyfrac = arg1;
      else
         error(['Unrecognized string input argument: ' arg]);
      end
   else
      bpx = arg;
      bpy = arg1;
   end
   i = i + 2;
end
if i ~= length(varargin)+1
   error('There is a leftover argument or a missing argument');
end


[mxi, nxi] = size(xi);
[myi, nyi] = size(yi);
[mzi, nzi] = size(zi);

lxi = mxi*nxi;
lyi = myi*nyi;
lzi = mzi*nzi;

if (lxi ~= lzi | lyi ~= lzi)
   if (mzi ~= nzi & lyi == mzi & lxi == nzi)
      disp('Warning: swapping x and y to fit dimensions of z')
      xsave = xi;
      xi = yi;
      yi = xsave;
      lyi = length(yi);
      lxi = length(xi);
      clear xsave;
   end
   xi = xi(:);
   xi = xi(:,ones(nzi,1));
   yi = yi(:).';
   yi = yi(ones(mzi,1),:);
end
if (~(length(xi(:)) == lzi &  length(yi(:)) == lzi))
   error('dimension mismatch among xi, yi, zi')
end


xo = xo(:);     % column
nxo = length(xo);
if nxo == 1,
   if (size(xi,1) ~= mzi)
      error('length of xi must match row dimension of zi');
   end
   nsegmed = xo;
   nsegmax = max([nsegmax nsegmed]);
   [xo, ixo] = stretch(xi(:,1), nsegmed, nsegmin, nsegmax, dyfrac);
   ixo = ixo(:);
   xi = ixo(:,ones(nzi,1));
   dx = 1;
   xo1 = 1;
   nxo = length(xo);
else
   dx = diff(xo([1 2]));
   xo1 = xo(1);
end

yo = yo(:).';  % row
nyo = length(yo);
if nyo == 1,
   if (size(yi,2) ~= nzi)
      error('length of yi must match column dimension of zi');
   end
   nsegmed = yo;
   nsegmax = max([nsegmax nsegmed]);
   [yo, iyo] = stretch(yi(1,:), nsegmed, nsegmin, nsegmax, dyfrac);
   yi = iyo(ones(mzi,1),:);
   dy = 1;
   yo1 = 1;
   nyo = length(yo);
else
   dy = diff(yo([1 2]));
   yo1 = yo(1);
end

Xo = xo(:,ones(1,nyo));
Yo = yo(ones(1,nxo),:);

Zb = zblank(xo, yo, bpx, bpy);

ii = find(~isnan(zi));
Zg = zgridmx(Zb, xi(ii), yi(ii), zi(ii), xo1, yo1, dx, dy, del, cay, nrng, 1);