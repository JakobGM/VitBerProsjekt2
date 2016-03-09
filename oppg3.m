% Task 3
% Plotting trajectories of N_2^+-particle in 2D
clear;
close all;

T = 20e-6; % total time
h = 1e-9;  % time step
plotSteps = 100; % steps per point plotted
IVPSolver = @eulerstep;
ydot = @ydot_oppg3and5; % rhs-equations
r_0 = 3e-3; % electrode distance to origo

% Plot with initial conditions x_0=y_0=1mm, v_0=u_0=0
% initialConditions = [1e-3, 1e-3, 0, 0];

% Plot with initial conditions x_0=1mm, y_0=0, v_0=u_0=0
initialConditions = [1e-3, 0, 0, 0];

plotTrajectory2D(T, h, plotSteps, initialConditions, r_0, IVPSolver, ydot);