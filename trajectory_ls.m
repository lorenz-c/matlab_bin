% Ausgleichungsproblem: Schiefer Wurf
% Beispiel einer kleinste-Quadrate-Ausgleichung mit nicht-linearen
% Beobachtungsgleichungen
% -------------------------------------------------------------------------
% Christof Lorenz, IMK-IFU Garmisch-Partenkirchen, 2011
% -------------------------------------------------------------------------
function [xht, Qxx, L, L_0] = trajectory_ls(L, P, x0);

% Parameter der Trajektorie
g = 9.81;             % Erdanziehung
x(1)  = 0;            % Startwert für x-Richtung
y(1)  = 0;            % Startwert für y-Richtung
vy(1) = 10;           % Startgeschw. in x-Richtung
vx    = 10;           % Startgeschw. in y-Richtung
dt    = 0.05;         % Zeitintervall 

%  -0.3661
%  10.2422
%   9.5049


% Berechnung der Referenztrajektorie
for i = 1:40
x(i+1,1)  = x(i) + vx*dt;
vy(i+1,1) = vy(i) - g*dt;
y(i+1,1)  = y(i) + vy(i)*dt - 1/2*g*dt^2;
end

% Zum Vergleich: Analytische Bestimmung der Kurve
y_ana = y(1) + vy(1)/vx*x - (g/(2*vx^2))*x.^2;

% Bestimmung von Pseudo-Beobachtungen 
if nargin < 1
    L = y + randn(length(y),1)/2;
end

% Kovarianzmatrix der Unbekannten
% 1. Annahme: alle Beobachtungen gleich genau -> Diagonalmatrix
if nargin < 2
    P = eye(length(L), length(L));
end

% Vektor mit Näherungswerten für die Unbekannten
if nargin < 3
x0 = [0; 9; 11];
end

xht = x0;


% Berechnung des Vektors der Näherungswerte der Messwerte
% ("Näherungsbeobachtungen")
L_approx = xht(1) + xht(2)/xht(3)*x - g/(2*xht(3)^2)*x.^2;
L_0 = L_approx;

% Berechnung des gekürzten Beobachtungsvektors
l   = L - L_0;

% Festlegung von Schleifenvariablen
crit = 1;
k = 0;


while crit == 1
    
    k = k + 1;
    
    % Aufstellen der A-matrix mit a_ij = (dfi/dXi)|x_0
    A(:,1) = ones(size(L,1),1);                      % Ableitung nach y_0
    A(:,2) = x'./xht(2);                             % Ableitung nach v_0y
    A(:,3) = -xht(2)*x'/xht(3)^2 + g/xht(3)^3*x'.^2; % Ableitung nach v_0x
    
    % Berechnugn des Vektors der Unbekannten (Nicht-linear -> lediglich
    % Zuschläge!!!)
    dx = inv(A'*P*A)*A'*P*l;
    
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
    if norm(dx) < 1e-15
        crit = 0;
        sprintf('Lösung konvergiert nach %d Iterationen.', k)
    end
    
    % Falls Lösungen nicht konvergieren (z.B. schlecht gewählte
    % Näherungswerte) -> Schleifenabbruch
    if k == 100
        crit = 0;
        sprintf('Lösung konvergiert nicht!')
    end
    
end

 keyboard   
    
    


