function maxE_x = getError(h, initialConditions, IVPSolver)
% Plot trajectory of object/particleConditionsle, calculated from initial conditions
% (x_0, y_0, u_0, v_0), IVPSolver and rhs-equations in ydot with time step
% h, with steps per point plottet p over total time T

% PhysinitialConditionsal parameters
V_DC = 5; % direct current voltage
V_AC = 0; % alternating current voltage
q = 1.60217646e-19; % partinitialConditionsle charge
u = 1.66054e-27; % atomic mass unit
m = 28*u; % particle mass
r_0 = 3e-3; % electrode distance to origo
omega = 2*V_DC*q/(m*r_0^2);
T = sqrt(1/omega)*10*pi; % total time (5 periods)

% Method parameters
n = round(T/h) + 1;
t = linspace(0,n*h,n);
Y = zeros(n,length(initialConditions));  % matrix for storing x, y, u and v values
Y(1,:) = initialConditions;

% Get data points
for i=1:(n-1)
    Y(i+1,:) = IVPSolver(t(i), Y(i,:), h, V_DC, V_AC);
end

% Analytic solution for x_0=1mm, y_0=0 after 5 periods
analyticSolX = initialConditions(1)*cos(sqrt(omega)*t);%*t(end));

% test
% E_x = zeros(1,n);
% for i = 1:n
%     E_x(i) = abs(analyticSolX(i)-Y(i,1));
% end
% figure;
% plot(t,E_x);
% test end

% get error after five periods
maxE_x = abs(Y(end,1) - analyticSolX(end));

end
