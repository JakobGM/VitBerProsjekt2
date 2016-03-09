% oppg4
% Plotting trajectory of N_2^+-particle in 3D
clear;

T = 20*10^(-6); % total time
h = 1*10^(-9);  % time step
plotSteps = 100; % steps per point plottet
IVPSolver = @eulerstep;
ydot = @ydot_V_AC; % rhs-equations
r_0 = 3*10^(-3); % electrode distance to origo

% Plot with initial conditions x_0=y_0=1mm, z_0=0, v_0=u_0=0, w_0=5000;
initialConditions = [1*10^(-3), 1*10^(-3), 0, 0, 0, 5000];

plotTrajectory3D(T, h, plotSteps, initialConditions, r_0, IVPSolver, ydot);