close all

% Plot heave response and forces for body 1
output.plotResponse(1,3);
output.plotForces(1,3);

% find peaks
% [pks, pksInds] = findpeaks(output.bodies(1).position(:,3));
% 
% figure()
% plot(output.bodies(1).time, output.bodies(1).position(:,3))
% hold on
% plot(output.bodies(1).time(pksInds), output.bodies(1).position(pksInds,3),'*')
% xlabel('time (s)')
% ylabel('heave disp (m)')
% 
% % use 2nd peak 
% natPeriod = output.bodies(1).time(pksInds(2))/2;

figure()
plot(hfIndex)
xlabel('time (s)')
ylabel('hf index')

figure()
plot(hfMass)
xlabel('time (s)')
ylabel('mass (kg)')

figure()
plot(output.bodies(1).time, output.bodies(1).position(:,3))
xlabel('time (s)')
ylabel('heave disp (m)')

figure()
plot(output.ptos(1).time, output.ptos(1).powerInternalMechanics(:,3))
yline(mean(output.ptos(1).powerInternalMechanics(:,3)))
text(10,-5e4,sprintf('mean power = %.0f W', mean(output.ptos(1).powerInternalMechanics(:,3))))
xlabel('time (s)')
ylabel('heave disp (m)')