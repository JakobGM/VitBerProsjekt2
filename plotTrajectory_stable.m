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
z_pos = linspace(0, 0.10, n);
u = 1.66054e-27; % atomic mass unit
m = 28*u; % particle mass

% get data points
for i = 1 : n-1
    W(i+1,:) = rk4Step(t(i), W(i,:), h, V_DC, V_AC, m);
end

% plot the trajectories
fs = 12; % font size
plot(z_pos(:), W(:,1), 'r'); % plot x-values
hold on;
plot(z_pos(:), W(:,2), 'b'); % plot y-values
xlabel('Avstand fra z-aksen [m]', 'FontSize', fs);
legend('x-posisjon', 'y-posisjon', 'Location', 'northeast');
ylabel('Avstand fra x/y-aksen [m]', 'FontSize', fs);
title('Ustabil bane', 'FontSize', fs+4);
axis([0, 0.1, -r_0, r_0]);


end