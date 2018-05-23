function Tperiod = fundamental_period(X)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% X is an array that the samples of the signal are stored       %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	
    Xlength = length(X); % find the length of the samples of the signal
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% we must apply the algorithm in a set that its length is a power of 2  %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
    trainSize = floor(log(Xlength) / log(2)); % find the max number from 0 to Xlength that is a number of 2
	
    TwoPower = 2^trainSize; % this number is the length of the data set on which we will apply the algorithm, and it is a power of 2
    
    XX = X(1 : TwoPower); % so our training set is from the first element of the array untill TwoPower
    
    freq = 1; % init frequency
	
    Fs = 1; % init sampling frequency
	
    T = 1 / Fs;             % init sampling period
	
    L = length(XX);        % Length of training signal
	
    t = (0 : L - 1) * T;        % Time vector
	
    Y = zeros(1, L); % init FFT array 
	
    P2 = zeros(1, L); % init power spectrum
	
    P1 = zeros(1, ( L / 2) + 1); % first power spectrum area
    
    Xm = XX - mean(XX);     % de-trend the training set
    Y = fft(Xm);          % find FFT of the de-trend set
    
    P2 = abs(Y / L); % find the 2-sided spectrum
	
    P1 = P2(1: L / 2 + 1); % find the single-sided spectrum
	
    P1(2 : end - 1) = 2 * P1(2 : end - 1); % this is the single-sided spectrum

    f = Fs*(0 : (L / 2)) / L;   % find the frequency domain
	
    freq = f(P1 == max(P1(:))); % find frequency that the margin of FFT is max
	
    Tperiod = 1 / freq; % reverse the frequency to find the period
end