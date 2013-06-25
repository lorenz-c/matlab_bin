function [Y, P, AB, f] = fftspec(x, Fs);
% The function performs a simple FFT Spectral Analysis
% -------------------------------------------------------------------------
%                Parcevals theorem: sum(x.^2) = Fs*sum(P)
% -------------------------------------------------------------------------

% Length of the time-series
n = size(x,1);

% Compute the FFT. Note that NO zero-padding is performed!!!
fftx = fft(x);

% If n is even then the magnitude of the fft will be symmetric, the first 
% (n/2 + 1) points are unique while the rest are symmetrically redundant.
% The (n/2 + 1)th component is the Nyquist frequency component and the
% first element is the DC component. If n is odd, however, the Nyquist
% frequency component is not evaluated, and the number of unique points is
% (n + 1)/2 . 

% Calculate the number of unique points
NumUniquePts = fix((n+2)/2);

% FFT is symmetric -> throw away second half
fftx = fftx(1:NumUniquePts, :);

% Obtain the a and b values seperately
a = (fftx + conj(fftx)) / (n);               
b = 1i * (fftx - conj(fftx)) / (n);    

% As we threw away the redundant half of the spectrum, we have to multiply
% both a and b by 2 to maintain the same energy However, this is usually 
% not done for the DC (and the Nyquist) component of the FFT.
 
% Odd nfft -> a(1) = DC, no Nyquist component
a(1,:) = a(1,:) / 2;

% Compute the amplitude spectrum 
Y = abs(fftx)/n;
Y = [Y(1, :); 2*Y(2:end, :)];

% Compute the Periodogram
P = abs(fftx).^2/(Fs*n);
P = [P(1, :); 2*P(2:end, :)];

if rem(n,2) == 0, 
    % Even nfft -> a(1) = DC, a(end) = Nyquist
    a(end,:) = a(end,:)/2; 
    Y(end, :) = 1/2*Y(end, :);
    P(end, :) = 1/2*P(end, :);  
end


% Compute the corresponding frequency
f = 0 : Fs/n : Fs/2;

AB = [a b];


