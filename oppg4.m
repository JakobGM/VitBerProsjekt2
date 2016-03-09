% oppg4
% Plotting trajectory of N_2^+-particle in 3D
clear;

T = 20*10^(-6); % total time
h = 1*10^(-9);  % time step
plotSteps = 100; % steps per point plottet
IVPSolver = @eulerstep;
ydot = @ydot_oppg4; % rhs-equations
r_0 = 3*10^(-3); % electrode distance to origo

% Plot with initial conditions x_0=y_0=1mm, z_0=0, v_0=u_0=0, w_0=5000;
initialConditions = [1*10^(-3), 1*10^(-3), 0, 0, 0, 5000];

axisLimitXY = 4*10^(-3);
r_0 = 3*10^(-3); % r_0: electrode distance to origo
figure(1);
hold on;
plot3([-r_0 -r_0], [0 0], [0 0.1], 'r', ...
      [r_0 r_0], [0 0], [0 0.1], 'r', ... % positive electrodes
      [0 0], [-r_0 -r_0], [0 0.1], 'b', ...
      [0 0], [r_0 r_0], [0 0.1], 'b', 'linewidth', 2); % negative electrodes
fill3(r_0/2*cos(linspace(0,2*pi,60)),r_0/2*sin(linspace(0,2*pi,60)), ...
    ones(1,60)*0.1,'g','FaceAlpha',0.5);
view(-155,10);
axis([-axisLimitXY axisLimitXY -axisLimitXY axisLimitXY 0 0.1]);
grid on;

plotTrajectory3D(T, h, plotSteps, initialConditions, IVPSolver, ydot);

hold off;
