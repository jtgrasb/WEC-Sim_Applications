%% Simulation Data
simu = simulationClass();                       % Initialize Simulation Class
simu.simMechanicsFile = 'sphereVarMass.slx';    % Specify Simulink Model File
simu.mode = 'normal';                           % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer = 'on';                           % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                             % Simulation Start Time [s]
simu.rampTime = 0;                              % Wave Ramp Time [s]
simu.endTime = 900;                             % Simulation End Time [s]        
simu.solver = 'ode4';                           % simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt = 0.01;                                 % Simulation Time-Step [s]
simu.cicEndTime = 15;                           % Specify CI Time [s]
simu.dtOut = 0.1;
simu.rho = 1025;

%% Wave Information
% Regular Waves  
waves = waveClass('regular');           % Initialize Wave Class and Specify Type                                 
waves.height = 1;                     % Wave Height [m]
waves.period = 8;                       % Wave Period [s]

%% Body Data
% Define h5 files for the sphere
radius = 5;
rho = 1025;
draftVals = 1:9;
natFreqs = [0.3979    0.3247    0.2865    0.2546    0.2292    0.2037    0.1751    0.1401    0.0987]; % from impedanceAnalysis.m

for ii = 1:length(draftVals)
    h5Files{ii} = ['hydroData/draft' num2str(draftVals(ii)), '.h5'];

    fullVolume = (4/3)*pi*radius^3;
    immersedVolume = (1/3)*pi*draftVals(ii)^2*(3*radius - draftVals(ii));
    massVals(ii) = rho*immersedVolume; 
    inertiaVals(ii,:) = (immersedVolume/fullVolume)*2*[20907301 21306090.66 37085481.11];
end

% Sphere
body(1) = bodyClass(h5Files);
body(1).geometryFile = '../../_Common_Input_Files/Sphere/geometry/sphere.stl';
body(1).mass = 'equilibrium';
body(1).inertia = inertiaVals(5,:);
body(1).initial.displacement = [0, 0, 0];
body(1).variableHydro.option = 1;
body(1).variableHydro.hydroForceIndexInitial = 1;
body(1).variableHydro.mass = massVals; % 'equilibrium' for each sphere size. If not set, equilibrium will be assumed by WEC-Sim.
body(1).variableHydro.inertia = inertiaVals;

%% PTO and Constraint Parameters
pto(1) = ptoClass('PTO1');                   % Initialize ptoClass for PTO1
pto(1).stiffness = 0;                        % PTO Stiffness Coeff [Nm/rad]
pto(1).damping = 2e5;                        % PTO Damping Coeff [Nsm/rad]
pto(1).location = [0 0 0];                   % PTO Location [m]
