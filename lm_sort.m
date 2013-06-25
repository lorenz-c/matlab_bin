function Anew = lm_sort(Aold, Lmax, sor)

% This function changes the arrangement of spherical harmonic coefficients
% from degree-wise to Colombo (order-wise) and vice versa
%--------------------------------------------------------------------------
% Input:        Aold    [n x 1]   vector with spherical harmonic
%                                 coefficients
%               Lmax    [1 x 1]   maximal degree
%                                   
%               sor     [string]  defines the arrangement of the output
%                                 coefficients 
%                                 'l2m' -> Colombo
%                                 'm2l' -> degree-wise
% Output:       Anew    [n x 1]   vector with spherical harmonic
%                                 coefficients
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   September 2008
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------

if size(Aold) == [1 length(Aold)]
    Aold = Aold';
end

if strcmp(sor, 'l2m')

   Anew = zeros(size(Aold));
   start(1) = 1;
   for i = 2:Lmax+1
      start(i) = start(i-1) + i;
   end
   
   index1 = 1:Lmax+1;
   index2 = 1:-1:-Lmax+2;
   index3 = 0:-1:-Lmax+1;

   K = 1;
   H = length(start);

   for i = 1:length(start)
       k(1) = start(i);
       for j = index1(i):Lmax
           k(j+index2(i)) = k(j+index3(i))+j;
       end

       Anew(K:H) = Aold(k);
       K = K + length(start)+1-i;
       H = H + length(start)-i;
       clear k;
   end

elseif strcmp(sor, 'm2l')

   add = zeros(Lmax+1, 1);
   add(2:end) = Lmax:-1:1;
   Anew = [];
   add_(1) = add(1);
   for i = 2:length(add)
      add_(i) =  add_(i-1)+add(i);
   end
  
   for l = 1:Lmax+1
      m = 1:l; 
      Anew = [Anew; Aold(l+add_(1,m),1)];
   end

end
