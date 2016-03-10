% oppg5
% Plotting trajectory of N_2^+-particle in 3D
clear;
close all;

ydot = @ydot_V_DC; % rhs-equations
initialConditions = [1e-3, 0, 0, 0]; % [x_0, y_0, u_0, v_o]

expValues = -10:0.1:-5;
n = length(expValues);
h = zeros(1,n);
maxE_euler = zeros(1,n);
maxE_RK4 = zeros(1,n);

for i = 1:n
    h(i) = 1*10^(expValues(i));  % time step
    maxE_euler(i) = getMaxError(h(i), initialConditions, @eulerstep, ydot);
    maxE_RK4(i) = getMaxError(h(i), initialConditions, @RK4, ydot);
end

% test
% h = 1e-9;  % time step
% maxE_euler = getMaxError(h, initialConditions, @eulerstep, ydot);
% maxE_RK4 = getMaxError(h, initialConditions, @RK4, ydot);
% test end

loglog(h,maxE_euler,h,maxE_RK4);
