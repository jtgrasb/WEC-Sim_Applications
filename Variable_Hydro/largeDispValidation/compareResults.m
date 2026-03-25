close all
clear all
clc

%% no pretension cases

% base = load('noPretension/base.mat');
largeXY = load('noPretension/largeXY.mat'); % large xy and var hydro no pretension should be different from base because they adjust the excitation at each timestep 
varHydro_05 = load('noPretension/varHydro0.05.mat');
varHydro_02 = load('noPretension/varHydro0.02.mat');
varHydro_01 = load('noPretension/varHydro0.01.mat');

figure()
plot(largeXY.output.bodies(1).time, largeXY.output.bodies(1).position(:,1))
hold on
plot(varHydro_05.output.bodies(1).time, varHydro_05.output.bodies(1).position(:,1))
plot(varHydro_02.output.bodies(1).time, varHydro_02.output.bodies(1).position(:,1))
plot(varHydro_01.output.bodies(1).time, varHydro_01.output.bodies(1).position(:,1))
xlabel('time (s)')
ylabel('surge (m)')
legend('Large XY', 'variable hydro (\Deltax = 0.05)', 'variable hydro (\Deltax = 0.02)', 'variable hydro (\Deltax = 0.02)')

figure()
plot(largeXY.output.bodies(1).time, largeXY.output.bodies(1).position(:,3))
hold on
plot(varHydro_05.output.bodies(1).time, varHydro_05.output.bodies(1).position(:,3),'--')
plot(varHydro_02.output.bodies(1).time, varHydro_02.output.bodies(1).position(:,3),'--')
plot(varHydro_01.output.bodies(1).time, varHydro_01.output.bodies(1).position(:,3),'--')
xlabel('time (s)')
ylabel('heave (m)')
legend('Large XY', 'variable hydro (\Deltax = 0.05)', 'variable hydro (\Deltax = 0.02)', 'variable hydro (\Deltax = 0.02)')

%%

base = load('base.mat');
largeXY = load('largeXY.mat');
varHydroCoarse = load('varHydroCoarse.mat');
varHydroFine = load('varHydroFine.mat');
varHydroFine2 = load('varHydroFine2.mat');

figure()
plot(base.output.bodies(1).time, base.output.bodies(1).position(:,1))
hold on
plot(largeXY.output.bodies(1).time, largeXY.output.bodies(1).position(:,1))
plot(varHydroCoarse.output.bodies(1).time, varHydroCoarse.output.bodies(1).position(:,1),'--')
plot(varHydroFine.output.bodies(1).time, varHydroFine.output.bodies(1).position(:,1),'--')
plot(varHydroFine2.output.bodies(1).time, varHydroFine2.output.bodies(1).position(:,1),':')
xlabel('time (s)')
ylabel('surge (m)')
legend('baseline','Large XY', 'variable hydro coarse', 'variable hydro fine')

figure()
plot(base.output.bodies(1).time, base.output.bodies(1).position(:,3))
hold on
plot(largeXY.output.bodies(1).time, largeXY.output.bodies(1).position(:,3))
plot(varHydroCoarse.output.bodies(1).time, varHydroCoarse.output.bodies(1).position(:,3),'--')
plot(varHydroFine.output.bodies(1).time, varHydroFine.output.bodies(1).position(:,3),'--')
plot(varHydroFine2.output.bodies(1).time, varHydroFine2.output.bodies(1).position(:,3),':')
xlabel('time (s)')
ylabel('heave (m)')
legend('baseline','Large XY', 'variable hydro coarse', 'variable hydro fine', 'variable hydro fine 2')