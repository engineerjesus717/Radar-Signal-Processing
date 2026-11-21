clear;
clc;
close all;
tic
myConstants
f_c=77e9;           % center frequency
f_start=77.2e9;     % chirp starting frequency (Hz) 
f_stop=76.8e9;      % chirp end frequency      (Hz) 
PRI=30e-6;          % Pulse Repetition Interval (Microseconds)
P_T=20e-6;          % chirp pulse width
M=400;              % fast time samples
K=500;              % number of chirps
f_s=20e6;           % ADC sample frequency
c=3e8;              % light speed
dt=1/f_s;
theormal_noise_power=0; % thermal noise power
%-----------------------------------------------------------%
%    |-----------------------|------------------------|
%   76.8 GHz               77 GHz                  77.2 GHz
%                       Center Frequency
B = f_start - f_stop; 
fprintf('The Bandwidth is: %e in Hz \n', B)
% Range Resolution 
% ΔR = c/2B
Range_Resolution = c / (2*B);
fprintf('The Range Resolution is: %.3f in meters \n', Range_Resolution)
fprintf('The Range Resolution is: %.3f in cm \n', Range_Resolution*m2cm)
% The radar operates around 77 GHz, but its range resolution depends on its
% 400 MHz sweep bandwidth not directly on the 77 GHz Center Frequency 
% The chirp slope is 
% S = B/Tp
S = B / P_T;
fprintf('The Chirp Slope is: %e in Hz/sec \n', S)
% The wavelength and velocity resolution are: 
% λ = c/frequecy center
Wavelength = c/f_c; 
fprintf('The Wavelength is: %.3f in meters \n', Wavelength)
% The velocity resolution is 
% Δv = λ / 2(K)(Tpri)
Delta_Velocity = Wavelength / (2*K*PRI);
fprintf('The Velocity is: %.3f in meters/sec\n', Delta_Velocity)
% CPI duration 
T_CPI = K * PRI;
fprintf('The CPI duration: %.0f in miliseconds \n',T_CPI*sec2ms)
% Range ambiguity: two distinct limits 
% Pulse Repetition Interval limit 
R_PRI = c *(PRI/2);
fprintf('Thr range ambiguous is: %.0f meters \n', R_PRI)
% Sampled beat - frequency period 
% R_ADC = c * fs / (2*S) 
R_ADC = c * f_s / (2*S);
fprintf('The sampled beat-frequency period: %.3f in meters \n',R_ADC)
% Velocity Unambiguity
PRF = 1 /PRI; 
fprintf('The PRF is: %.3f in Hz \n', PRF)
V_unamb = Wavelength * (PRF/4);
fprintf('The velocity ambiguity is: %.3f m/s\n', V_unamb)
% Velocity alias interval = λ * (PRF/2)
V_alias = (Wavelength *PRF) / 2;
fprintf('The velocity alias interval is: %.3f m/s \n',V_alias)
% The first Doppler ambiguity occurs when a true Doppler frequency falls 
% outside the +/- PRF/2 interval 
% frequencies differing by an integer multiple of PRF are indistinguishable





R=[10,100,50]';     % target range
v=[15,10,13]';      % target velocity
RCS=[1,10000,100]'; % target RCS

theormal_noise=normrnd(0,1,M,K)+1i.*normrnd(0,1,M,K);
theormal_noise=theormal_noise*sqrt(theormal_noise_power);

f_r=2*R/c*(f_start-f_stop)/P_T;
f_d=2*v*f_c/c;

t=0:dt:dt*(PRI*f_s*K-1);

RCS=sqrt(RCS);
received=((RCS)./R.^2)'*exp(j.*2.*pi.*(f_r+f_d)*t);

reshape_received=reshape(received,PRI*f_s,K);
data_cube=reshape_received(1:P_T*f_s,:);
data_cube=data_cube+theormal_noise;












toc