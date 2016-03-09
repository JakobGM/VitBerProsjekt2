% oppg3
% Plotting trajectories of N_2^+-particle in 2D
clear;

T = 20*10^(-6); % total time
h = 1*10^(-9);  % time step
plotSteps = 100; % steps per point plottet
IVPSolver = @eulerstep;
ydot = @ydot_oppg3; % rhs-equations
r_0 = 3*10^(-3); % electrode distance to origo

% Plot with initial conditions x_0=y_0=1mm, v_0=u_0=0
initialConditions = [1*10^(-3), 1*10^(-3), 0, 0];

axisLimit = 4*10^(-3); r_0 = 3*10^(-3); % r_0: electrode distance to origo
figure(1);
hold on;
plot([-r_0 r_0], [0 0], 'r.', ... % positive electrodes
	   [0 0], [-r_0 r_0], 'b.', 'markersize', 30); % negative electrodes
axis([-axisLimit axisLimit -axisLimit axisLimit]); % freeze axes
grid on;
line([-axisLimit axisLimit], [0 0], 'color', 'k', 'linewidth', 0.5);
line([0 0], [-axisLimit axisLimit], 'color', 'k', 'linewidth', 0.5);

plotTrajectory2D(T, h, plotSteps, initialConditions, IVPSolver, ydot);

hold off;

% Plot with initial conditions x_0=1mm, y_0=0, v_0=u_0=0
initialConditions = [1*10^(-3), 0, 0, 0];

axisLimit = 4*10^(-3);
figure(2);
hold on;
plot([-r_0 r_0], [0 0], 'r.', ... % positive electrodes
     [0 0], [-r_0 r_0], 'b.', 'markersize', 30); % negative electrodes
axis([-axisLimit axisLimit -axisLimit axisLimit]); % freeze axes
grid on;
line([-axisLimit axisLimit], [0 0], 'color', 'k', 'linewidth', 0.5);
line([0 0], [-axisLimit axisLimit], 'color', 'k', 'linewidth', 0.5);

plotTrajectory2D(T, h, plotSteps, initialConditions, IVPSolver, ydot);

hold off;