function stable = getTrajectoryStability(T, h, ic, V_DC, V_AC, m)
% Find if particle has a stable trajectory, calculated from initial 
% conditions (x_0, y_0, u_0, v_0), IVPSolver and rhs-equations in ydot with
% time step h, with steps per point plottet p over total time T

if nargin == 5
    u = 1.66054e-27; % atomic mass unit
    m = 28*u; % particle mass
end

n = round(T/h);
t = 0;
Y = zeros(n+1, length(ic));  % matrix for storing x, y, u and v values
Y(1,:) = ic;

% Get data points
for i = 1:n,
    Y(i+1,:) = RK4(t, Y(i,:), h, V_DC, V_AC, m);
    t = t+h;
end

% find if particle leaves accepted area
stable = true;
r_0 = 3e-3; % electrode distance to origo
for i = 1:n
    if (sqrt(Y(i,1)^2 + Y(i,2)^2) > r_0) 
        stable = false; 
        break;
    end
end

if (sqrt(Y(n+1,1)^2 + Y(n+1,2)^2) > r_0/2)
    stable = false;
end

end