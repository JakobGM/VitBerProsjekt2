% Task 8
% Plotting percentage of detected particles with mass around 28u and charge
% e with "random" entrances

clear;
close all;

atomicMassValues = 26:33;
V_DC = 7.15;
plotDetectedPercentage(atomicMassValues, V_DC)