clear;
clc;
close all;
% Step 1: Define folder path
filepath = 'C:\Users\orlan\Downloads\N30W110.SRTMGL1.hgt (1)';
% Step 2: Define filename
filename = 'N30W110.hgt';
% Step 3: Combine folder and filename
fullFilePath = fullfile(filepath, filename);
% Step 4: Check file existence
if ~isfile(fullFilePath)
    error('File not found: %s', fullFilePath);
end
% Step 5: Read elevation data
S = readhgt(fullFilePath);
% Step 6: Extract data
Z = double(S.z);
latitude = S.lat;
longitude = S.lon;
% Step 7: Create 3D terrain plot
Z(Z == -32768) = NaN;
% Reduce data size for faster plotting
step = 5;
Z = Z(1:step:end,1:step:end);
latitude = latitude(1:step:end);
longitude = longitude(1:step:end);
[X,Y] = meshgrid(longitude,latitude);

% %% Step 8: Plot 3D terrain with mesh overlay
% 
% figure('Color','w');
% 
% % First layer: colored terrain surface
% surf(X,Y,Z, ...
%     'FaceColor',[0.5 1.0 1.0], ...
%     'EdgeColor','k','LineWidth',0.1);
% 
% hold on;
% 
% % Second layer: black wireframe mesh
% meshStep = 3;       % Increase for fewer mesh lines
% meshOffset = 3;     % Raise mesh 2 meters above terrain
% 
% Xm = X(1:meshStep:end,1:meshStep:end);
% Ym = Y(1:meshStep:end,1:meshStep:end);
% Zm = Z(1:meshStep:end,1:meshStep:end);
% 
% surf(Xm,Ym,Zm + meshOffset, ...
%     'FaceColor','none', ...
%     'EdgeColor','k', ...
%     'LineWidth',0.1);

%% Custom terrain colors
% Lowest elevation -> Highest elevation

terrainColors = [
    0.05 0.10 0.50   % Dark blue
    0.40 0.75 1.00   % Light blue
    0.10 0.65 0.20   % Yellow
    1.00 0.90 0.10   % Green
    0.90 0.10 0.10   % Red
];

%% Generate smooth color transitions
Ncolors = 256;

customMap = interp1( ...
    linspace(0,1,size(terrainColors,1)), ...
    terrainColors, ...
    linspace(0,1,Ncolors), ...
    'linear');

%% Create terrain surface
figure('Color','w');

surf(X,Y,Z, ...
    'FaceColor','interp', ...
    'EdgeColor','none');

hold on;

%% Add wireframe mesh
meshStep = 1.5;
meshOffset = 2;

Xm = X(1:meshStep:end,1:meshStep:end);
Ym = Y(1:meshStep:end,1:meshStep:end);
Zm = Z(1:meshStep:end,1:meshStep:end);

surf(Xm,Ym,Zm+2, ...
    'FaceColor','none', ...
    'EdgeColor',[0.15 0.15 0.15], ...
    'LineWidth',0.3);

%% Apply custom colors
colormap(customMap);

% Scale colors across full elevation range
clim([min(Z(:),[],'omitnan'), ...
      max(Z(:),[],'omitnan')]);

colorbar;

%% Plot properties
xlabel('Longitude');
ylabel('Latitude');
zlabel('Elevation (m)');
title('3D Terrain - Custom Elevation Colors');

view(45,35);
axis tight;
grid on;

camlight headlight;
%lightangle(45,30);
lighting gouraud;

rotate3d on;
