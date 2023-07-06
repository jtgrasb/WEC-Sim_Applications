% This script completes a basic time domain simulation using the body
% impedance

% Inputs (from wecSimInputFile)
simu = simulationClass();
body(1) = bodyClass('hydroData/sphere.h5');
waves.height = 2.5;
waves.period = 9.6664;

% Load hydrodynamic data for float from BEM
hydro = readBEMIOH5(body.h5File, 1, body.meanDrift);

% Define wave conditions
H = waves.height;
A = H/2;
T = waves.period;
omega = (1/T)*(2*pi);

% Define excitation force based on wave conditions
ampSpect = zeros(length(hydro.simulation_parameters.w),1);
[~,closestIndOmega] = min(abs(omega-hydro.simulation_parameters.w));
ampSpect(closestIndOmega) = A;
FeRao = squeeze(hydro.hydro_coeffs.excitation.re(3,:))'*simu.rho*simu.gravity + squeeze(hydro.hydro_coeffs.excitation.im(3,:))'*simu.rho*simu.gravity*1j;
Fexc = ampSpect.*FeRao;

% Define the intrinsic mechanical impedance for the device
mass = simu.rho*hydro.properties.volume;
addedMass = squeeze(hydro.hydro_coeffs.added_mass.all(3,3,:))*simu.rho;
radiationDamping = squeeze(hydro.hydro_coeffs.radiation_damping.all(3,3,:)).*squeeze(hydro.simulation_parameters.w')*simu.rho;
hydrostaticStiffness = hydro.hydro_coeffs.linear_restoring_stiffness(3,3)*simu.rho*simu.gravity;
Gi = -((hydro.simulation_parameters.w)'.^2.*(mass+addedMass)) + 1j*hydro.simulation_parameters.w'.*radiationDamping + hydrostaticStiffness;
Zi = Gi./(1j*hydro.simulation_parameters.w');

% Zi2 isn't quite matching for some reason
Zi2 = -(1j*hydro.simulation_parameters.w'.*(mass+addedMass)) + radiationDamping + hydrostaticStiffness./(1j*hydro.simulation_parameters.w');

% Instead, I want the excitation force timeseries
t = linspace(0,100,1001);
F_wave = A*cos(omega*t)*hydro.hydro_coeffs.excitation.re(3,closestIndOmega)*simu.rho*simu.gravity - A*sin(omega*t)*hydro.hydro_coeffs.excitation.im(3,closestIndOmega)*simu.rho*simu.gravity;

figure()
plot(t,F_wave)
hold on
plot(output.bodies.time,output.bodies.forceExcitation(:,3))

% Calculate the response based on timeseries excitation and impedance
% impedance in frequency domain can be converted to transfer function
Zi_num = 1;
Zi_den = 1;
Zi_tf = tf(num, den);
