function plotTrajectory3D(T, h, p, initialConditions, IVPSolver)
% Plot trajectory of particle, calculated from initial conditions
% (x_0, y_0, u_0, v_0), IVPSolver and rhs-equations in ydot() with time 
% step h, with steps per point plottet p over total time T

V_DC = 5; % direct current voltage
V_AC = 45; % alternating current voltage
r_0 = 3e-3; % electrode distance to origo
n = round(T/h);
t = linspace(0, n*h, n+1);
W = zeros(n, length(initialConditions)-2); % matrix for x, y, u and v values
W(1,:) = initialConditions([1 2 4 5]); 

% Get data points
for i=1:n
    W(i+1,:) = IVPSolver(t(i), W(i,:), h, V_DC, V_AC);
end

z_pos = linspace(initialConditions(3),initialConditions(6)*T,n+1);

% Plot the trajectories
figure();
fs = 12; % font size
plot3(W(:,1), W(:,2), z_pos, 'k');
xlabel('$x$', 'fontsize', fs); ylabel('$y$', 'fontsize', fs);
zlabel('$z$', 'fontsize', fs);
title(['Bane til og animasjon av en $N_2^+$-partikkels bane i ' ...
    '$R_3$-planet']);

% Figure style
axisLimitXY = 4*10^(-3);
hold on;
plot3([-r_0 -r_0], [0 0], [0 0.1], 'r', ...
      [r_0 r_0], [0 0], [0 0.1], 'r', ... % positive electrodes
      [0 0], [-r_0 -r_0], [0 0.1], 'b', ...
      [0 0], [r_0 r_0], [0 0.1], 'b', 'linewidth',2); % negative electrodes
fill3(r_0/2*cos(linspace(0,2*pi,60)), r_0/2*sin(linspace(0,2*pi,60)), ...
    ones(1, 60)*0.1, 'g', 'faceAlpha', 0.5);
view(-155, 10);
axis([-axisLimitXY axisLimitXY -axisLimitXY axisLimitXY 0 0.1]);
grid on;

% Animate
head=line('color', 'r', 'marker', '.', 'markersize', 20, ...
'xData', [], 'yData', [], 'zData', []);
legend(head, {'$N_2^+$'}, 'interpreter', 'latex', 'location', 'NorthEast');

for i=1:p:n,
    set(head, 'xData', W(i,1), 'yData', W(i,2), 'zData', z_pos(i));
    drawnow; pause(h*p);
end

end