% Task 3
% Plotting trajectories of N_2^+-particle in 2D with the "forward Euler" 
% method
clear;
close all;

% Physical test parameters
V_DC = 5; % DC-voltage
u = 1.66054e-27; % 1 atomic mass unit
m = 28*u; % particle mass
q = 1.60217646e-19; % particle charge
r_0 = 3e-3; % electrode distance from origo
T = sqrt(m*r_0^2/(2*V_DC*q))*10*pi; % total time (5 periods), approximately 20 microseconds

% Method parameters
h = 1e-9;  % time step
plotSteps = 100; % steps per point plotted
IVPSolver = @rk4Step;

% Plot with initial conditions x_0 = y_0 = 1mm, v_0 = u_0 = 0
initialConditions1 = [1e-3, 1e-3, 0, 0];

% Plot with initial conditions x_0 = 1mm, y_0 = 0, v_0 = u_0 = 0
initialConditions2 = [1e-3, 0, 0, 0];

plotTrajectory2D(T, h, plotSteps, initialConditions1, IVPSolver);
plotTrajectory2D(T, h, plotSteps, initialConditions2, IVPSolver);
