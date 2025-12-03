function [frequenciesIEC, spectrumIEC, spreadIEC, directionsIEC] = convertOOIToIEC(spectrumDataOOI, directionBins, plotFlag)

    directionBins = wrapTo180(directionBins);
    if any(directionBins == 180) && any(directionBins == -180)
        warning('Directions include both -180 and 180. Removing -180 to avoid duplicate directions.')
        directionBins(directionBins == -180) = [];
    end
    if length(unique(mod(directionBins + 180, 360) - 180)) < length(directionBins)
        error('Duplicate directions were found.')
    end
    
    frequenciesOOI = spectrumDataOOI(:,1);
    spectrumOOI = spectrumDataOOI(:,2);
    directionsOOI = spectrumDataOOI(:,3);
    spreadOOI = spectrumDataOOI(:,4);
    
    % convert to IEC: 
    directionsIEC = directionBins(:);
    frequenciesIEC = frequenciesOOI;
    spectrumIEC = spectrumOOI;
    spreadIEC = zeros(length(frequenciesIEC),length(directionsIEC));
    
    % for spread, we need to apply gaussian distribution
    for ii = 1:length(frequenciesOOI)
        % convert to IEC spread calculation
        directions = deg2rad(wrapTo180(directionBins - wrapTo180(directionsOOI(ii))));
        energySpread = (1./(deg2rad(spreadOOI(ii)).*sqrt(2*pi))) .* exp(-(directions.^2) ./ (2.*deg2rad(spreadOOI(ii)).^2));
        checkSum = trapz(deg2rad(directionBins),energySpread);
        if checkSum < 0.95 % if this is true, then less than 95% of the initial energy at this frequency is contained over the considered directions.
            warning('Number of directional bins inadequate at frequency number %i. Directional approximation weak. \n \r', ii);
        end
        energySpread = energySpread./checkSum;
        spreadIEC(ii,:) = energySpread;
    end

    if plotFlag == 1
        spectrumFullDir = spreadIEC.*spectrumIEC;
        meanDirection = sum(wrapTo180(directionsOOI).*spectrumOOI)/sum(spectrumOOI);

        [plotDirs,plotFreqs] = meshgrid(directionsIEC,frequenciesIEC);
    
        figure()
        polarscatter(deg2rad(plotDirs(:)),plotFreqs(:),4,spectrumFullDir(:),'filled')
        hold on
        polarplot(deg2rad([meanDirection meanDirection]), [0 max(plotFreqs(:))], 'k--'); % 
        c = colorbar;
        c.Label.String = 'Spectrum (m^2/Hz/deg)';
        title('Elevation variance spectrum');
        legend('spectrum','approx. mean direction','Location','northwest')
    end
end