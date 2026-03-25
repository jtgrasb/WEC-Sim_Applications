clear all
close all
clc

% run cases to compare variable hydro to large xy

% run base case without pretension
varHydro = 0;
largeXY = 0;
pretension = 0;
wecSim

% run large xy without pretension
varHydro = 0;
largeXY = 1;
pretension = 0;
wecSim

% run variable hydro cases without pretension
varHydro = 1;
largeXY = 0;
pretension = 0;
bemMinX = -1;
bemMaxX = 1;

deltaXVals = [0.05, 0.02, 0.01];

for ii = 1:length(deltaXVals)
    bemDeltaX = deltaXVals(ii);
    wecSim
end

