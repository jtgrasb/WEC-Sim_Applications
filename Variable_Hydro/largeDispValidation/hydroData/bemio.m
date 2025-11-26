hydro = struct();

hydro = readCAPYTAINE(hydro,'outputs_x2.0y-2.0.nc/sphere_x2.0y-2.0.nc');
hydro = radiationIRF(hydro,15,[],[],[],[]);
% hydro = radiationIRFSS(hydro,[],[]);
hydro = excitationIRF(hydro,15,[],[],[],[]);
writeBEMIOH5(hydro)
plotBEMIO(hydro)

