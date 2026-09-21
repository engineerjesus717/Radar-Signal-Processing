%------------------------------ Problem 1 -------------------------------%
% Use MATLAB to generate a sinsoid signal r(t) = exp(j.*2.*pi.*fv.*t), 
% where fc = 200e3, and set time to be t = 0.1e-6 : 0.1e-6 ; 20e-6. 
%   1. Use the command fft(x,N) to plot FFT of the sinsoid signal using 200
%   points FFT transform, i.e. (N=200) 
%   2. Plot FFT of the sinsoid signal using 2000 points FFT transform,
%   i.e( N = 2000) 
%   3. Change t to t = 0.1e-6: 0.1e-6 : 200e-6 and do 2000 points FFT
%   transform 
%   4. Compare the differences between 1), 2) and 3) 
tic 
clear; clc; close all; 
myConstants

Fc     = 200e3;                     % Hz  | Carrier Frequency 
Fc_Khz = Fc * Hz2KHz;               % KHz | Carrier Frequency 
t      = 0.1e-6:0.1e-6:20e-6;
r      = exp(1j*2*pi*Fc*t);
N      = 200;                       % Number of samples
fprintf('Number of samples: %d \n',length(t))
%------------------- Determine the Sampling Frquency --------------------%
Delta_t     = 0.1;                  % Microseconds
Delta_t_sec = Delta_t * micsec2sec; % Seconds
% The sampling frequency is 
% 
%   fs = 1 / Delta_t
%
F_samp = 1 / Delta_t_sec; 
fprintf('____________________________________________________________\n')
fprintf('The sampling frequency is: %.2f Hertz\n', F_samp)
fprintf('The sampling frequency is: %.2f MHz\n', F_samp * Hz2MHz)
%------------------------------------------------------------------------%
% Original signal:
% 
% | x x x x x x x x x ... x |
% <------ 200 samples ------>
% 
% 
% 2000-point FFT:
% 
% | x x x x x x x x ... x | 0 0 0 0 0 ... 0 |
% <------ 200 ------->      <---- zeros ---->
%------------------------------------------------------------------------%
% Part 1 | 200 Point FFT
%               
%   X[k] = FFT{r[n]}
X200 = fft(r,200); 

% FFT Frequency spacing
% The frequency spacing between FFT bins is 
%
%   Delta_f = Fs / N 
%
F_spacing = F_samp / N; 
fprintf('The frequency spacing is: %.2f in Hertz\n', F_spacing)
fprintf('The frequency spacing is: %.2f in Kilohertz\n', F_spacing * Hz2KHz)
% So 200 Khz falls exactly on an FFT bin
% The FFT frequencies are therefore 
% 0, 50, 100, 150, 200, 250,..... kHz
k = Fc / F_spacing; 
X2000 = fft(r,2000);
N2 = 2000;
F_spacing2 = F_samp/N2;
fprintf('The frequency spacing is: %.2f in Hertz \n',F_spacing2)
fprintf('The frequency spacing is: %.2f in Kilohertz \n', F_spacing2*Hz2KHz)
% 200-point FFT:
% 
% |----|----|----|----|----|
% 0   50  100  150  200 kHz
% 
% 
% 2000-point FFT:
% 
% |-|-|-|-|-|-|-|-|-|-|-|-|
% 0 5 10 15 20 ...       kHz
% Case 1: t until 20 us, N = 200 
t1 = 0.1e-6 : 0.1e-6 : 20e-6; 
r1 = exp(1j * 2 * pi * Fc * t1);
N1 = 200; 
% Case 2: t until 20us, N = 2000 
t2 = t1; 
r2 = r1; 
N2 = 2000; 
% Case 3: t until 200us, N = 2000 
t3 = 0.1e-6: 0.1e-6 : 200e-6;
r3 = exp(1j * 2 * pi * Fc * t3); 
N3 = 2000; 

% fftshift to move the frequency 0 to the center
X1 = fftshift(fft(r1, N1));
f1 = (-N1/2 : N1/2 -1) * (F_samp / N1);

X2 = fftshift(fft(r2, N2));
f2 = (-N2/2 : N2/2 -1) * (F_samp / N2);

X3 = fftshift(fft(r2,N3)); 
f3 = (-N3/2 : N3/2 -1) * (F_samp / N3); 
figure('Position', [100, 100, 900, 700]);

% Gráfico Caso 1
subplot(3,1,1);
stem(f1 * Hz2KHz, abs(X1)/length(t1), 'LineWidth', 1.5);
title('1) FFT  200 points (t max = 20 \mu s)');
xlabel('Frequency (kHz)');
ylabel('Magnitude');
grid on; xlim([-500, 500]);
% Gráfico Caso 2
subplot(3,1,2);
plot(f2 * Hz2KHz, abs(X2)/length(t2), 'LineWidth', 1.5);
title('2) FFT of 2000 points with Zero-Padding (t max = 20 \mu s)');
xlabel('Frequency (kHz)');
ylabel('Magnitude');
grid on; xlim([-500, 500]);

% Gráfico Caso 3
subplot(3,1,3);
plot(f3 * Hz2KHz, abs(X3)/length(t3), 'LineWidth', 1.5);
title('3) FFT of 2000 points with more time (t max = 200 \mu s)');
xlabel('Frequency (kHz)');
ylabel('Magnitude');
grid on; xlim([-500, 500]);






toc
