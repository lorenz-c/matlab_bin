function [] = adjustment_theory_example 


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

% Bestimmung von Pseudo-Beobachtungen 
L = y + randn(length(y),1)/2;

% Kovarianzmatrix der Unbekannten
% 1. Annahme: alle Beobachtungen gleich genau -> Diagonalmatrix
P = eye(length(L), length(L));

% Vektor mit Näherungswerten für die Unbekannten
x0 = [0; 9; 11];
xht = x0;


% Berechnung des Vektors der Näherungswerte der Messwerte
% ("Näherungsbeobachtungen")
L_approx = xht(1) + xht(2)/xht(3)*x - g/(2*xht(3)^2)*x.^2;
L_0 = L_approx;

% Berechnung des Absolutgliedvektors
l   = L - L_0;


% Festlegung von Schleifenvariablen
crit = 1;
k = 1;


while crit == 1
    
    % Aufstellen der A-matrix mit a_ij = (dfi/dXi)|x_0
    A(:,1) = ones(size(L,1),1);                      % Ableitung nach y_0
    A(:,2) = x'./xht(2);                             % Ableitung nach v_0y
    A(:,3) = -xht(2)*x'/xht(3)^2 + g/xht(3)^3*x'.^2; % Ableitung nach v_0x
    
    % Berechnugn des Vektors der Unbekannten (Nicht-linear -> lediglich
    % Zuschläge!!!)
    dx = inv(A'P*A)*A'P*l;
    
    % Berechnung der Verbesserungen 
    v  = A*dx - l;
    
    % Kofaktorenmatrix der ausgegl. Parameter
    Qxx = A'*P*A;
    
    % Berechnung der endgültigen Parameter: Näherunswerte + Zuschläge
    xht = xht + dx;
    
    % Vektor der ausgeglichenen Messwerte (in der nächsten Iteration ->
    % Näherungsbeobachtungen)
    L_0 = A*dx + L_0;
    
    % Berechnung des Absolutgliedvektors für die nächste Iteration
    l   = L - L_0;
    
    % Überprüfen des Abbruchkriteriums (falls Zuschläge klein genug sind)
    if norm(dx) < 1e-10
        crit = 0;
    end
    
    % Falls Lösungen nicht konvergieren (z.B. schlecht gewählte
    % Näherungswerte) -> Schleifenabbruch
    k = k + 1
    if k == 100
        crit = 0;
        sprintf('Lösung konvergiert nicht!')
    end
    
end
keyboard
    
    
    
    
    
    
% function [x_ht, x_p, P] = kalman_falling_body(true_vals, obs, x0, P0, Q, R) 
% 
% g = 9.81;
% 
% 
% 
% A = [1 dt 0 0 ;
%      0 1  0 0 ;
%      0 0  1 dt;
%      0 0  0 1];
% 
% B = [0; 0; dt^2/2; dt];
% u = -g;
%  
% H = [0 0 1 0];


 

% plot(true_vals, 'k', 'linewidth', 1.5);
% hold on
% plot(obs, 'b+', 'linewidth', 1.5);
% 
% 
% 
% 
% A = [1 1; 0 1];
% B = [0.5; 1];
% H = [1 0];
% 
% u = -9.81;
% 
% % initial values:
% x_ht(:,1) = x0;
% 
% 
% 
% for i = 1:length(obs)
%     
%     % Prediction step
%     if i == 1
%         x_pred = A*x0 + B*u;
%         P_pred = A*P0*A' + Q;
%     else   
%         x_pred = A*x_ht(:,i-1) + B*u;   % State prediction
%         P_pred = A*P*A' + Q;            % Covariance prediction
%     end
%     
%     x_p(:,i) = x_pred;
%     
%     % Corrector step
%     v         = obs(i) - H*x_pred;           % Innovation
%     
%     if length(R) > 1                         % Innovation covariance
%         S     = H*P_pred*H' + R(i);          % constant obs. error
%     else                                     % Innovation covariance
%         S     = H*P_pred*H' + R;             % changing obs. error
%     end
%     
%     K         = P_pred*H'*inv(S);            % Kalman Gain
%     x_ht(:,i) = x_pred + K*v;                % Update state
%     P         = ([1 0; 0 1] - K*H)*P_pred;   % Update covariance
%     
% 
% end
% 
% % keyboard
    
    
    

