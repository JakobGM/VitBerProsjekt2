% Task 3
% Plotting trajectories of N_2^+-particle in 2D
clear;
close all;

% test
V_DC = 5; % DC-voltage
m = 28*1.66e-27; % particle mass
q = 1.60e-19; % particle charge
r_0 = 3e-3; % electrode distance to origo
T = sqrt(m*r_0^2/(2*V_DC*q))*10*pi; % total time (5 periods)
% test end

%T = 20e-6; % total time
h = 1e-7;  % time step
plotSteps = 1; % steps per point plotted
IVPSolver = @RK4;
ydot = @ydot_V_DC; % rhs-equations

% Plot with initial conditions x_0=y_0=1mm, v_0=u_0=0
% initialConditions = [1e-3, 1e-3, 0, 0];

% Plot with initial conditions x_0=1mm, y_0=0, v_0=u_0=0
initialConditions = [1e-3, 0, 0, 0];

plotTrajectory2D(T, h, plotSteps, initialConditions, IVPSolver, ydot);