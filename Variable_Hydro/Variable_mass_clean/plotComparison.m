close all
clear all
clc

load massControl.mat

outputMassControl = output;

load constantMass.mat

outputConstantMass = output;

figure()
plot(outputConstantMass.ptos(1).time,outputConstantMass.ptos(1).powerInternalMechanics(:,3))
hold on
plot(outputMassControl.ptos(1).time,outputMassControl.ptos(1).powerInternalMechanics(:,3))
xlabel('time (s)')
ylabel('power (W)')
legend('Constant Mass','Mass Control')