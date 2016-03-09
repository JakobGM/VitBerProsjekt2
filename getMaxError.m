function maxE_x = getMaxError(h, ic, IVPSolver, ydot)
% Plot trajectory of object/particle, calculated from initial conditions
% (x_0, y_0, u_0, v_0), IVPSolver and rhs-equations in ydot with time step
% h, with steps per point plottet p over total time T

V_DC = 5; % DC-voltage
m = 28*1.66*10^(-27); % particle mass
q = 1.60*10^(-19); % particle charge
r_0 = 3*10^(-3); % electrode distance to origo
T = sqrt(m*r_0^2/2/V_DC/q)*10*pi; % total time (5 periods)

n = round(T/h);
t = 0;
Y = zeros(n+1,length(ic));  % matrix for storing x, y, u and v values
Y(1,:) = ic;

% get data points
for i=1:n,
    Y(i+1,:) = IVPSolver(t,Y(i,:),h,ydot);
    t = t+h;
end

% analytic solution for x_0=1mm, y_0=0
a = 2*V_DC*q/(m*r_0^2);
analyticT = linspace(0, T, n+1);
analyticSolutionX = ic(1)*cos(sqrt(a)*analyticT);

% get maximum error
maxE_x = abs(max(analyticSolutionX-rot90(Y(:,1))));

end