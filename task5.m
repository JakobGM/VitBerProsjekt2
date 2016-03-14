% Task 5
% Plotting error of numerical solutions for different time steps
clear;
close all;

% Generate plot with timesteps defined i h_vec
h_vec = 10.^(-9:0.05:-7.5);
plotMaxError(h_vec);