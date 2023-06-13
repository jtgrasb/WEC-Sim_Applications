%% Simulation Data
simu = simulationClass();               % Initialize Simulation Class
simu.simMechanicsFile = 'reactivePTO.slx';      % Specify Simulink Model File
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
body(1) = bodyClass('../hydroData/sphere.h5');          % Create the body(1) Variable
body(1).geometryFile = '../geometry/sphere.stl';        % Location of Geomtry File
body(1).mass = 'equilibrium';                           % Body Mass
body(1).inertia = [20907301 21306090.66 37085481.11];   % Moment of Inertia [kg*m^2]     

%% PTO and Constraint Parameters

% Translational PTO
pto(1) = ptoClass('PTO1');                      % Initialize PTO Class for PTO1
pto(1).stiffness = 0;                           % PTO Stiffness [N/m]
pto(1).damping = 0;                       % PTO Damping [N/(m/s)]
pto(1).location = [0 0 0];                      % PTO Location [m]

% PI Controller
controller(1).proportionalIntegral.Kp = 100; %4.9181e+04;
controller(1).proportionalIntegral.Ki = 0; %-5.7335e+05;

%% PTO new blocks

%Hydraulic Cylinder
ptoSim(1) = ptoSimClass('ptoSim1');
ptoSim(1).number  = 1;
ptoSim(1).type = 2;
ptoSim(1).hydPistonCompressible.xi_piston = 35;
ptoSim(1).hydPistonCompressible.Ap_A = 0.0378;
ptoSim(1).hydPistonCompressible.Ap_B = 0.0378;
ptoSim(1).hydPistonCompressible.bulkModulus = 1.86e9;
ptoSim(1).hydPistonCompressible.pistonStroke = 70;
ptoSim(1).hydPistonCompressible.pAi = 2.1333e7;
ptoSim(1).hydPistonCompressible.pBi = 2.1333e7;

%Rectifying Check Valve
ptoSim(2) = ptoSimClass('ptoSim2');
ptoSim(2).number = 2;
ptoSim(2).type = 4;
ptoSim(2).rectifyingCheckValve.Cd = 0.61;
ptoSim(2).rectifyingCheckValve.Amax = 0.002;
ptoSim(2).rectifyingCheckValve.Amin = 1e-8;
ptoSim(2).rectifyingCheckValve.pMax = 1.5e6;
ptoSim(2).rectifyingCheckValve.pMin = 0;
ptoSim(2).rectifyingCheckValve.rho = 850;
ptoSim(2).rectifyingCheckValve.k1 = 200;
ptoSim(2).rectifyingCheckValve.k2 = ...
    atanh((ptoSim(2).rectifyingCheckValve.Amin-(ptoSim(2).rectifyingCheckValve.Amax-ptoSim(2).rectifyingCheckValve.Amin)/2)*...
    2/(ptoSim(2).rectifyingCheckValve.Amax - ptoSim(2).rectifyingCheckValve.Amin))*...
    1/(ptoSim(2).rectifyingCheckValve.pMin-(ptoSim(2).rectifyingCheckValve.pMax + ptoSim(2).rectifyingCheckValve.pMin)/2);

%High Pressure Hydraulic Accumulator
ptoSim(3) = ptoSimClass('ptoSim3');
ptoSim(3).number  = 3;
ptoSim(3).type = 3;
ptoSim(3).gasHydAccumulator.vI0 = 8.5;
ptoSim(3).gasHydAccumulator.pIprecharge = 2784.7*6894.75;

%Low Pressure Hydraulic Accumulator
ptoSim(4) = ptoSimClass('ptoSim4');
ptoSim(4).number  = 4;
ptoSim(4).type = 3;
ptoSim(4).gasHydAccumulator.vI0 = 8.5;
ptoSim(4).gasHydAccumulator.pIprecharge = 1392.4*6894.75;

%Hydraulic Motor
ptoSim(5) = ptoSimClass('ptoSim5');
ptoSim(5).number  = 5;
ptoSim(5).type = 5;
ptoSim(5).hydraulicMotor.effModel = 2;
ptoSim(5).hydraulicMotor.displacement = 120;
ptoSim(5).hydraulicMotor.effTableShaftSpeed = linspace(0,2500,20);
ptoSim(5).hydraulicMotor.effTableDeltaP = linspace(0,200*1e5,20);
ptoSim(5).hydraulicMotor.effTableVolEff = ones(20,20)*0.9;
ptoSim(5).hydraulicMotor.effTableMechEff = ones(20,20)*0.85;

%Electric generator
ptoSim(6) = ptoSimClass('ptoSim6');
ptoSim(6).number = 6;
ptoSim(6).type = 1;
ptoSim(6).electricGeneratorEC.Ra = 0.8;
ptoSim(6).electricGeneratorEC.La = 0.8;
ptoSim(6).electricGeneratorEC.Ke = 0.8;
ptoSim(6).electricGeneratorEC.Jem = 0.8;
ptoSim(6).electricGeneratorEC.bShaft = 0.8;

% high-level control vars
kTime = 2.5; % proportional constant of controller for displacement of hydraulics to adjust pressure
pMax1 = 12*ptoSim(3).gasHydAccumulator.pIprecharge;
pMax2 = 12*ptoSim(4).gasHydAccumulator.pIprecharge;
ka1 = (ptoSim(3).gasHydAccumulator.vI0 + ptoSim(4).gasHydAccumulator.vI0)/(pMax1 - ptoSim(3).gasHydAccumulator.pIprecharge);
ka2 = (ptoSim(3).gasHydAccumulator.vI0 + ptoSim(4).gasHydAccumulator.vI0)/(pMax2 - ptoSim(4).gasHydAccumulator.pIprecharge);

% 
% iMax = 100; % max current in generator
% KpShaft = 1e3; % proportional constant of controller for shaft
