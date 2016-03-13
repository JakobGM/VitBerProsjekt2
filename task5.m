% Task 5
% Plotting error of numerical solutions for different time steps
clear;
close all;

ydot = @ydot_V_DC; % rhs-equations
initialConditions = [1e-3, 0, 0, 0]; % [x_0, y_0, u_0, v_o]

h = 10.^(-9:0.05:-7.5);
n = length(h);
maxErrorEuler = zeros(1,n);
relativeErrorEuler = zeros(1,n);
maxErrorRK4 = zeros(1,n);
relativeErrorRK4 = zeros(1,n);

for i = 1:n
    [maxErrorEuler(i), relativeErrorEuler(i)] = getError(h(i), ...
        initialConditions, @eulerStep);
    [maxErrorRK4(i), relativeErrorRK4(i)] = getError(h(i), ...
        initialConditions, @rk4Step);
end

% test
% h = 1e-9;  % time step
% maxE_euler = getMaxError(h, initialConditions, @eulerstep, ydot);
% maxE_RK4 = getMaxError(h, initialConditions, @RK4, ydot);
% test end

loglog(h, maxErrorEuler, h, maxErrorRK4);
axis([1e-9 10^(-7.5) 1e-16 1e-2]); % maxError
%axis([1e-9 10^(-7.5) 1e-16 1e-2]); % relError