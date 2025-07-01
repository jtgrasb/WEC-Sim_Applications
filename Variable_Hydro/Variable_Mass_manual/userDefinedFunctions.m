close all

% Plot heave response and forces for body 1
output.plotResponse(1,3);
output.plotForces(1,3);

% % find peaks (requires the Signal Processing toolbox)
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

% figure()
% plot(output.bodies(1).time, output.bodies(1).hydroForceIndex)
% xlabel('Time (s)')
% ylabel('Index (-)');
% title('Sphere hydroForceIndex');
% 
% figure()
% plot(hfMass)
% xlabel('Time (s)')
% ylabel('Mass (kg)')
% title('Sphere mass');
% 
% figure()
% plot(output.bodies(1).time, output.bodies(1).position(:,3))
% xlabel('Time (s)')
% ylabel('Displacement (m)')
% title('Sphere heave displacement');
% 
% figure()
% plot(output.bodies(1).time, output.bodies(1).forceRestoring(:,3))
% xlabel('Time (s)');
% ylabel('Force (N)')
% title('Sphere heave restoring force');
% 
% figure()
% plot(cgDisp)
% xlabel('Time (s)');
% ylabel('Displacement (m)');
% title('CG displacement used in hydrostatic force (m)');
% legend('Surge','Sway','Heave','Roll','Pitch','Yaw');
% 
% figure()
% plot(hsMass)
% xlabel('Time (s)');
% ylabel('Mass (kg)');
% title('Mass in hydrostatic force');
% 
% figure()
% plot(hsVolume)
% xlabel('Time (s)');
% ylabel('Volume (m^3)');
% title('Volume in hydrostatic force');
% 
% figure()
% plot(output.ptos(1).time, output.ptos(1).powerInternalMechanics(:,3))
% yline(mean(output.ptos(1).powerInternalMechanics(:,3)))
% text(10,-5e4,sprintf('mean power = %.0f W', mean(output.ptos(1).powerInternalMechanics(:,3))))
% xlabel('Time (s)')
% ylabel('Power (W)')
