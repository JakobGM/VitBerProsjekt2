% Task 4
% Plotting trajectory of N_2^+-particle in 3D
clear;
close all;

T = 20e-6; % total time
h = 1e-9;  % time step
plotSteps = 100; % steps per point plottet
IVPSolver = @eulerStep;

% Plot with initial conditions x_0=y_0=1mm, z_0=0, v_0=u_0=0, w_0=5000;
initialConditions = [1e-3, 1e-3, 0, 0, 0, 5000];

plotTrajectory3D(T, h, plotSteps, initialConditions, IVPSolver);