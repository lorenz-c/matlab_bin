% Ausgleichungsproblem: Schiefer Wurf
% Beispiel eines Kalman Filters
% -------------------------------------------------------------------------
% Christof Lorenz, IMK-IFU Garmisch-Partenkirchen, 2011
% -------------------------------------------------------------------------
function [xht, L, P] = trajectory_kalman1(L, R, Q, x0, P0);

clc

% Parameter der Trajektorie
g = 9.81;             % Erdanziehung
x(1)  = 0;            % Startwert für x-Richtung
y(1)  = 0;            % Startwert für y-Richtung
vy(1) = 10;           % Startgeschw. in x-Richtung
vx    = 10;           % Startgeschw. in y-Richtung
dt    = 0.05;         % Zeitintervall 


% Berechnung der Referenztrajektorie
for i = 1:40
x(i+1,1)  = x(i) + vx*dt;
vy(i+1,1) = vy(i) - g*dt;
y(i+1,1)  = y(i) + vy(i)*dt - 1/2*g*dt^2;
end

% Zum Vergleich: Analytische Bestimmung der Kurve
y_ana = y(1) + vy(1)/vx*x - (g/(2*vx^2))*x.^2;

% Bestimmung von Pseudo-Beobachtungen u. der dazugehörigen Fehler
if nargin < 1
    L = y + randn(length(y),1)/2;
end

if nargin < 2
    R = 	0.01;              % Hier: Fehler konstant für alle Messungen
end

A = [1 dt; 0 1];       % Time-relation matrix
B = [0.5*dt; 1];       % Control-input matrix
H = [1 0];             % Observation-relation matrix
u = -g*dt;  

% Anfangswerte
if nargin < 4
    x0 = [0; 5];
end

% Process noise (wird hier als gering angenommen)
if nargin < 3
    Q  = 1e-5;
end
% Process covariance (Anfangswerte gleich genau und nicht korreliert)
if nargin < 5
    P0 = eye(2,2);
end
% Intitialisierung des Lösungsverktors
xht = zeros(2,1);

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
    x_p(:,i)   = x_pred;                % Saving the prediciton
    
    % ----------------------    
    % Corrector step
    % ----------------------
    v          = L(i) - H*x_pred;       % Innovation
    
    if length(R) > 1                    % Innovation covariance
        S      = H*P_pred*H' + R(i);    % constant obs. error
    else                                % Innovation covariance
        S      = H*P_pred*H' + R;       % changing obs. error
    end
    
    K           = P_pred*H'*inv(S);            % Kalman Gain
    xht(1:2,i)  = x_pred + K*v;                % Update state
    P           = ([1 0; 0 1] - K*H)*P_pred;   % Update covariance
 
end





keyboard





















