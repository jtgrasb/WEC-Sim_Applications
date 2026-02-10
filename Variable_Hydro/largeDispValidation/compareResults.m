close all
clear all
clc

%%

base = load('base.mat');
largeXY = load('largeXY.mat');
varHydroCoarse = load('varHydroCoarse.mat');
varHydroFine = load('varHydroFine.mat');

figure()
plot(base.output.bodies(1).time, base.output.bodies(1).position(:,1))
hold on
plot(largeXY.output.bodies(1).time, largeXY.output.bodies(1).position(:,1))
plot(varHydroCoarse.output.bodies(1).time, varHydroCoarse.output.bodies(1).position(:,1),'--')
plot(varHydroFine.output.bodies(1).time, varHydroFine.output.bodies(1).position(:,1),'--')
xlabel('time (s)')
ylabel('surge (m)')
legend('baseline','Large XY', 'variable hydro coarse', 'variable hydro fine')

figure()
plot(base.output.bodies(1).time, base.output.bodies(1).position(:,3))
hold on
plot(largeXY.output.bodies(1).time, largeXY.output.bodies(1).position(:,3))
plot(varHydroCoarse.output.bodies(1).time, varHydroCoarse.output.bodies(1).position(:,3),'--')
plot(varHydroFine.output.bodies(1).time, varHydroFine.output.bodies(1).position(:,3),'--')
xlabel('time (s)')
ylabel('heave (m)')
legend('baseline','Large XY', 'variable hydro coarse', 'variable hydro fine')