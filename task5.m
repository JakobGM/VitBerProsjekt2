% oppg5
% Plotting trajectory of N_2^+-particle in 3D
clear;
close all;

h = 1*10^(-9);  % time step
IVPSolver = @eulerstep;
ydot = @ydot_V_DC; % rhs-equations
r_0 = 3*10^(-3); % electrode distance to origo

% Plot with initial conditions x_0=1mm, y_0=0, v_0=u_0=0
initialConditions = [1*10^(-3), 0, 0, 0];

maxE_x = getMaxError(h, initialConditions, IVPSolver, ydot)
