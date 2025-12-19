%% Simulation Data
simu = simulationClass();               % Initialize Simulation Class
simu.simMechanicsFile = 'sphereMooring.slx';      % Specify Simulink Model File
simu.mode = 'normal';                   % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer = 'on';                   % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                     % Simulation Start Time [s]
simu.rampTime = 40;                    % Wave Ramp Time [s]
simu.endTime = 400;                     % Simulation End Time [s]
simu.solver = 'ode4';                   % simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt = 0.02; 							% Simulation time-step [s]
simu.mcrMatFile = 'mcrCases.mat';
simu.cicEndTime = 15;

%% Wave Information 
waves = waveClass('noWave');           % Initialize Wave Class and Specify Type                                 
waves.period = 4;                       % Wave Period [s] - this wave period was chosen to match up with one of the BEM wave periods

% Regular Waves  
% waves = waveClass('regular');           % Initialize Wave Class and Specify Type                                 
% waves.height = 0.2;                     % Wave Height [m]
% waves.period = 4;                       % Wave Period [s] - this wave period was chosen to match up with one of the BEM wave periods
% waves.phaseSeed = 1;

% waves = waveClass('irregular');           % Initialize Wave Class and Specify Type
% waves.height = 1;                       % Significant Wave Height [m]
% waves.period = 5;                         % Peak Period [s]
% waves.spectrumType = 'PM';                % Specify Wave Spectrum Typ
% waves.phaseSeed = 1;

%% Body Data
% Define h5 files for the sphere
bemDisps = [0 4]; % need to update with finer discretization later
% files = strings(1, length(bemDisps));
for ii = 1:length(bemDisps)
    files{ii} = ['hydroData/h5s_phaseShift/sphere' strrep(num2str(bemDisps(ii), '%.2f'), '.', '_') '.h5'];
end

% Sphere
body(1) = bodyClass(files);          % Create the body(1) Variable
% body(1) = bodyClass('hydroData/h5s_phaseShift/sphere4_00.h5');
% body(1) = bodyClass('../../_Common_Input_Files/Sphere/hydroData/sphere.h5');
body(1).geometryFile = '../../_Common_Input_Files/Sphere/geometry/sphere.stl';        % Location of Geomtry File
body(1).mass = 'equilibrium';                           % Body Mass
body(1).inertia = [20907301 21306090.66 37085481.11];   % Moment of Inertia [kg*m^2]     
body(1).initial.displacement = [0 0 0];
body(1).largeXYDisplacement.option = 0;
body(1).variableHydro.option = 1;
body(1).variableHydro.hydroForceIndexInitial = 1; % default = 10 deg incident wave

%% PTO and Constraint Parameters
% Floating (3DOF) Joint
constraint(1) = constraintClass('Constraint1'); % Initialize Constraint Class for Constraint1
constraint(1).location = [0 0 0];               % Constraint Location [m]

% Add mooring pretension to pull sphere
% mooring(1) = mooringClass('mooring');           % Initialize mooringClass
% mooring(1).location = [0 0 -2];
% mooring(1).initial.displacement = [0 0 0];
% mooring(1).matrix.preTension = [0 0 0 0 0 0]; % 1e4