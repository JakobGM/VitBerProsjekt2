% Task 8
% Plotting percentage of detected particles with mass around 28u and charge
% 2e with "random" entrances

clear;
close all;

T = 20e-6; % total time
h = 1e-7;  % time step
u = 1.66054e-27; % atomic mass unit
atomicMass = 26:32;
detectedPercentage = zeros(1, length(atomicMass));

for i = 1:length(atomicMass)
    mass = atomicMass(i)*u;
    detectedPercentage(i) = getDetectedPercentage(h, mass);
end

plot(atomicMass, detectedPercentage, 'o');