%% Simulation Data
simu = simulationClass();                       % Initialize Simulation Class
simu.simMechanicsFile = 'sphere.slx';            % Specify Simulink Model File
simu.mode = 'normal';                           % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer = 'on';                          % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                             % Simulation Start Time [s]
simu.rampTime = 40;                            % Wave Ramp Time [s]
simu.endTime = 100;                             % Simulation End Time [s]        
simu.solver = 'ode4';                           % simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt = 0.01;                                 % Simulation Time-Step [s]
simu.cicEndTime = 15;                           % Specify CI Time [s]
simu.rho = 1025;

%% Wave Information
% % noWaveCIC, no waves with radiation CIC  
% waves = waveClass('noWaveCIC');       % Initialize Wave Class and Specify Type 

% % Regular Waves  
waves = waveClass('regular');           % Initialize Wave Class and Specify Type                                 
waves.height = 2.5;                     % Wave Height [m]
waves.period = 8;                       % Wave Period [s]

%% Body Data
% Define h5 files for the sphere
r = 5;
rho = 1025;
draftVals = 1:9;

for ii = 1:length(draftVals)
    h5Files{ii} = ['hydroData/WAMIT/draft' num2str(draftVals(ii)), '.h5'];

    fullVolume = (4/3)*pi*r^3;
    immersedVolume = (1/3)*pi*draftVals(ii)^2*(3*r - draftVals(ii));
    massVal(ii) = rho*immersedVolume;
    inertiaVal(ii,:) = (immersedVolume/fullVolume)*2*[20907301 21306090.66 37085481.11];
end

% sphere
body(1) = bodyClass(h5Files);  % Initialize bodyClass for Flap
body(1).geometryFile = 'geometry/sphere.stl';  % Geometry File
body(1).mass = 'equilibrium';                           % User-Defined mass [kg]
% body(1).mass = [1e5, 2e5];
body(1).inertia = inertiaVal(5,:);   % Moment of Inertia [kg*m^2]
body(1).initial.displacement = [0, 0, 0];
body(1).variableHydro.option = 1;
body(1).variableHydro.hydroForceIndexInitial = 5;

% body(1).variableHydro.option = 1;
% body(1).variableHydro.hydroForceIndexInitial = find(bemDirections==10); % default = 10 deg incident wave

%% PTO and Constraint Parameters
pto(1) = ptoClass('PTO1');                      % Initialize ptoClass for PTO1
pto(1).stiffness = 0;                           % PTO Stiffness Coeff [Nm/rad]
pto(1).damping = 0;                        % PTO Damping Coeff [Nsm/rad]
pto(1).location = [0 0 0];                   % PTO Location [m]