function plotTrajectory2D(T, h, p, initialConditions, IVPSolver)
% Plot trajectory of object/particle, calculated from initial conditions
% (x_0, y_0, u_0, v_0), IVPSolver and rhs-equations in ydot() with time 
% step h, with steps per point plottet p over total time T

V_DC = 5; V_AC = 0; % voltages
r_0 = 3e-3; % electrode distance to origo
n = round(T/h) + 1;
t = linspace(0, n*h, n);
W = zeros(n, length(initialConditions)); % matrix for storing x, y, u and v values
W(1,:) = initialConditions;

% get data points
for i=1:n-1
    W(i+1,:) = IVPSolver(t(i), W(i,:), h, V_DC, V_AC);
end

% plot the trajectories
figure();
hold on;
fs = 12; % font size
plot(W(:,1), W(:,2), 'k');
xlabel('x', 'FontSize', fs); ylabel('y', 'FontSize', fs);

% figure style
axisLimit = 4e-3; r_0 = 3e-3; % r_0: electrode distance to origo
plot([-r_0 r_0], [0 0], 'r.', ... % positive electrodes
	 [0 0], [-r_0 r_0], 'b.', 'markersize', 30); % negative electrodes
axis([-axisLimit axisLimit -axisLimit axisLimit]); % freeze axes
grid on;
line([-axisLimit axisLimit], [0 0], 'color', 'k', 'linewidth', 0.5);
line([0 0], [-axisLimit axisLimit], 'color', 'k', 'linewidth', 0.5);

% animate
head=line('color', 'r', 'Marker', '.', 'markersize', 20, ...
    'xdata', [], 'ydata', []);

% analytic solution for x_0=1mm, y_0=0
if initialConditions(2) == 0
    V_DC = 5; % DC-voltage
    m = 28*1.66e-27; % particle mass
    q = 1.60e-19; % particle charge
    a = 2*V_DC*q/(m*r_0^2); % constant
    analyticSolX = initialConditions(1)*cos(sqrt(a)*t);

    head2=line('color', 'c', 'Marker', '.', 'markersize', 15, ...
        'xdata', [], 'ydata', []);
    legend([head head2], {'$N_2^+$', '$N_2^+$ analytic'}, ...
        'Interpreter', 'latex');

    for i=1:p:n
        set(head, 'XData', W(i,1), 'YData', W(i,2));
        set(head2, 'XData', analyticSolX(i), 'YData', 0);
        drawnow; pause(h*p);
    end

    % Comparison with analytic solution test
    figure();
    plot(t, W(:,1), 'r', 'linewidth', 1.5);
    hold on;
    plot(t, analyticSolX, 'c--', 'linewidth', 1.5);
    hold off;
    % test end

% without analytic
else
    legend(head, {'$N_2^+$'}, 'Interpreter', 'latex');

    for i=1:p:n
        set(head, 'XData', W(i,1), 'YData', W(i,2));
        drawnow; pause(h*p);
    end

end

hold off;

end
