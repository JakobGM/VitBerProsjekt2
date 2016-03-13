function plotTrajectory_unstable()

V_DC = 5; V_AC = 20; % voltages
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
    if (abs(W(i+1,1)) > r_0) || (abs(W(i+1,2)) > r_0)
        for j = n : -1 : i+2
            z_pos(j) = [];
        end
        break;
    end
end

% plot the trajectories
fs = 12; % font size
plot(z_pos(i), W(i,1), 'r');
hold on;
plot(z_pos(i), W(i,2), 'b');
xlabel('Avstand fra z-aksen [m]', 'FontSize', fs);
legend('x-posisjon', 'y-posisjon', 'Location', 'northeast');
ylabel('Avstand fra x/y-aksen [m]', 'FontSize', fs);
title('Ustabil bane', 'FontSize', fs+4);
axis([0, 0.1, -r_0, r_0]);


end