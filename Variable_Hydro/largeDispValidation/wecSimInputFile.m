%% Simulation Data
simu = simulationClass();               % Initialize Simulation Class
simu.simMechanicsFile = 'sphere.slx';      % Specify Simulink Model File
simu.mode = 'normal';                   % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer = 'on';                   % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                     % Simulation Start Time [s]
simu.rampTime = 10;                    % Wave Ramp Time [s]
simu.endTime = 100;                     % Simulation End Time [s]
simu.solver = 'ode4';                   % simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt = 0.02; 							% Simulation time-step [s]
simu.mcrMatFile = 'mcrCases.mat';
simu.cicEndTime = 15;

%% Wave Information 

% Regular Waves  
% waves = waveClass('regular');           % Initialize Wave Class and Specify Type                                 
% waves.height = 1;                     % Wave Height [m]
% waves.period = 5;                       % Wave Period [s] - this wave period was chosen to match up with one of the BEM wave periods

waves = waveClass('irregular');           % Initialize Wave Class and Specify Type
waves.height = 0.5;                       % Significant Wave Height [m]
waves.period = 4;                         % Peak Period [s]
waves.spectrumType = 'PM';                % Specify Wave Spectrum Typ

%% Body Data
% Sphere
body(1) = bodyClass('../../_Common_Input_Files/Sphere/hydroData/sphere.h5');          % Create the body(1) Variable
% body(1) = bodyClass('hydroData/sphere_x2.0y-2.0.h5');          % Create the body(1) Variable
body(1).geometryFile = '../../_Common_Input_Files/Sphere/geometry/sphere.stl';        % Location of Geomtry File
body(1).mass = 'equilibrium';                           % Body Mass
body(1).inertia = [20907301 21306090.66 37085481.11];   % Moment of Inertia [kg*m^2]     
body(1).initial.displacement = [0 0 0];
body(1).largeXYDisplacement.option = 1;

%% PTO and Constraint Parameters
% Floating (3DOF) Joint
constraint(1) = constraintClass('Constraint1'); % Initialize Constraint Class for Constraint1
constraint(1).location = [0 0 0];               % Constraint Location [m]