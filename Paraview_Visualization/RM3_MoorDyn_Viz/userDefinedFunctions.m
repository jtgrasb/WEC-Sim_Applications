%Example of user input MATLAB file for post processing

%Plot wave surface elevation
waves.plotElevation();

%Plot heave response for body 1
output.plotResponse(1,3);

%Plot heave response for body 2
output.plotResponse(2,3);

%Plot heave forces for body 1
output.plotForces(1,3);

%Plot pitch moments for body 2
output.plotForces(2,5);

%Save waves and response as video
output.saveViz(simu,body,waves,...
    'timesPerFrame',1,'axisLimits',[-150 150 -150 150 -50 20],...
    'startEndTime',[50 65]);