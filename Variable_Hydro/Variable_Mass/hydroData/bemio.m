close all

for ii = 1:9

    hydro = struct();

    outName = ['draft' num2str(ii) '.out'];

    hydro = readWAMIT(hydro,outName,[]);
    hydro = radiationIRF(hydro,15,[],[],[],6);
    hydro = radiationIRFSS(hydro,[],[]);
    hydro = excitationIRF(hydro,15,[],[],[],[]);
    writeBEMIOH5(hydro)

end