function plotTrajectory2D(T, h, p, initialConditions, IVPSolver)
% Plot trajectory of particle, calculated from initial conditions
% (x_0, y_0, u_0, v_0), IVPSolver and rhs-equations in ydot() with time 
% step h, with steps per point plottet p over total time T

V_DC = 5; % direct current voltage
V_AC = 0; % alternating current voltage
r_0 = 3e-3; % electrode distance to origo
n = round(T/h);
t = linspace(0, n*h, n+1);
W = zeros(n, length(initialConditions)); % matrix for x, y, u and v values
W(1,:) = initialConditions;

% Get data points
for i=1:n
    W(i+1,:) = IVPSolver(t(i), W(i,:), h, V_DC, V_AC);
end

% Plot the trajectories
trajectoryAnimation = figure();
hold on;
fs = 12; % font size
plot(W(:,1), W(:,2), 'k');
xlabel('$x$', 'fontSize', fs); ylabel('$y$', 'fontSize', fs);
title(['Bane til og animasjon av en $N_2^+$-partikkels bane i ' ...
    '$xy$-planet']);

% Figure style
axisLimit = 4e-3; r_0 = 3e-3; % r_0: electrode distance to origo
plot([-r_0 r_0], [0 0], 'r.', ... % positive electrodes
	 [0 0], [-r_0 r_0], 'b.', 'markersize', 30); % negative electrodes
axis([-axisLimit axisLimit -axisLimit axisLimit]); % freeze axes
grid on;
line([-axisLimit axisLimit], [0 0], 'color', 'k', 'linewidth', 0.5);
line([0 0], [-axisLimit axisLimit], 'color', 'k', 'linewidth', 0.5);

% Animate
head=line('color', 'r', 'marker', '.', 'markersize', 18, ...
    'xData', [], 'yData', []);

% Analytic solution for x_0=1mm, y_0=0
if initialConditions(2) == 0
    V_DC = 5; % DC-voltage
    m = 28*1.66e-27; % particle mass
    q = 1.60e-19; % particle charge
    a = 2*V_DC*q/(m*r_0^2); % constant
    analyticSolX = initialConditions(1)*cos(sqrt(a)*t);

    head2=line('color', 'c', 'marker', '.', 'markersize', 15, ...
        'xData', [], 'yData', []);
    legend([head head2], {'$N_2^+$', '$N_2^+$ analytisk'}, ...
        'interpreter', 'latex');

    for i=1:p:n
        set(head, 'xData', W(i,1), 'yData', W(i,2));
        set(head2, 'xData', analyticSolX(i), 'yData', 0);
        drawnow; pause(h*p);
        if (i == 1 + p*round(n/(p*25))) % For savning figure
        saveTightFigure(trajectoryAnimation, ...
            'figures/trajectoryAnimationAnalytic.pdf');
        end 
    end

    % Comparison with analytic solution test
%     figure();
%     plot(t, W(:,1), 'r', 'linewidth', 1.5);
%     hold on;
%     plot(t, analyticSolX, 'c--', 'linewidth', 1.5);
%     hold off;
    % test end

% Without analytic
else
    legend(head, {'$N_2^+$'}, 'interpreter', 'latex');

    for i=1:p:n
        set(head, 'yData', W(i,1), 'yData', W(i,2));
        drawnow; pause(h*p);
        if (i == 1 + p*round(n/(p*25))) % For savning figure
            saveTightFigure(trajectoryAnimation, ...
            'figures/trajectoryAnimation.pdf');
        end 
    end

end

end
