close all
clear all
clc

output0 = load('x5/large_xy_0_reg_new.mat');
output5LargeXY = load('x5/large_xy_5_reg.mat');
output5LargeXY = load('x5/large_xy_5_reg_new.mat');
output5PhaseShift = load('x5/phaseShift_5_reg.mat');
output5LargeXYPhaseShift = load('x5/phaseShift_5_reg_large_xy.mat');

figure()
plot(output0.output.bodies(1).time,output0.output.bodies(1).position(:,3))
hold on
plot(output5LargeXY.output.bodies(1).time,output5LargeXY.output.bodies(1).position(:,3))
plot(output5PhaseShift.output.bodies(1).time,output5PhaseShift.output.bodies(1).position(:,3),'--')
plot(output5LargeXYPhaseShift.output.bodies(1).time,output5LargeXYPhaseShift.output.bodies(1).position(:,3),'-.')
xlabel('time (s)')
ylabel('heave (m)')
legend('large xy on, x = 0 m','large xy on, x = 5 m','large xy off, phase shifted','large xy on, phase shifted')

%% compare for 10 m phase shift

output0 = load('x10/large_xy_0_reg_new.mat');
output10LargeXY = load('x10/large_xy_10_reg_new.mat');
output10PhaseShift = load('x10/phaseShift_10_reg.mat');
output10LargeXYPhaseShift = load('x10/phaseShift_10_reg_large_xy.mat');
outputSphere10 = load('x10/sphere_10_reg.mat');
outputSphere10LargeXY = load('x10/sphere_10_reg_large_xy.mat');

figure()
plot(output0.output.bodies(1).time,output0.output.bodies(1).position(:,3))
hold on
plot(output10LargeXY.output.bodies(1).time,output10LargeXY.output.bodies(1).position(:,3))
% plot(output10PhaseShift.output.bodies(1).time,output10PhaseShift.output.bodies(1).position(:,3),'--')
% plot(output10LargeXYPhaseShift.output.bodies(1).time,output10LargeXYPhaseShift.output.bodies(1).position(:,3),'-.')
plot(outputSphere10.output.bodies(1).time,outputSphere10.output.bodies(1).position(:,3),'--')
plot(outputSphere10LargeXY.output.bodies(1).time,outputSphere10LargeXY.output.bodies(1).position(:,3),':')
xlabel('time (s)')
ylabel('heave (m)')
legend('x = 0 m','initial x = 10 m, large xy on','BEM: x = 10 m, large xy off','BEM: x = 10 m, large xy on')

%% compare for 10 m phase shift irregular waves

output0 = load('x10_irreg/large_xy_0.mat');
output10LargeXY = load('x10_irreg/large_xy_10.mat');
output10LargeXYOld = load('x10_irreg/large_xy_10_old.mat');
outputBEM10 = load('x10_irreg/bem_10.mat');
outputBEM10LargeXY = load('x10_irreg/bem_10_large_xy.mat');
outputPhaseShift10 = load('x10_irreg/phaseShift_10.mat');

figure()
plot(output0.output.bodies(1).time,output0.output.bodies(1).position(:,3))
hold on
plot(output10LargeXY.output.bodies(1).time,output10LargeXY.output.bodies(1).position(:,3))
% plot(output10LargeXYOld.output.bodies(1).time,output10LargeXYOld.output.bodies(1).position(:,3),'.')
% plot(outputBEM10.output.bodies(1).time,outputSphere10.output.bodies(1).position(:,3),'--')
% plot(outputBEM10LargeXY.output.bodies(1).time,outputSphere10LargeXY.output.bodies(1).position(:,3),':')
plot(outputPhaseShift10.output.bodies(1).time,outputPhaseShift10.output.bodies(1).position(:,3),'--')
xlabel('time (s)')
ylabel('heave (m)')
legend('x = 0 m','initial x = 10 m, large xy on','BEM: x = 10 m')
