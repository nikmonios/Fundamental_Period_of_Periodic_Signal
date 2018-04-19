function Tperiod = fundamental_period(X)
    
    Xlength = length(X);
    trainSize = floor(log(Xlength) / log(2));
    TwoPower = 2^trainSize;
    
    XX = X(1 : TwoPower);
    
    freq = 1;
    Fs = 1;
    T = 1 / Fs;             % Sampling period
    L = length(XX);        % Length of signal
    t = (0 : L-1) * T;        % Time vector
    Y = zeros(1, L);
    P2 = zeros(1, L);
    P1 = zeros(1, ( L / 2) + 1);
    
    Xm = XX - mean(XX);     % de-trend the samples
    Y = fft(Xm);          % find FFT
    
    P2 = abs(Y / L);
    P1 = P2(1: L / 2 + 1);
    P1(2 : end - 1) = 2 * P1(2 : end - 1);

    f = Fs*(0 : (L / 2)) / L;   % convert time to frequency
    freq = f(P1 == max(P1(:))); % find frequency that the margin of FFT is max
    Tperiod = 1 / freq; % reverse the frequency to find the period
end