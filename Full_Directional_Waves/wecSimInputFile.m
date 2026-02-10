%% Simulation Data
simu = simulationClass();                    % Initialize Simulation Class
simu.simMechanicsFile = 'OSWEC.slx';         % Specify Simulink Model File
simu.mode      = 'normal';                   % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer  = 'on';                       % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                          % Simulation Start Time [s]
simu.endTime   = 400;                        % Simulation End Time [s]
simu.rampTime  = 100;                        % Wave Ramp Time [s]
simu.solver    = 'ode4';                     % simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt        = 0.05; 					  	 % Simulation time-step [s]
simu.cicEndTime = 30;

%% Wave Information 

% Full directional waves base case
waves = waveClass('spectrumImportFullDir');
waves.spectrumFile = ('fullDirSpectrum.mat');
waves.phaseSeed = 1;

% % Uncomment this section to run full directional waves with conversion from OOI
% load dirSpectrumOOI.mat
% spectrumDataOOI = dataWaveSnip;
% directions = -179:2:179;
% 
% [frequencies, spectrum, spread, directions] = convertOOIToIEC(spectrumDataOOI, directions, 1);
% 
% save 'fullDirSpectrumOOI.mat' spectrum spread frequencies directions
% 
% waves = waveClass('spectrumImportFullDir');
% waves.spectrumFile = ('fullDirSpectrumOOI.mat');
% waves.phaseSeed = 1;

%% Body Data
% Flap
body(1) = bodyClass('../_Common_Input_Files/OSWEC/hydroData/oswec.h5');      % Initialize bodyClass for Flap
body(1).geometryFile = '../_Common_Input_Files/OSWEC/geometry/flap.stl';     % Geometry File
body(1).mass = 127000;                          % User-Defined mass [kg]
body(1).inertia = [1.85e6 1.85e6 1.85e6];       % Moment of Inertia [kg-m^2]

% Base
body(2) = bodyClass('../_Common_Input_Files/OSWEC/hydroData/oswec.h5');      % Initialize bodyClass for Base
body(2).geometryFile = '../_Common_Input_Files/OSWEC/geometry/base.stl';     % Geometry File
body(2).mass = 999;                             % Placeholder mass for a fixed body
body(2).inertia = [999 999 999];                % Placeholder inertia for a fixed body

%% PTO and Constraint Parameters
% Fixed
constraint(1)= constraintClass('Constraint1');  % Initialize ConstraintClass for Constraint1
constraint(1).location = [0 0 -10];             % Constraint Location [m]

% Rotational PTO
pto(1) = ptoClass('PTO1');                      % Initialize ptoClass for PTO1
pto(1).stiffness = 0;                           % PTO Stiffness Coeff [Nm/rad]
pto(1).damping = 12000;                         % PTO Damping Coeff [Nsm/rad]
pto(1).location = [0 0 -8.9];                   % PTO Location [m]
