%----------------------------- Problem 16 ---------------------------% 
% 16. Determine the approximate size of a volume resolution cell in 
% cubic meters, ΔV, for R = 20 km, ΔR = 100 m, and θ3 = f3 = 3°
% Delta_v = ?    What is the volume of resolution cell? 
%                    Elevation
%                       ↑
%                       |
%                       |    ┌─────────┐
%                       |   /         /|
%                       |  /         / |
%Radar ●───────────────►|───────────►  |
%                       | /         /  |
%                       |/_________/   |
%                       +----------------→
%                              Range
% Range Dimension     = Delta_R
% Azimuth Dimension   = RTheta3
% Elevation Dimension = Rphi3 
% 
% Delta_V = Delta_R(RTheta3)(Rphi3) 
%
%   or
%
% Delta_V = R^2 Rtheta3 Delta phi
tic
clear; clc; close all; 
myConstants
R           = 20;                % kilometers 
Delta_R     = 100;               % meters
RTheta3     = 3;                 % 3 degrees 
R_meters    = R * km2m;          % kilometers to meters
RTheta3_rad = RTheta3 * deg2rad; % to radians
RPhi_rad    = RTheta3 * deg2rad; % to radians
% Delta_V = R^2 Rtheta3 Delta phi
Delta_V     = ((R_meters)^2 * Delta_R * RTheta3_rad * RPhi_rad);
fprintf('Delta V is: %.3f  in m^3\n ', Delta_V);
fprintf('Delta V is: %.3s  in m^3\n ', Delta_V);
% Azimuth Dimension
% Daz = R*theta3 
D_az  = (R * km2m)*(RTheta3_rad); 

fprintf('Azimuth Dimension is: %.3f, in meters\n ', D_az);
fprintf('Azimuth Dimension is: %.3f, in kilometers\n ', D_az * m2km);
fprintf('Elevation Dimension is: %.3f, in meters\n ', D_az);
fprintf('Elevation Dimension is: %.3f, in kilometers\n ', D_az * m2km)
D_elev = D_az;                  % D_elev = R phi 3 










