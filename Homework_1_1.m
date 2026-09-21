%----------------------------- Problem 1 ---------------------------% 
% The time delays to and from three targets are 1.5 msec, 1.8 msec, and 2
% msec. respectively. 
%       a) Find the range of these three targets 
%       b) The radar system needs to have 50m range resolution. What is the
%       approximate required bandwidth? 
%       c) The radar system now needs a range resolution of 25m. What is
%       the approximate corresponding bandwidth? How does this relate to
%       part b) ? 
%       d) The radar uses a PRF of 700 Hz. What is the corresponding
%       unambiguous range? What happens to the unambigous range if the
%       radar's PRF is doubled? 
%       e) For a PRF of 700 Hz what is the apparent "wrapped around" range
%       of the three targets in part (a)? What is the apparent "wrapped
%       around" range if the PRF is changed to 1 kHz?
%------------------------------------------------------------------%
clear; clc; close all; 

tic
myConstants;
c   = physconst('LightSpeed');   % speed of light in meters per second
t1  = 1.5;                       % miliseconds
t2  = 1.8;                       % miliseconds 
t3  = 2.0;                       % miliseconds
% conversion from milisenconds to seconds 
t_1 = 1.5 * 1e-3;                % seconds 
t_2 = 1.8 * 1e-3;                % seconds
t_3 = 2.0 * 1e-3;                % seconds 
resolution_50 = 50;              % meters
resolution_25 = 25;              % meters
%%------------------------------------------------------------------------
% (a) Find the Range of the three targets
% Formula: 
%       R = c*t/2
%%------------------------------------------------------------------------
R1 = (c .* t_1) / 2;              % meters
R2 = (c .* t_2) / 2;              % meters
R3 = (c .* t_3) / 2;              % meters
fprintf('=========================================\n');
fprintf('a) Target Ranges\n'); 
fprintf('   Range target 1= %f in kilometers\n', R1 * m2km);
fprintf('   Range target 2= %f in kilometers\n', R2 * m2km); 
fprintf('   Range target 3= %f in kilometers\n', R3 * m2km);
fprintf('=========================================\n');
%%------------------------------------------------------------------------
% (b) The Radar system needs to have 50 meters resolution.
% What is the approximate bandwidth? 
%       ΔR = c / 2B 
% Where c is the speed of light 
% Where B is the Bandwidth in (Hertz) 
% Where ΔR is the range resolution
%%------------------------------------------------------------------------
Delta_R = 50;             % meters
B = c / (2 .* Delta_R);   
fprintf('b) Bandwidth is = %.3f in Hz\n', B);
fprintf('   Bandwidth is = %.3f in MHz\n', B * Hz2MHz);
fprintf('=========================================\n');
% 3 MHz bandwidth allows the radar to distinguish tow targets at are approximately 
% 50 meters apart in Range if the range difference is smaller than about
% 50m, the radar might not be able to distinguish them as two separate
% targets 
%%------------------------------------------------------------------------
% (c) The Radar system needs to have 25 meters resolution.
% What is the approximate bandwidth? 
%       ΔR = c / 2B 
% Where c is the speed of light 
% Where B is the Bandwidth in (Hertz) 
% Where ΔR is the range resolution
%%------------------------------------------------------------------------
Delta_R2 = 25; 
B2 = c / (2 .* Delta_R2);
fprintf('c) Bandwidth is = %.3f in Hz\n', B2);
fprintf('   Bandwidth is = %.3f in MHz\n', B2 * Hz2MHz); 
fprintf('=========================================\n');
% More Bandwidth = better range resolution 
% Range Resolution  |   Required Bandwidth 
%       50m         |          3 MHz 
%       25m         |          6 MHz
% (d) The radar uses a PRF of 700 Hz. What is the corresponding
% unambiguous range? What happens to the unambigous range if the
% radar's PRF is doubled? 
% PRF = Pulse Repetition Frequency 
% PRI = Pulse Repetition Interval
PRF = 700;         % Hz or 1/second
% T = 1 / PRF 
T = 1 / PRF * sec2ms; 
fprintf('d) Time is = %.3f in miliseconds \n', T);
% The maximum unambiguous range 
%   R_unambiguous = c / 2*PRF 
R_unambiguous = c / (2.*PRF);   % meters
fprintf("   The Unambiguous Range= %.3f in meters\n", R_unambiguous)
fprintf('   The Unambiguous Range= %.3f in kilometers\n', R_unambiguous * m2km);
% What happens if the Unambiguous Range is double? 
PRF_1 = 1400;      % Hz ir 1/second
% T = 1 / PRF
T_1 = 1 / PRF_1 * sec2ms; 
fprintf('d) Time is = %.3f in miliseconds \n', T_1);
R_unambiguous_1 = c / (2.*PRF_1); % meters
fprintf('   The Unambiguous Range (double)= %.3f in meters\n', R_unambiguous_1)
fprintf('   The Unambiguous Range (double)= %.3f in kilometers\n', R_unambiguous_1 *m2km);
fprintf('=========================================\n');
% Doubling PRF cuts unambigous range in half
% (e) For a PRF of 700 Hz what is the apparent "wrapped around" range
% of the three targets in part (a)? 
% What is the apparent "wrapped around" range if the PRF is changed to 1 kHz?
% R_apparent = R mod R_unambiguous 
% The Unambiguous Range is 214.13 kilometers
R_apparent1 = R1 - R_unambiguous; 
fprintf('e) Apparent Range = %.3f in kilometers \n', R_apparent1 * m2km)
R_apparent2 = R2 - R_unambiguous;
fprintf('   Apparent Range = %.3f in kilometers \n', R_apparent2 * m2km)
R_apparent3 = R3 - R_unambiguous; 
fprintf('   Apparent Range = %.3f in kilometers \n', R_apparent3 * m2km)
% Now PRF to 1 kHz 
PRF_2 = 1000;       % Hz
R_unambiguous_2 = c / (2*PRF_2);
fprintf('   The Unambiguous Range (1 KHz)= %.3f in kilometers \n',R_unambiguous_2*m2km);
% 3 targets 225, 270, 300 
R_apparent_1 = R1 - R_unambiguous_2;
fprintf('   The Apparent Range (1 KHz) = %.3f in kilometers \n', R_apparent_1 * m2km);
R_apparent_2 = R2 - R_unambiguous_2; 
fprintf('   The apparent Range (1 KHz)= %.3f in kilometers \n', R_apparent_2 * m2km);
R_apparent_3 = R3 - 2.*R_unambiguous_2; 
fprintf('   The apparent Range (1 KHz)= %.3f in kilometers \n', R_apparent_3 * m2km);
toc