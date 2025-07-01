close all
clear
clc

load ../Variable_Mass/varMassResults.mat

figure()
plot(output.bodies(1).time, output.bodies(1).position(:,3),'b-')
hold on

load manualMassResults.mat

for ii = 1:length(mcrManual)
    startTime = 100*(ii-1);
    timeVec = startTime:0.1:startTime+100;
    plot(timeVec, mcrManual(ii).position(:,3),'r--')
end
xlabel('Time (s)')
ylabel('Displacement (m)')
title('Sphere heave displacement');
legend('Variable Mass','Manual Change Mass')