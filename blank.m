function [ordb, abcb] = blank(ord, abc, M)
% assuming ord is depth, positive downward.
% abc is like time or latitude.
[nr, nc] = size(M);

[abc, ii] = sort(abc);
M = M(:,ii);

% dord and dabc are used to push the polygon out a bit, to
% avoid unwanted blanking due to roundoff.
dord = min(abs(diff(ord(:))))*0.01;
% assuming ord is depth, positive downward.
% abc is increasing; it has been sorted.
dabc = min(abs(diff(abc(:))))*0.01;

ORD = ord(:,ones(nc,1));
badmask = isnan(M);

ORD(badmask) = NaN;
ordmax = max(ORD) + dord;
ordmin = min(ORD) - dord;

ii = isnan(ordmax);
ordmax(ii) = max(ordmin);
ordmin(ii) = ordmax(ii)-dord;

ordmax(2:(end-1)) = max([ ordmax(1:(end-2)); ordmax(2:(end-1)); ordmax(3:end)]);
ordmin(2:(end-1)) = min([ ordmin(1:(end-2)); ordmin(2:(end-1)); ordmin(3:end)]);

abc(1) = abc(1) - dabc;
abc(end) = abc(end) + dabc;

ordb = [ordmax ordmin(end:-1:1) ordmax(1)];
abcb = [abc       abc(end:-1:1) abc(1)];

