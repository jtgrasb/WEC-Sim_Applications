close all
clear all
clc

%% run cases and save



largeXYOff = load('largeXYOff.mat');
largeXYOn = load('largeXYOn.mat');
h5Interp = load('h5Interp.mat');
h5PhaseShift = load('h5PhaseShift.mat');

figure()
plot(largeXYOff.output.bodies(1).time, largeXYOff.output.bodies(1).position(:,1))
hold on
plot(largeXYOn.output.bodies(1).time, largeXYOn.output.bodies(1).position(:,1))
plot(h5Interp.output.bodies(1).time, h5Interp.output.bodies(1).position(:,1),'--')
plot(h5PhaseShift.output.bodies(1).time, h5PhaseShift.output.bodies(1).position(:,1),':')
xlabel('time (s)')
ylabel('surge (m)')
legend('Large XY off', 'Large XY on','h5 interp','h5 phase shift')

figure()
plot(largeXYOff.output.bodies(1).time, largeXYOff.output.bodies(1).position(:,3))
hold on
plot(largeXYOn.output.bodies(1).time, largeXYOn.output.bodies(1).position(:,3))
plot(h5Interp.output.bodies(1).time, h5Interp.output.bodies(1).position(:,3),'--')
plot(h5PhaseShift.output.bodies(1).time, h5PhaseShift.output.bodies(1).position(:,3),':')
xlabel('time (s)')
ylabel('heave (m)')
legend('Large XY off', 'Large XY on','h5 interp','h5 phase shift')

