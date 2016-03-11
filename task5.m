% Task 5
% Plotting error of numerical solutions for different time steps
clear;
close all;

ydot = @ydot_V_DC; % rhs-equations
initialConditions = [1e-3, 0, 0, 0]; % [x_0, y_0, u_0, v_o]

h = 10.^(-10:0.1:-7);
n = length(h);
maxE_euler = zeros(1,n);
maxE_RK4 = zeros(1,n);

for i = 1:n
    maxE_euler(i) = getError(h(i), initialConditions, @eulerstep);
    maxE_RK4(i) = getError(h(i), initialConditions, @RK4);
end

% test
% h = 1e-9;  % time step
% maxE_euler = getMaxError(h, initialConditions, @eulerstep, ydot);
% maxE_RK4 = getMaxError(h, initialConditions, @RK4, ydot);
% test end

loglog(h, maxE_euler, 'o', h, maxE_RK4, 'o');
