function maxE_x = getError(h, initialConditions, IVPSolver)
% Plot trajectory of particle, calculated from initial conditions
% (x_0, y_0, u_0, v_0), IVPSolver and rhs-equations in ydot with time step
% h, with steps per point plottet p over total time T

% Physical parameters
V_DC = 5; % direct current voltage
V_AC = 0; % alternating current voltage
q = 1.60217646e-19; % particle charge
u = 1.66054e-27; % atomic mass unit
m = 28*u; % particle mass
r_0 = 3e-3; % electrode distance to origo
a = 2*V_DC*q/(m*r_0^2); % constant
T = sqrt(1/a)*10*pi; % total time (5 periods)

% Method parameters
n = round(T/h) + 1;
t = linspace(0,n*h,n);
W = zeros(n, length(initialConditions));  % matrix for storing x, y, u and v values
W(1,:) = initialConditions;

% Get data points
for i=1:(n-1)
    W(i+1,:) = IVPSolver(t(i), W(i,:), h, V_DC, V_AC);
end

% Analytic solution for x_0=1mm, y_0=0 after 5 periods
analyticSolX = initialConditions(1)*cos(sqrt(a)*t);%*t(end)); % test

% test
% E_x = zeros(1,n);
% for i = 1:n
%     E_x(i) = abs(analyticSolX(i)-W(i,1));
% end
% figure;
% plot(t,E_x);
% test end

% Get error after five periods
%maxE_x = abs(W(end,1) - analyticSolX(end));
 maxE_x = max(abs(W(:,1)'-analyticSolX)); % største feil, test

end
