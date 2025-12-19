%Example of user input MATLAB file for post processing
close all

%Plot waves
waves.plotElevation(simu.rampTime);
try 
    waves.plotSpectrum();
catch
end

%Plot heave response for body 1
output.plotResponse(1,1);
output.plotResponse(1,3)

%Plot heave forces for body 1
% output.plotForces(1,3);

figure()
plot(output.bodies(1).time,output.bodies(1).forceRestoring(:,5))
hold on
plot(output.bodies(1).time,output.bodies(1).position(:,5)*1e5)
plot(output.bodies(1).time,hfIndex.Data*1e4)
xlabel('time (s)')
ylabel('pitch restoring force')
legend('restoring force','rotation','hf index')
ylim([-.5e6, 2e6])

figure()
plot(output.bodies(1).time,output.bodies(1).forceRestoring(:,5))
hold on
plot(netBuoyancyForce.Time, linearRestoringForce.Data(5,:),'--')
plot(linearRestoringForce.Time, netBuoyancyForce.Data(:,5),'--')
% plot(output.bodies(1).time,output.bodies(1).position(:,5)*-5e6,':')
xlabel('time (s)')
ylabel('pitch restoring force')
legend('restoring force','linear','net buoyancy')
ylim([-.5e6, 2e6])

% plot cb and cg in Simulink
figure()
plot(cg)
hold on
plot(cb,'--')
xlabel('time (s)')
ylabel('cb/cg')
legend('cg x','cg y','cg z','cb x','cb y','cb z')

figure()
plot(output.bodies(1).time, output.bodies(1).forceTotal(:,1))
hold on
plot(output.bodies(1).time, output.bodies(1).forceExcitation(:,1))
plot(output.bodies(1).time, output.bodies(1).forceAddedMass(:,1))
plot(output.bodies(1).time, output.bodies(1).forceRadiationDamping(:,1))
plot(output.bodies(1).time, output.bodies(1).forceRestoring(:,1))
xlabel('time (s)')
ylabel('surge forces (N)')
legend('total','excitation','added mass','radiation damping','restoring')
ylim([-1e6, 1e6])

%%
% check cgs of hydroForces
fields = fieldnames(body(1).hydroForce);

for ii = 1:length(fields)
    hf = body(1).hydroForce.(fields{ii});
    cg_new(:,ii) = hf.centerGravity;
    cb_new(ii,:) = hf.centerBuoyancy;
end

figure()
plot(1:length(cg_new),cg_new)
hold on
plot(1:length(cg_new),cb_new,'--')
xlabel('hf index')
ylabel('cg/cb')
legend('cg x','cg y','cg z','cb x','cb y','cb z')

%% check mass
