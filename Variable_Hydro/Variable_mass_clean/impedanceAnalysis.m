% This script identifies the dynamics of the float in the respective wave 
% conditions and determines the optimal proportional gain value for a 
% passive controller (for regular waves)
clear all
close all
clc

draftVals = 1:9;
figure()

for ii = 1:length(draftVals)

    % Load hydrodynamic data for float from BEM
    filename = ['hydroData/WAMIT/draft' num2str(draftVals(ii)) '.h5'];
    hydro = readH5ToStruct(filename);
    rho = 1000;
    gravity = 9.81;
    
    ptoDamping = 0;

    % Define the intrinsic mechanical impedance for the device
    mass = rho*hydro.Vo;
    addedMass = squeeze(hydro.A(3,3,:))*rho;
    radiationDamping = squeeze(hydro.B(3,3,:)).*squeeze(hydro.w')*rho + ptoDamping;
    hydrostaticStiffness = hydro.Khs(3,3)*rho*gravity;
    Gi = -((hydro.w)'.^2.*(mass+addedMass)) + 1j*hydro.w'.*radiationDamping + hydrostaticStiffness;
    Zi = Gi./(1j*hydro.w');
    
    % Calculate magnitude and phase for bode plot
    Mag = 20*log10(abs(Zi));
    Phase = (angle(Zi))*(180/pi);

    % calculate natural frequency
    [~,closestIndNat] = min(abs(imag(Zi)));
    natFreqs(ii) = hydro.w(closestIndNat)/(2*pi); % Hz
        
    % Create bode plot for impedance
    subplot(2,1,1)
    semilogx((hydro.w)/(2*pi),Mag)
    hold on
    
    subplot(2,1,2)
    semilogx((hydro.w)/(2*pi),Phase)
    hold on

    legendLabel{ii} = ['draft = ' num2str(draftVals(ii)) ' m'];
end

subplot(2,1,1)
xlabel('freq (hz)')
ylabel('mag (dB)')
xlim([1e-2, 1e0])
ylim([80, 140])
grid on

subplot(2,1,2)
xlabel('freq (hz)')
ylabel('phase (deg)')
grid on
xlim([1e-2, 1e0])
ylim([-100, 100])
legend(legendLabel,"Location","west")