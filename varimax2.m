% [lambda,V] = varimax(lambda[,sign,tol]) Varimax rotation
%
% Performs varimax rotation (Kaiser 1958) on the column vectors contained
% in lambda. We follow Kaiser's notation.
%
% In:
%   lambda: DxL matrix (L<D) of column vectors (possibly the loadings from
%      a factor analysis).
%   sign: preferred majoritary sign for the vector components (-1:
%      negative, 1: positive, 0: don't care). Default 0.
%   tol: minimum relative increase of the objective function to keep on
%      iterating (default 1e-5).
% Out:
%   lambda: DxL matrix with the rotated loadings.
%   V: training curve for the objective function.

% Copyright (c) 1997 by Miguel A. Carreira-Perpinan

function [lambda,V] = varimax2(lambda,sign,tol)

% Argument defaults
if nargin==1 sign=0; end;
if nargin<=2 tol=1e-5; end;

[D,L] = size(lambda);

h = sqrt(sum(lambda'.^2))'+exp(-700);			% Communalities
temp=lambda./(h*ones(1,L));
V = [sum(sum(temp.^4))-sum(sum(temp.^2).^2)/D];		% Objective function

V_old = V*(1-2*tol);

while abs(V(length(V))-V_old) > tol*V(length(V))

  V_old = V(length(V));

  for i=1:L-1
    for j=i+1:L

      % Optimal angle to rotate columns i, j
      x = lambda(:,i)./h;
      y = lambda(:,j)./h;
      u = x.*x - y.*y;
      v = 2*x.*y;
      t = atan2( 2*(D*u'*v-sum(u)*sum(v)), D*(u'*u-v'*v)-sum(u)^2+sum(v)^2 )/4;

      % Anticlockwise rotation of angle t (t+pi is valid, too)
      temp = [lambda(:,i) lambda(:,j)]*[cos(t) -sin(t); sin(t) cos(t)];
      lambda(:,i) = temp(:,1);
      lambda(:,j) = temp(:,2);

    end
  end

  % New value of the objective function
  h = sqrt(sum(lambda'.^2))'+exp(-700);			% Communalities
  temp=lambda./(h*ones(1,L));
  V = [V sum(sum(temp.^4))-sum(sum(temp.^2).^2)/D];	% Objective function

end

% Sign inversion so that each column vector of lambda has mainly
% components of the same sign
if sign>0
  for i=1:L
    if sum(lambda(:,i)) < 0
      lambda(:,i) = -lambda(:,i);
    end
  end
elseif sign<0
    for i=1:L
    if sum(lambda(:,i)) > 0
      lambda(:,i) = -lambda(:,i);
    end
  end
end
