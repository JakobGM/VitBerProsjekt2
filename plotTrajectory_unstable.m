function plotTrajectory_unstable()

V_DC = 2; V_AC = 22.5; % voltages
T = 0.00002; % total time
h = 1e-7; % step size for numeric method (RK4)
r_0 = 3e-3; % electrode distance to origo
n = round(T/h);
t = linspace(0, n*h, n+1);
initialConditions = [0.001, 0.001, 0, 0];
W = zeros(n+1, length(initialConditions)); % matrix for x, y, u, v values
W(1,:) = initialConditions;
z_pos = linspace(0, 0.10, n+1);
u = 1.66054e-27; % atomic mass unit
m = 28*u; % particle mass

% get data points
for i = 1 : n
    W(i+1,:) = rk4Step(t(i), W(i,:), h, V_DC, V_AC, m);
    if (abs(W(i+1,1)) > r_0) || (abs(W(i+1,2)) > r_0)
        for j = n : -1 : i+1 % deleting extra z-points
            z_pos(j+1) = [];
            W(j+1,:) = [];
        end
        break;
    end
end

W(:,1) = W(:,1) .* 1000;
W(:,2) = W(:,2) .* 1000;
z_pos(:) = z_pos(:)*1000;

% plot the trajectories
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

unstable = figure();
plot(z_pos(:), W(:,1), 'r'); % plot x-values
hold on;
plot(z_pos(:), W(:,2), 'b'); % plot y-values
xlabel('Avstand fra $xy$-planet [mm]');
legend('$x$-posisjon', '$y$-posisjon', 'Location', 'northeast');
ylabel('Avstand fra $x$/$y$-aksen [mm]');
axis([0, 100, -r_0*1000, r_0*1000]);
saveTightFigure(unstable, ...
            'figures/plotUnstableTrajectory.pdf'); % saves figure


end