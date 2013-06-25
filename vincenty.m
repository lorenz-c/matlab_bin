function s = vincenty(theta1, theta2, dlambda, ellips);

% The function computes the distance between two points on an ellipsoid
% given by their coordinates



if nargin < 4
    ellips = 'WGS84';
end



if strcmp(ellips, 'WGS84')
    a = 6378137;         
    b = 6356752.3142;    
   	f = 1/298.257223563;    
elseif strcmp(ellips, 'GRS80')
    a = 6378137; 
    b = 6356752.3141; 
    f = 1/298.257222101;
elseif strcmp(ellips, 'Airy')
    a = 6377563.396;
    b = 6356256.909;
    f = 1/299.3249646;
elseif strcmp(ellips, 'Intl')
    a = 6378388;
    b = 6356911.946;
    f = 1/297;
elseif strcmp(ellips, 'Clarke')
    a = 6378249.145;
    b = 6356514.86955;
    f = 1/293.465;
elseif strcmp(ellips, 'GRS67')
    a = 6378160;
    b = 6356774.719;
    f = 1/298.25;
elseif strcmp(ellips, 'Bessel')
    a = 6377397.155;
    b = 6356078.963;
    f = 1/299.1528153513233;
end



U1 = atan((1-f)*tan(theta1));
U2 = atan((1-f)*tan(theta2));


lam = dlambda;
lams = 2*pi;

it = 1;

while abs(lam - lams) > 1e-12
    
    sinsig = sqrt((cos(U1)*sin(lam))^2 + (cos(U1)*sin(U2) - sin(U1)*cos(U2)*cos(lam))^2);                                        
    cossig = sin(U1)*sin(U2) + cos(U1)*cos(U2)*cos(lam);

    sig    = atan2(sinsig, cossig);

    sina   = cos(U1)*cos(U2)*sin(lam)/sinsig;

    cos2a  = 1 - sina^2;

    cos2sm = cos(sig) - 2*sin(U1)*sin(U2)/cos2a;
    C      = f/16 * cos2a * (4+f*(4-3*cos2a));
    lams   = lam;
    lam    = dlambda + (1-C)*f*sina*(sig+C*sinsig*(cos2sm + C*cossig*(-1+2*cos2sm^2)));
    it = it + 1;
    
    if it > 1000
        error('Solution does not converge...!')
        break
    end
    
end

u2  = cos2a*(a^2 - b^2)/b^2;
k1   = (sqrt(1+u2) - 1)/(sqrt(1+u2) + 1);

A = (1 + 1/4*k1^2)/(1 - k1);
B = k1*(1 - 3/8*k1^2);

dsig = B*sinsig*(cos2sm + 1/4*B*(cossig*(-1+2*cos2sm^2) - 1/6*B*cos2sm*(-3+4*sinsig^2)*(-3+4*cos2sm^2)));
s    = b*A*(sig - dsig);






    
