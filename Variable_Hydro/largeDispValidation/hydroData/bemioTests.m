close all
clear all
clc

%% check h5 cg's

newX = 0:.05:27;

hydro_35 = struct();
hydro_35 = readH5ToStruct('h5s_phaseShift/sphere3_50.h5');
hydro_35 = addDefaultPlotVars(hydro_35);
hydro_375 = struct();
hydro_375 = readH5ToStruct('h5s_phaseShift/sphere3_75.h5');
hydro_375 = addDefaultPlotVars(hydro_375);
hydro_38 = struct();
hydro_38 = readH5ToStruct('h5s_phaseShift/sphere3_80.h5');
hydro_38= addDefaultPlotVars(hydro_38);
hydro_385 = struct();
hydro_385 = readH5ToStruct('h5s_phaseShift/sphere3_85.h5');
hydro_385 = addDefaultPlotVars(hydro_385);
hydro_4 = struct();
hydro_4 = readH5ToStruct('h5s_phaseShift/sphere4_00.h5');
hydro_4 = addDefaultPlotVars(hydro_4);
plotExcitationPhase(hydro_35,hydro_375,hydro_38,hydro_385,hydro_4)

% for ii = 1:length(newX)


%%
hydro = struct();

% hydro = readWAMIT(hydro,'../../../_Common_Input_Files/Sphere/hydroData/sphere.out',[]);
hydro = readH5ToStruct('../../../_Common_Input_Files/Sphere/hydroData/sphere.h5');
% hydro = radiationIRF(hydro,15,[],[],[],[]);
% hydro = radiationIRFSS(hydro,[],[]);
% hydro = excitationIRF(hydro,15,[],[],[],[]);
% writeBEMIOH5(hydro)
hydro = addDefaultPlotVars(hydro);

% shift excitation coefficients
xVec = 0:5:20;
gravity = 9.81;
wavenumber = hydro.w.^2./gravity; % k

hydroArray = cell(length(xVec),1);
hydroArray{1} = hydro;

for ii = 2:length(xVec)
    phaseShift(ii,:) = wavenumber.*hydro.w.*(xVec(ii)*cos(0));
    % expPhaseShift(ii,:) = exp(phaseShift(ii,:)*1j);

    hydroArray{ii+1} = hydro;
    hydroArray{ii+1}.ex_ph = wrapToPi(hydroArray{ii+1}.ex_ph + reshape(repmat(phaseShift(ii,:),6,1),[6,1,240]));
    hydroArray{ii+1}.ex_re = hydroArray{ii+1}.ex_ma.*cos(hydroArray{ii+1}.ex_ph);
    hydroArray{ii+1}.ex_im = hydroArray{ii+1}.ex_ma.*sin(hydroArray{ii+1}.ex_ph);
end

% fExc = hydro.ex_re + 1j*hydro.ex_im;
% fExcShifted = fExc*exp(phaseShift(2,:)*1j);
% hydro.ex_re = real(fExcShifted);
% hydro.ex_im = imag(fExcShifted);
% hydro.ex_ma = abs(fExcShifted);
% hydro.ex_ph = angle(fExcShifted);

plotExcitationMagnitude(hydroArray{:});
plotExcitationPhase(hydroArray{:});

% plotBEMIO(hydro)
