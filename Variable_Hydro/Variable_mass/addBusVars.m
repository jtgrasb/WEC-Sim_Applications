clear all
close all
clc

load_system('sphere.slx')

busSel = gcb('sphere/Float/Hydrodynamic Body/Structure');
set_param(gcb, 'OutputSignals', 'inertialMass, inertia');

% slx_object = Simulink.data.dictionary.open('sphere.slx');
% section = getSection(slx_object, 'Design Data');
% entries = find(section, '-value', '-class', 'Simulink.Bus');