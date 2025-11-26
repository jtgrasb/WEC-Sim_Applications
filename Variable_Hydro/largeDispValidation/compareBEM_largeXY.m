close all
clear all
clc

load BEM_xy_off.mat
outputBEM_xy_off = output;
load BEM_xy_on.mat
outputBEM_xy_on = output;
load large_xy_off.mat
outputLarge_xy_off = output;
load large_xy_on.mat
outputLarge_xy_on = output;

figure()
plot(outputLarge_xy_off.bodies(1).time,outputLarge_xy_off.bodies(1).position(:,3))
hold on
plot(outputLarge_xy_on.bodies(1).time,outputLarge_xy_on.bodies(1).position(:,3),'--')
plot(outputBEM_xy_off.bodies(1).time,outputBEM_xy_off.bodies(1).position(:,3),'-.')
plot(outputBEM_xy_on.bodies(1).time,outputBEM_xy_on.bodies(1).position(:,3),':')
xlabel('time (s)')
ylabel('heave (m)')
legend('Large xy off','Large xy on','BEM, large xy off','BEM, large xy on')