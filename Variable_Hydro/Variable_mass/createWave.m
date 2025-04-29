clear all
close all
clc

natFreqs = [0.3979    0.3247    0.2865    0.2546    0.2292    0.2037    0.1751    0.1401    0.0987]; % from impedanceAnalysis.m

% create 100 s regular wave 
t = 0:0.1:100;
A = 1;

for ii = 1:length(natFreqs)

    f = natFreqs(ii);
    waveElevIndiv = sin(2*pi*f*t);
    if ii == 1
        wRamp = tukeywin(length(waveElevIndiv),0.1);
        waveElev(1+(length(t)*(ii-1)):ii*length(t)) = waveElevIndiv;
        waveElevRamp(1+(length(t)*(ii-1)):ii*length(t)) = wRamp'.*waveElevIndiv;
        tFull(1+(length(t)*(ii-1)):ii*length(t)) = t;
    else
        wRamp = tukeywin(length(waveElevIndiv(2:end)),0.1);
        waveElev(1+((length(t)-1)*(ii-1)):ii*(length(t)-1)) = waveElevIndiv(2:end);
        waveElevRamp(1+((length(t)-1)*(ii-1)):ii*(length(t)-1)) = wRamp'.*waveElevIndiv(2:end);
        tFull(1+((length(t)-1)*(ii-1)):ii*(length(t)-1)) = t(2:end) + max(t)*(ii-1);
    end
end

figure()
plot(tFull, waveElevRamp)
xlabel('time (s)')
ylabel('wave elevation (m)')

waveElevVec = [tFull', waveElevRamp'];
save 'elevationData.mat' waveElevVec