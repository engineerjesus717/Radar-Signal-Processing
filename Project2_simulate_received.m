clear;
clc;
close all;
tic
f_c=77e9;           % center frequency
f_start=77.2e9;     % chirp starting frequency (Hz) 
f_stop=76.8e9;      % chirp end frequency      (Hz) 
PRI=30e-6;          % Pulse Repetition Interval
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
fprintf('The bandwidth is: %.3f in Hz \n', B)


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