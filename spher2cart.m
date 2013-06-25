function X = spher2cart(L, B, H);


% Parameter des WGS84
a = 6378137;           % große Halbachse
b = 6356752.314;       % kleine Halbachse

% Querkrümmungshalbmesser
N = a^2/sqrt(a^2*(cos(B*pi/180))^2 + b^2*(sin(B*pi/180))^2);

% Koordinaten im kart. Koordinatensystem
X = [(N+H)*cos(B*pi/180)*cos(L*pi/180);
     (N+H)*cos(B*pi/180)*sin(L*pi/180);
     N*sin(B*pi/180)*b^2/a^2 + H*sin(B*pi/180)];
 
 
     
