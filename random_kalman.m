% Kalman Filter - Random constant example
function [x, P, K, xs, Ps, yn] = random_kalman(R, yn)




t_v = 0.1; % True rms of the measurements
t_m = 0.5; % True constant value

Q = 1e-5;  % Process variance


x_start = 0;  % First guess: x = 0;
P_start = 1;  % initial error covariance is 1

if nargin < 1
    R = t_v^2;
end
    
if nargin < 2
    yn = t_m + t_v*randn(50,1); % Computing the observations with mean t_m 
                               % and standard deviation t_v
end
                           
for i = 1:50
    % Prediction step
    if i == 1
        xs(i) = x_start;
        Ps(i) = P_start + Q;
    else
        xs(i) = x(i-1);        % Predict the state
        Ps(i) = P(i-1) + Q;    % Predict the error covariance
    end
    
    % Correction step
    K(i) = Ps(i)/(Ps(i) + R); % Computing the Kalman gain
    x(i) = xs(i) + K(i)*(yn(i)-xs(i));
    P(i) = (1-K(i))*Ps(i);
end


    
