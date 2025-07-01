clear all
close all
clc

%% Body Data
% Define h5 files for the sphere
radius = 5;
rho = 1025;
draftVals = 1:9;
natFreqs = [0.3979    0.3247    0.2865    0.2546    0.2292    0.2037    0.1751    0.1401    0.0987]; % from impedanceAnalysis.m

mcrManual = {};

for imcrManual = 1:length(draftVals)
    h5File = ['hydroData/draft' num2str(draftVals(imcrManual)), '.h5'];

    fullVolume = (4/3)*pi*radius^3;
    immersedVolume = (1/3)*pi*draftVals(imcrManual)^2*(3*radius - draftVals(imcrManual));
    massVal = rho*immersedVolume; 
    inertiaVal = (immersedVolume/fullVolume)*2*[20907301 21306090.66 37085481.11];
    if imcrManual > 1
        zDisp = 1;
    else
        zDisp = 0;
    end

    wecSim

    mcrManual(imcrManual).position = output.bodies(1).position;
    mcrManual(imcrManual).cgDisp = cgDisp;
    mcrManual(imcrManual).hsMass = hsMass;
    mcrManual(imcrManual).hsVolume = hsVolume;

end


