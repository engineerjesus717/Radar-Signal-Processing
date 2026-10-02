%---------------------------- Problem 2 ---------------------------------%
% Compute the time delays for two-way propagation to targets at distances
% of 100 km, 100 statute miles, and 100 ft
clear; clc; close all; 
tic
myConstants;
c = physconst('LightSpeed');        % Speed of light in M/s 
%       
%   t = 2*d/c
% 
% Distances 
D_1 = 100*km2m;       % Kilometers 
D_2 = 100*m2statutem; % statute miles 
D_3 = 100*ft2m;       % feet

t_1 = (2*D_1)/c;      % time delays
t_2 = (2*D_2)/c;      % time delays
t_3 = (2*D_3)/c;      % time delays

fprintf('_______________________________________________\n')
fprintf('Two-way delays for 100 km: %.6f microseconds\n', t_1*sec2mics)
fprintf('Two-way delays for 100 statute %.9f miliseconds\n', t_2*sec2ms)
fprintf('Two-way delays for 100 feet %.6f nanoseconds\n',t_3*sec2ns)
fprintf('_______________________________________________\n')