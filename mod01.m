function K_ = mod01(K, tpe, coeff)

% MOD01 removes or adds c00, c10, c11 and s11 coefficients from a 
% given input K which can be a vector or a matrix with its elements being 
% arranged orderwise. If c00, c10, c11 and s11 should be added the function
% defines them to be = 0 by default. Otherwise, the coefficients can be
% defined manually by adding the 'coeff'-parameter, which should be a 
% [1x4]-vector (coeff = [c00 c10 c11 s11]).
%
% K_ = mod01(K,tpe)
% K_ = mod01(K,tpe,coeff)
% 
% Input:        K   [n x m]      input data
%               tpe [str]        string variable which defines what
%                                the function should do:
%                                - 'rem' -> Removes the c00, c10, c11 and 
%                                           s11 coefficients
%                                - 'add' -> adds zeros (or the values in the 
%                                           coeff-variable) as c00, c10, c11 
%                                           and s11 coefficients
%                                - 'rep' -> replaces the c00, c10, c11 
%                                           and s11 coefficients with the
%                                           zeros or the values in the
%                                           coeff-variable
%               coeff [4 x 1]    optional vector with c00, c10, c11 and s11 
%                                coefficients
%
% Output:       K_  [u x v]      output data
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   4.12.2008
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------


if nargin < 3
    coeff = 0;
end

s = size(K);

if strcmp(tpe, 'rem')
    if  s(1,2) == 1  
        Lmax = sqrt(s(1,1))-1;
        format = 1;
    elseif s(1,1) == 1             
        K = K';
        Lmax = sqrt(s(1,1))-1;
        format = 2;
    elseif s(1,1) == s(1,2) && s(1,1) > 1
        Lmax = sqrt(s(1,1))-1;
        format = 3;
    elseif s(1,1) ~= s(1,2) && s(1,1) > 1 && s(1,2) > 1  
        Lmax = sqrt(s(1,2))-1;
        format = 4;
    else error('Input has an unknown input format')
    end

    % Determination of the elements before and after the c00, c10, c11 and c20
    % coefficients
    a = Lmax+1; 
    b = Lmax+3;
    c = sum(1:a);
    d = c+2;

    % Removing the coefficients and rearranging the input data
    if format == 1 || format == 2
        K_ = [K(3:a); K(b:c); K(d:end)];
        if format == 2
            K_ = K_';
        end
    elseif format == 3
        K_ = [K(3:a,   3:a) K(3:a, b:c)   K(3:a, d:end);
              K(b:c,   3:a) K(b:c, b:c)   K(b:c, d:end);
              K(d:end, 3:a) K(d:end, b:c) K(d:end,d:end)];
    elseif format == 4
        K_ = [K(:, 3:a) K(:, b:c) K(:, d:end)];
    end

elseif strcmp(tpe, 'add')
    if  s(1,2) == 1 
        Lmax = sqrt(s(1,1) + 4) - 1;
        K = K';
        format = 1;
    elseif s(1,1) == 1                                        
        Lmax = sqrt(s(1,1) + 4) - 1;
        format = 2;
    elseif s(1,1) == s(1,2) && s(1,1) > 1                 
        Lmax = sqrt(s(1,1) + 4) - 1;
        format = 3;
    elseif s(1,1) ~= s(1,2) && s(1,1) > 1
        Lmax = sqrt(s(1,2) + 4) - 1;
        format = 4;
    else error('Input has an unknown input format')
    end
    
    a = Lmax + 1; 
    b = Lmax + 3;
    c = sum(1:a);
    d = Lmax - 1;
    
    if format == 1 || format == 2 || format == 4
        if format == 1 || format == 2
            K_ = zeros(1, (Lmax+1)^2);
        else
            K_ = zeros(s(1), (Lmax+1)^2);
        end
        
        if coeff
            K_(:, 1:2)      = coeff(1:2);
            K_(:, a+1) = coeff(3);
            K_(:, c+1)    = coeff(4);
        end
        
        K_(:, 3:a) = K(:, 1:a-2);
        K_(:, b:c) = K(:, a-1:c-3);
        K_(:, c+2:end) = K(:, c-2:end);
        
        if format == 1
            K_ = K_';
        end
        
    elseif format == 3  
        K_ = zeros((Lmax+1)^2, (Lmax+1)^2);
        K_(3:a,     3:a)      = K(1:d,       1:d);
        K_(b:c,     3:a)      = K(Lmax:c-3,  1:d);
        K_(c+2:end, 3:a)      = K(c-2:end,   1:d);

        K_(3:a,     b:c)      = K(1:d,       Lmax:c-3);
        K_(b:c,     b:c)      = K(Lmax:c-3,  Lmax:c-3);
        K_(c+2:end, b:c)      = K(c-2:end,   Lmax:c-3);

        K_(3:a,     c+2:end)  = K(1:d,       c-2:end);
        K_(b:c,     c+2:end)  = K(Lmax:c-3,  c-2:end);
        K_(c+2:end, c+2:end)  = K(c-2:end,   c-2:end);
    end

elseif strcmp(tpe, 'rep')
    if  s(1,2) == 1  
        Lmax = sqrt(s(1,1))-1;
        format = 1;
    elseif s(1,1) == 1 
        K = K';
        Lmax = sqrt(s(1,1))-1;
        format = 2;
    elseif s(1,1) == s(1,2) && s(1,1) > 1 && s(1) > 500  
        Lmax = sqrt(s(1,1))-1;
        format = 3;
    elseif s(1,1) ~= s(1,2) && s(1,1) > 1 && s(1,2) > 1  && 2*s(1,1) ~= s(1,2)+1
        Lmax = sqrt(s(1,2))-1;
        format = 4;
    elseif s(1,1) == s(1,2) && s(1,1) > 1 && s(1) < 501
        Lmax = s(1) - 1;
        format = 5;
    elseif 2*s(1,1) == s(1,2)+1
         Lmax = s(1) - 1;
         format = 6;
    else error('Input has an unknown input format')
    end
    
    a = Lmax + 2; 
    b = sum(1:a)+1;

    if coeff == 0
        coeff = [0 0 0 0];
    end
    
    if format == 1 || format == 2
        K_(1:2) = coeff(1:2);
        K_(a) = coeff(3);
        K_(b) = coeff(4);
        
        if format == 2
            K_ = K_';
        end
        
    elseif format == 3
        K_ = K;
        tmp = zeros((Lmax+1)^2, 1);
        K_(1:2, :) = [tmp'; tmp'];
        K_(:, 1:2) = [tmp tmp];
        K_(:, a)   = tmp;
        K_(a, :)   = tmp';
        K_(:, b) = tmp;
        K_(b, :) = tmp';
    elseif format == 4
        K_ = K;
        tmp = zeros((Lmax+1)^2, 1);
        K_(:, 1:2) = [tmp tmp];
        K_(:, a) = tmp;
        K_(:, b) = tmp;
    elseif format == 5
        K_ = K;
        K_(1:2, 1:2) = [coeff(1) coeff(4); coeff(2) coeff(3)];
    elseif format == 6
        K_ = K;
        K_(1, a-1) = coeff(1);
        K_(2, a-2:a) = coeff(2:4);
    end
end

    
    
    
