%% Simulation Data
simu = simulationClass();               % Initialize Simulation Class
simu.simMechanicsFile = 'sphereImpedance.slx';      % Specify Simulink Model File
simu.mode = 'normal';                   % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer = 'off';                   % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                     % Simulation Start Time [s]
simu.rampTime = 50;                    % Wave Ramp Time [s]
simu.endTime = 200;                     % Simulation End Time [s]
simu.solver = 'ode4';                   % simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt = 0.02; 							% Simulation time-step [s]
simu.mcrMatFile = 'mcrCases.mat';

%% Wave Information
% Regular Waves  
waves = waveClass('regular');           % Initialize Wave Class and Specify Type                                 
waves.height = 2.5;                     % Wave Height [m]
waves.period = 9.6664;                       % Wave Period [s]

%% Body Data
% Sphere
body(1) = bodyClass('hydroData/sphere.h5');          % Create the body(1) Variable
body(1).geometryFile = 'geometry/sphere.stl';        % Location of Geomtry File
body(1).mass = 'equilibrium';                           % Body Mass
body(1).inertia = [20907301 21306090.66 37085481.11];   % Moment of Inertia [kg*m^2]   

%% PTO and Constraint Parameters

% Translational PTO
pto(1) = ptoClass('PTO1');                      % Initialize PTO Class for PTO1
pto(1).stiffness = 0;                           % PTO Stiffness [N/m]
pto(1).damping = 12000;                       % PTO Damping [N/(m/s)]
pto(1).location = [0 0 0];                      % PTO Location [m]

% PI Controller
%controller(1).proportionalIntegral.Kp = 4.9181e+04;
%controller(1).proportionalIntegral.Ki = -5.7335e+05;


% create transfer function based on closest frequency
tmp_hydroData = readBEMIOH5(body(1).h5File, 1, body(1).meanDrift);
body(1).loadHydroData(tmp_hydroData);

w = 2*pi/waves.period;
addedMass = squeeze(body(1).hydroData.hydro_coeffs.added_mass.all(3,3,:))*simu.rho;
radiationDamping = squeeze(body(1).hydroData.hydro_coeffs.radiation_damping.all(3,3,:)).*squeeze(body(1).hydroData.simulation_parameters.w')*simu.rho;

m = body(1).hydroData.properties.volume*simu.rho;
A = interp1(body(1).hydroData.simulation_parameters.w,addedMass,w,'spline');
B = interp1(body(1).hydroData.simulation_parameters.w,radiationDamping,w,'spline');
K_hs = body(1).hydroData.hydro_coeffs.linear_restoring_stiffness(3,3)*simu.rho*simu.gravity;

% Calculate the response based on timeseries excitation and impedance
% impedance in frequency domain can be converted to transfer function
%  = (-(m+A)s^2 + Bs + C_hs)/s - flip to calculate velocity from force!
Zi_den = [(m+A), B, K_hs]; % at thirteenth (wave) frequency
Zi_num = [1, 0];
Zi_tf = tf(Zi_num, Zi_den);


