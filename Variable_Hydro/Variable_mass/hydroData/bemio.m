%% Read OSWEC hydro data
hydro = struct();
hydro = readWAMIT(hydro,'../../../_Common_Input_Files/Sphere/hydroData/sphere.out',[]);
hydro = radiationIRF(hydro,40,[],[],[],[]);
hydro = radiationIRFSS(hydro,[],[]);
hydro = excitationIRF(hydro,40,[],[],[],[]);

writeBEMIOH5(hydro)

%% Plot hydro data
plotBEMIO(hydro)