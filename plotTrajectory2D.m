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
plot(W(:,1)*1000, W(:,2)*1000, 'k');

set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');
xlabel('$x$ (mm)'); ylabel('$y$ (mm)');
title('Animasjon av en $N_2^+$-partikkel i $xy$-planet');

% Figure style
axisLimit = 4; r_0_mm = r_0*1000; 
plot([-r_0_mm r_0_mm], [0 0], 'r.', ... % positive electrodes
	 [0 0], [-r_0_mm r_0_mm], 'b.', 'markersize', 30); % negative electrodes
axis([-axisLimit axisLimit -axisLimit axisLimit]); % freeze axes
grid on;
line([-axisLimit axisLimit], [0 0], 'color', 'k', 'linewidth', 0.5);
line([0 0], [-axisLimit axisLimit], 'color', 'k', 'linewidth', 0.5);

% Animate
head=line('color', 'r', 'marker', '.', 'markersize', 20, ...
    'XData', [], 'YData', []);

% Analytic solution for x_0=1mm, y_0=0
if initialConditions(2) == 0
    V_DC = 5; % DC-voltage
    m = 28*1.66e-27; % particle mass
    q = 1.60e-19; % particle charge
    a = 2*V_DC*q/(m*r_0^2); % constant
    analyticSolX = initialConditions(1)*cos(sqrt(a)*t);

    head2=line('color', 'c', 'marker', '.', 'markersize', 13, ...
        'XData', [], 'YData', []);
    legend([head head2], {'$N_2^+$', '$N_2^+$ analytisk'});

    for i=1:p:n
        set(head, 'XData', W(i,1)*1000, 'YData', W(i,2)*1000);
        set(head2, 'XData', analyticSolX(i)*1000, 'YData', 0);
        drawnow; pause(h*p);
        if (i == 1 + p*round(n/(p*25))) % For saving figure
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
    legend(head, {'$N_2^+$'});

    for i=1:p:n
        set(head, 'XData', W(i,1)*1000, 'YData', W(i,2)*1000);
        drawnow; pause(h*p);
        if (i == 1 + p*round(n/(p*25))) % For savning figure
            saveTightFigure(trajectoryAnimation, ...
            'figures/trajectoryAnimation.pdf');
        end 
    end

end

end
