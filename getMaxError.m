function maxE_x = getMaxError(h, ic, IVPSolver, ydot)
% Plot trajectory of object/particle, calculated from initial conditions
% (x_0, y_0, u_0, v_0), IVPSolver and rhs-equations in ydot with time step
% h, with steps per point plottet p over total time T

V_DC = 5; % DC-voltage
m = 28*1.66e-27; % particle mass
q = 1.60e-19; % particle charge
r_0 = 3e-3; % electrode distance to origo
T = sqrt(m*r_0^2/(2*V_DC*q))*10*pi; % total time (5 periods)

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
analyticT = linspace(0,T,n+1);
analyticSolutionX = ic(1)*cos(sqrt(a)*analyticT);

% test
E_x = zeros(1,n+1);
for i = 1:n+1
    E_x = abs(analyticSolutionX(i)-Y(i,1));
end
time = linspace(0,T,n+1);
figure;
plot(time,E_x);
% test

% get maximum error
maxE_x = abs(max(analyticSolutionX-Y(:,1)'));
%maxE_x = abs(Y(n+1,1) - analyticSolutionX(n+1));

end