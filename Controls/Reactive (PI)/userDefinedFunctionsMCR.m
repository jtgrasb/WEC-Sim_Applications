%% User Defined Functions for MCR run
controllersOutput = controller1_out;
signals = {'force','power'};
for ii = 1:length(controllersOutput)
    for jj = 1:length(signals)
        controllersOutput(ii).(signals{jj}) =  controllersOutput(ii).signals.values(:,(jj-1)*6+1:(jj-1)*6+6);
    end
end

endInd = length(controllersOutput.power);
startTime = controllersOutput.time(end) - 10*waves.period; % select last 10 periods
[~,startInd] = min(abs(controllersOutput.time(:) - startTime));

mcr.meanPower(imcr) = mean(controllersOutput.power(startInd:endInd,3));
mcr.meanForce(imcr) = mean(controllersOutput.force(startInd:endInd,3));

mcr.maxPower(imcr) = max(controllersOutput.power(startInd:endInd,3));
mcr.maxForce(imcr) = max(controllersOutput.force(startInd:endInd,3));

if imcr == 81

    % Kp and Ki gains
    kps = unique(mcr.cases(:,1));
    kis = unique(mcr.cases(:,2));

    i = 1;
    for kpIdx = 1:length(kps)
        for kiIdx = 1:length(kis)
            meanPowerMat(kiIdx, kpIdx) = mcr.meanPower(i);
            i = i+1;
        end
    end

    % Plot surface for controller power at each gain combination
    figure()
    surf(kps,kis,meanPowerMat)
    % Create labels
    zlabel('Mean Controller Power (W)');
    ylabel('Integral Gain/Stiffness (N/m)');
    xlabel('Proportional Gain/Damping (Ns/m)');
    % Set color bar and color map
    %C = colorbar('location','EastOutside');
    colormap(jet);
    %set(get(C,'XLabel'),'String','Power (Watts)')
    % Create title
    title('Mean Power vs. Proportional and Integral Gains');
end