function body1_hydroForceIndex  = calcIndex(time)

% calculate the index based on the current wave conditions
body1_hydroForceIndex = floor(time/100) + 1; % switch at every 100 seconds

if body1_hydroForceIndex > 9
    body1_hydroForceIndex = 9;
end

% body1_hydroForceIndex = 5;

end
