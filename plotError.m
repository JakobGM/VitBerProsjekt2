function plotError(T, h, ic, IVPSolver, ydot)
% Plot trajectory of object/particle, calculated from initial conditions, 
% IVPSolver and rhs-equations in ydot with time step h, with steps per 
% point plottet p over total time T

n = round(T/h);
t = 0;
Y = zeros(n+1,length(ic));
Y(1,:) = ic;

% get data points
for i=1:n,
    Y(i+1,:) = IVPSolver(t,Y(i,:),h,ydot);
    t = t+h;
end

% analytic solution for x_0=1, y_0=0
V_DC = 5; % DC-voltage
m = 28*1.66*10^(-27); % particle mass
q = 1.60*10^(-19); % particle charge
r_0 = 3*10^(-3); % electrode distance to origo
a = -2*V_DC*q/(m*r_0^2);
analyticT = linspace(0, T, n+1);
analyticSolutionX = 5*10^(-4) * ((exp( sqrt(a)*analyticT)) + ...
                                 (exp(-sqrt(a)*analyticT)));

% get maximum error
maxE_x = max(Y(:,1)-analyticSolutionX)

end