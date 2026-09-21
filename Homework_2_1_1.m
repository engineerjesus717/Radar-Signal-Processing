%------------------------------ Problem 1 -------------------------------%
%
%
tic
clear; clc; close all;
myConstants
c  = physconst('LightSpeed');  % Meters per second 
f  = 95;           % Gigahertz
f1 = f * GHz2Hz;   % Hertz 
Pt = 100;          % Watts
Theta_Az   = 2;    % degrees
Phi_elev   = 5;    % degrees
Out_path   = 3;    % outgoing path kilometers 
Ret_path   = 3;    % return path kilometers
R_total    = Out_path + Ret_path;  
Target_RCS = 20;   % meters^2
% The atmospheric attenuation is 0.4 dB/km according with the Figure 1.3
atm_atte   = 0.4;    % The atmospheric attenuation 
Ls         = 5;      % dB 
L_atm      = atm_atte * R_total; 
L_total    = L_atm + Ls; 
% Convert the losses to linear factor 
L_linear   = 10^(L_total/10);

% Lets calculate the wavelength 
% 
%       c = f * Wavelength 
%
%       Wavelength = c / f 
%
Wavelength = c / f1;
% Calculate the antenna gain 
% 
%   G = 41253 / Theta * Phi 
%
G = 41253 / (Theta_Az * Phi_elev); 

% Convert antenna gain to dB 
% 
%   G_dB = 10 log 10 (G) 
G_dB = 10*log10(G);
Pr = ((Pt * G^2 * Wavelength^2 * Target_RCS) / ((4*pi)^3 * (Out_path*km2m)^4 * L_linear));
% Convert received power to dBm

fprintf('___________________________________________________\n')
fprintf('The transmitted power is (Pt): %.3f in Watts \n', Pt)
fprintf('The wavelengh (λ) is : %.5f meters \n', Wavelength)
fprintf('The wavelenght(λ) is: %.5f milimiters \n', Wavelength*1000)
fprintf('The gain of the antenna (G) is: %.3f linear \n', G)
fprintf('The gain of the antenna (G) is: %.3f in dBi \n', G_dB)
fprintf('The system losses (L) is: %.3f linear \n', L_linear)
fprintf('The Range (R) is: %.3f in meters \n', Out_path*km2m)
fprintf('The target RCS is: %.2f in meters^2 \n',Target_RCS)
fprintf('The Received Power (Pr) is: %s in Watts \n', Pr)
fprintf('___________________________________________________\n')
toc