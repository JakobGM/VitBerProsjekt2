function maxE_x = getError(h, ic, IVPSolver)
% Plot trajectory of object/particle, calculated from initial conditions
% (x_0, y_0, u_0, v_0), IVPSolver and rhs-equations in ydot with time step
% h, with steps per point plottet p over total time T

V_DC = 5; V_AC = 0; % voltages
m = 28*1.66e-27; % particle mass
q = 1.60e-19; % particle charge
r_0 = 3e-3; % electrode distance to origo
T = sqrt(m*r_0^2/(2*V_DC*q))*10*pi; % total time (5 periods)

n = round(T/h);
t = linspace(0,T,n);
Y = zeros(n+1,length(ic));  % matrix for storing x, y, u and v values
Y(1,:) = ic;

% get data points
for i=1:n,
    Y(i+1,:) = IVPSolver(t(i), Y(i,:), h, V_DC, V_AC);
end

% analytic solution for x_0=1mm, y_0=0 after 5 periods
a = 2*V_DC*q/(m*r_0^2);
analyticSolX = ic(1)*cos(sqrt(a)*t(end));

% test
% E_x = zeros(1,n+1);
% for i = 1:n+1
%     E_x(i) = abs(analyticSolutionX(i)-Y(i,1));
% end
% time = linspace(0,T,n+1);
% figure;
% plot(time,E_x);
% test end

% get error after five periods
maxE_x = abs(Y(end,1) - analyticSolX);

end