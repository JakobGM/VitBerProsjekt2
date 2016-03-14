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
trajectoryAnimation = figure();
plot3(W(:,1)*1000, W(:,2)*1000, z_pos, 'k');

set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');
xlabel('$x$ (mm)'); ylabel('$y$ (mm)'); zlabel('$z$ (m)');
title('Animasjon av en $N_2^+$-partikkel i $R_3$');

% Figure style
axisLimitXY = 4; r_0_mm = r_0*1000;
hold on;
plot3([-r_0_mm -r_0_mm], [0 0], [0 0.1], 'r', ...
      [r_0_mm r_0_mm], [0 0], [0 0.1], 'r', ... % positive electrodes
      [0 0], [-r_0_mm -r_0_mm], [0 0.1], 'b', ...
      [0 0], [r_0_mm r_0_mm], [0 0.1], 'b', ... % negative electrodes
      'linewidth', 2); 
fill3(r_0_mm/2*cos(linspace(0,2*pi,60)), r_0_mm/2*sin(linspace(0,2*pi,60)), ...
    ones(1, 60)*0.1, 'g', 'faceAlpha', 0.5);
view(-155, 10);
axis([-axisLimitXY axisLimitXY -axisLimitXY axisLimitXY 0 0.1]);
grid on;

% Animate
head=line('color', 'r', 'marker', '.', 'markersize', 20, ...
'XData', [], 'YData', [], 'ZData', []);
legend(head, {'$N_2^+$'}, 'location', 'NorthEast');

for i=1:p:n,
    set(head, 'XData', W(i,1)*1000, 'YData', W(i,2)*1000, 'ZData', z_pos(i));
    drawnow; pause(h*p);
        if (i == 1 + p*round(n/(p*2))) % For saving figure
            saveTightFigure(trajectoryAnimation, ...
            'figures/trajectoryAnimation3D.pdf');
        end 
end

end