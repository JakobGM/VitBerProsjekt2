% oppg5
% Plotting trajectory of N_2^+-particle in 3D
clear;
close all;

V_DC = 5; % DC-voltage
m = 28*1.66*10^(-27); % particle mass
q = 1.60*10^(-19); % particle charge
r_0 = 3*10^(-3); % electrode distance to origo
T = sqrt(m*r_0^2/2/V_DC/q)*10*pi; % total time (5 periods)
h = 1*10^(-9);  % time step
IVPSolver = @eulerstep;
ydot = @ydot_V_DC; % rhs-equations
r_0 = 3*10^(-3); % electrode distance to origo

% Plot with initial conditions x_0=1mm, y_0=0, v_0=u_0=0
initialConditions = [1*10^(-3), 0, 0, 0];

plotError(T, h, initialConditions, IVPSolver, ydot);
