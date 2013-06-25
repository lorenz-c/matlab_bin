% Ausgleichungsproblem: Schiefer Wurf
% Beispiel einer kleinste-Quadrate-Ausgleichung mit nicht-linearen
% Beobachtungsgleichungen über extended Kalman Filter
% -------------------------------------------------------------------------
% Christof Lorenz, IMK-IFU Garmisch-Partenkirchen, 2011
% -------------------------------------------------------------------------

function [xht, L, P] = trajectory_kalman2(L, R, Q, x0, P0)

% Parameter der Trajektorie
g = 9.81;             % Erdanziehung
x(1)  = 0;            % Startwert für x-Richtung
y(1)  = 0;            % Startwert für y-Richtung
vy(1) = 10;           % Startgeschw. in x-Richtung
vx    = 10;           % Startgeschw. in y-Richtung
dt    = 0.05;         % Zeitintervall 


% Berechnung der Referenztrajektorie über Bewegungsgleichung
for i = 1:40
x(i+1,1)  = x(i) + vx*dt;                    % X-Komponente der Pos. 
vy(i+1,1) = vy(i) - g*dt;                    % Geschwindigkeit in y
y(i+1,1)  = y(i) + vy(i)*dt - 1/2*g*dt^2;    % Y-Komponente der Pos.
end

% Zum Vergleich: Analytische Bestimmung der Kurve
y_ana = y(1) + vy(1)/vx*x - (g/(2*vx^2))*x.^2;

% Bestimmung von Pseudo-Beobachtungen (hier: alle Beob. gleich genau, keine
% Korrelationen)
if nargin < 1
    L = y + randn(length(y),1)/2;     
end

% Measurement noise 
if nargin < 2
    R = 1e-2;
end

% Vektor mit Näherungswerten für die Unbekannten
if nargin < 4
    x0 = [0; 9; 11];   
end
xht = x0;


% Kovarianzmatrix der Unbekannten (alle Näherungswerte gleich genau, keine
% Korrelationen)
if nargin < 5
    P0 = eye(3,3);
end

% State relation matrix (-> hier Diagonalmatrix)
A = eye(3,3);

% Kein Kontrollinput
B = zeros(3,1);
u = 0;

% Process noise
if nargin < 3
    Q = 1e-5;
end

for i = 1:length(L)
    
    % ----------------------    
    % Predictor step
    % ----------------------
    if i == 1
        x_pred = A*x0 + B*u;            % State prediction
        P_pred = A*P0*A' + Q;           % Covariance prediction
    else   
        x_pred = A*xht(:,i-1) + B*u;    % State prediction
        P_pred = A*P*A' + Q;            % Covariance prediction
    end

    
    % ----------------------    
    % Corrector step
    % ----------------------
    % Aufstellen der H-matrix mit h_ij = (dfi/dXi)|x_0
    H(1,1) = 1;                                 % Ableitung nach y_0
    H(1,2) = x(i)/x_pred(2);                    % Ableitung nach v_0y
    H(1,3) = -x_pred(2)*x(i)/(x_pred(3)^2) ...
              + g*x(i)^2/(x_pred(3)^3);         % Ableitung nach v_0x
    
    % Berechnung von h(x,0) an der Stelle x_pred (-> NICHT-linear)
    hx = x_pred(1) + x_pred(2)*x(i)/x_pred(3) - g*x(i)^2/(2*x_pred(3)^2);

    % Berechnung der Innovation
    v = L(i) - hx;
    
    % Berechnung der Innovations-Kovarianz
    if length(R) > 1               
        S = H*P_pred*H' + R(i);     
    else                            
        S = H*P_pred*H' + R;        
    end
    
    % Berechnung d. Kalman-Gains
    K = P_pred*H'*inv(S);  
    
    % Korrektor d. state u. covariance
    xht(:,i) = x_pred + K*v;       % Update state
    P = (eye(3,3) - K*H)*P_pred;   % Update covariance
end

% L_a = xht(1,1) + xht(2,1)*x/xht(3,1) - g*x.^2/(2*xht(3,1)^2);
% L_b = xht(1,10) + xht(2,10)*x/xht(3,10) - g*x.^2/(2*xht(3,10)^2);
% L_c = xht(1,end) + xht(2,end)*x/xht(3,end) - g*x.^2/(2*xht(3,end)^2);
    
keyboard   
    
    
    
    
