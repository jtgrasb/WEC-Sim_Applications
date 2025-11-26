close all;clear all;clc;

mcr = struct();
mcr.header = ["body(1).initial.displacement(1)","body(1).initial.displacement(2)","body(1).initial.displacement(3)"];

x = -100:25:100;
y = -100:25:100;
[x, y] = meshgrid(x,y);
x = x(:);
y = y(:);

for ii = 1:length(x)
    initDisp(ii,:) = [x(ii),y(ii),0];
end

mcr.cases = initDisp;

save mcrCases mcr

%% 
wecSimMCR

%% plot damping results

load mcrRes.mat

