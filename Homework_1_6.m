%----------------------------- Problem 6 ---------------------------% 
% 6. Compute the bandwidth β needed to achieve range resolutions 
% of 1 m, 1 km, and 100 km. What is the length of a constant-frequency
% rectangular pulse having this Rayleigh bandwidth for each value of 
% resolution?
%   ΔR = c / 2B 
% Where c is the speed of light 
% Where B is the Bandwidth in (Hertz) 
% Where ΔR is the range resolution
tic
clear; clc; close all;
myConstants;
c = physconst('LightSpeed');       % in meters per second 
Delta_R   = 1;                     % meters 
Delta_R_2 = 1 * km2m;              % meters   
Delta_R_3 = 100 * km2m;            % meters 
B   = c / (2 .* Delta_R);          % Bandwidth 
B_1 = c / (2 .* Delta_R_2);        % Bandwidth 
B_2 = c / (2 .* Delta_R_3);        % Bandwidth 
fprintf('=========================================\n');
fprintf('   The bandwidth of (1 meter): %.3f in Megahertz \n', B_1);
fprintf('   The bandwidth of (1 meter): %.3f in Hertz \n', B_1 * 1/Hz2MHz);
% For a constant-frequency rectangular pulse, 
% the Rayleigh bandwidth is approximately related to pulse duration \(\tau\) by
%           B = 1 / t
%           t = 1 / B
t = 1 / B; 
fprintf('   The pulse duration or pulse width: %.12f in -s \n', t);
fprintf('   The pulse duration or pulse width: %.3f in nanoseconds \n', t*sec2ns);
%  Transmitter
%  ON           ┌───────────┐
%               │   PULSE   │
%        ───────┘           └──────────────── Time
%                ←--- τ --->
% 1 kilometer
t_1 = 1 / B_1; 
fprintf('=========================================\n');
fprintf('   The bandwidth of (1 km): %.3f in Hertz \n', B_1);
fprintf('   The pulse duration or pulse width: %.12f in -s \n',t_1);
fprintf('   The pulse duration or pulse width: %.3f in microseconds \n',t_1*sec2mics);
% 100 kilometers
t_2 = 1 / B_2; 
fprintf('=========================================\n');
fprintf('   The bandwidth of (100 km): %.3f in Hertz \n', B_2);
fprintf('   The bandwidth of (100 km): %.3f in Kilohertz \n', B_2 * Hz2KHz);
fprintf('   The pulse duration or pulse width: %.8f in miliseconds \n',t_2 * sec2ms);
toc