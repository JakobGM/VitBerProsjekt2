% Task 3
% Plotting trajectories of N_2^+-particle in 2D with the "forward Euler" 
% method
clear;
close all;

% Parameters
T = 20e-6; % total time
h = 1e-9;  % time step
plotSteps = 100; % steps per point plotted
IVPSolver = @eulerStep;

% Plot with initial conditions x_0 = y_0 = 1mm, v_0 = u_0 = 0
initialConditions1 = [1e-3, 1e-3, 0, 0];
plotTrajectory2D(T, h, plotSteps, initialConditions1, IVPSolver);

% Plot with initial conditions x_0 = 1mm, y_0 = 0, v_0 = u_0 = 0
initialConditions2 = [1e-3, 0, 0, 0];
plotTrajectory2D(T, h, plotSteps, initialConditions2, IVPSolver);
