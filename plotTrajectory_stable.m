function plotTrajectory_stable()

% Physical parameters
V_DC = 5; % direct current voltage
V_AC = 38; % alternating current voltage
u = 1.66054e-27; % atomic mass unit
m = 28*u; % particle mass
T = 20e-6; % total time
r_0 = 3e-3; % electrode distance to origo
initialConditions = [1e-3, 1e-3, 0, 0];

% Method parameters
h = 1e-8; % step size for numeric method (RK4)
n = round(T/h);
t = linspace(0, n*h, n+1);
W = zeros(n, length(initialConditions)); % matrix for x, y, u, v values
W(1,:) = initialConditions;


% Get data points
for i = 1:n
    W(i+1,:) = rk4Step(t(i), W(i,:), h, V_DC, V_AC, m);
end
z_pos = linspace(0, 0.10, n+1);

W(:,1) = W(:,1)*1000;
W(:,2) = W(:,2)*1000;
z_pos(:) = z_pos(:)*1000;

% Plot trajectories

stable = figure();
hold on;
plot(z_pos(:), W(:,1), 'r'); % plot x-values
plot(z_pos(:), W(:,2), 'b'); % plot y-values
axis([0, 100, -r_0*1000, r_0*1000]);

set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

xlabel('Avstand fra $xy$-planet [mm]');
legend('$x$-posisjon', '$y$-posisjon', 'location', 'NorthEast');
ylabel('Avstand fra $x$/$y$-aksen [mm]');

saveTightFigure(stable, ...
    'figures/plotStableTrajectory.pdf'); % saves figure

end