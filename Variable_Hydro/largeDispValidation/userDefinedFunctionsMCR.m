%% User Defined Functions for MCR run

mcr.pos(imcr,:) = output.bodies(1).position(3,:);
mcr.vel(imcr,:) = output.bodies(1).velocity(3,:);

if imcr == length(mcr.cases)
    save(['mcrRes.mat'],'mcr')

end