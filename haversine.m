function s = haversine(theta1, theta2, dlambda)

R = 6378137;

dlat = abs(theta1 - theta2);

a = sin(dlat/2)^2 + cos(theta1)*cos(theta2)*sin(dlambda/2)^2;
c = 2*atan2(sqrt(a), sqrt(1-a));
s = R*c;

