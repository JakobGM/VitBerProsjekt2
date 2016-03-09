% oppg5
% Plotting trajectory of N_2^+-particle in 3D
clear;
close all;

T = 20*10^(-6); % total time
h = 1*10^(-9);  % time step
IVPSolver = @eulerstep;
ydot = @ydot_oppg3; % rhs-equations
r_0 = 3*10^(-3); % electrode distance to origo

% Plot with initial conditions x_0=1mm, y_0=0, v_0=u_0=0
initialConditions = [1*10^(-3), 0, 0, 0];

plotError(T, h, initialConditions, IVPSolver, ydot);
