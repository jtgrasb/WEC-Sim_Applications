clear all
close all
clc

draftVals = 1:9;

for draftInd = 1:length(draftVals)
    draft = draftVals(draftInd);
    wecSim;
    natPeriods(draftInd) = natPeriod;
end

figure()
plot(draftVals,natPeriods)
xlabel('draft (m)')
ylabel('natural period (s)')