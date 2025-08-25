%% OWC - WAMIT GBM simulation
%% Define the despiking structure
despike = struct();
despike.negThresh = 1e-3; % the threshold below which negative damping will be removed
despike.N = 5; % will loop the despiking procedure N time before filtering
despike.appFilt = 1; % boolean, 1 to apply low pass filter after despiking

% thresholds: applied to 'Threshold' argument of findpeaks
despike.B.Threshold = 2e-4; % damping
despike.A.Threshold = 1e-3; % added mass
despike.ExRe.Threshold = 1e-3; % real part excitation
despike.ExIm.Threshold = 1e-3; % imag part excitation

% minimum peak prominence, applied to 'MinPeakProminence' argument of findpeaks
despike.B.Prominence = 2e-4;
despike.A.Prominence = 1e-3;
despike.ExRe.Prominence = 1e-3;
despike.ExIm.Prominence = 1e-3;

% minimum peak distance, applied to 'MinPeakDistance' argument of findpeaks
despike.A.MinPeakDistance = 3;
despike.B.MinPeakDistance = 3;
despike.ExRe.MinPeakDistance = 3;
despike.ExIm.MinPeakDistance = 3;

% the b and a inputs to MATLAB's filtfilt(b,a,x) function
despike.Filter.b = 0.02008336556421123561544384017452102853 .* [1 2 1];
despike.Filter.a = [1 -1.561018075800718163392843962355982512236 0.641351538057563175243558362126350402832];

%% Read and clean WAMIT results
hydro = struct();
hydro = readWAMIT(hydro,'test17a.out',[]);
hydro = cleanBEM(hydro,despike);
hydro.file = 'test17a_clean';

hydro = radiationIRF(hydro,20,[],[],[],11);
hydro = radiationIRFSS(hydro,20,[]);
hydro = excitationIRF(hydro,20,[],[],[],11);

hydro.plotDofs = [1,1;3,3;5,5;7,7];
% plotBEMIO(hydro);

writeBEMIOH5(hydro);
