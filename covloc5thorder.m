
function [D, Rho] = covloc5thorder(long, lat, l)


R   = 6371;
rho = pi/180;
c   = sqrt(10/3)*l;


long = long*rho;
lat  = lat*rho;

for i = 1:length(long)
    for j = 1:length(long)
            dphi = abs(lat(i) - lat(j));
            dlam = abs(long(i) - long(j));
            
            tmp   = sin(dphi/2)^2 + cos(lat(i))*cos(lat(j)).*sin(dlam/2)^2;
            tmp   = 2*atan2(sqrt(tmp), sqrt(1-tmp));
            D(i,j) = R*tmp;
            
            b = D(i,j)/c;

            if D(i,j) >= 0 && D(i,j) <= c
                Rho(i,j) = -1/4*b^5 + 1/2*b^4 + 5/8*b^3 - 5/3*b^2 + 1;
            elseif D(i,j) > c && D(i,j) <= 2*c
                Rho(i,j) = 1/12*b^5 - 1/2*b^4 + 5/8*b^3 + 5/3*b^2 -5*b + 4 - 2/3*(1/b);
            elseif D(i,j) > 2*c
                Rho(i,j) = 0;
            end
            
            
            
    end
end




%             
% a = sin(dlat/2)^2 + cos(theta1)*cos(theta2)*sin(dlambda/2)^2;
% c = 2*atan2(sqrt(a), sqrt(1-a));
% s = R*c;            

        
