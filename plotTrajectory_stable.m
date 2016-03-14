function plotTrajectory_stable()

V_DC = 5; V_AC = 38; % voltages
T = 0.00002; % total time
h = 1e-7; % step size for numeric method (RK4)
r_0 = 3e-3; % electrode distance to origo
n = round(T/h);
t = linspace(0, n*h, n+1);
initialConditions = [0.001, 0.001, 0, 0];
W = zeros(n, length(initialConditions)); % matrix for x, y, u, v values
W(1,:) = initialConditions;
z_pos = linspace(0, 0.10, n+1);
u = 1.66054e-27; % atomic mass unit
m = 28*u; % particle mass

% get data points
for i = 1 : n
    W(i+1,:) = rk4Step(t(i), W(i,:), h, V_DC, V_AC, m);
end

% plot the trajectories
fs = 12; % font size
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

stable = figure();
hold on;
plot(z_pos(:), W(:,1), 'r'); % plot x-values
plot(z_pos(:), W(:,2), 'b'); % plot y-values
xlabel('Avstand fra $z$-aksen [m]', 'FontSize', fs);
legend('$x$-posisjon', '$y$-posisjon', 'Location', 'northeast');
ylabel('Avstand fra $x$/$y$-aksen [m]', 'FontSize', fs);
axis([0, 0.1, -r_0, r_0]);
saveTightFigure(stable, ...
            'figures/plotStableTrajectory.pdf'); % saves figure


end