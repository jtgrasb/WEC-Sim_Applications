function body1_hydroForceIndex = calcIndex(time)

body1_hydroForceIndex = floor(time/100) + 1; % Increase the mass every 100 seconds

if body1_hydroForceIndex > 9
    body1_hydroForceIndex = 9; % restrict to 9 (# of hydrodata files)
end

end
