function stable = getTrajectoryStability(T, h, initialConditions, V_DC, ...
    V_AC, m)
% Find if particle with initial conditions (x_0, y_0, u_0, v_0) has a
% stable trajectory

if nargin == 5
    u = 1.66054e-27; % atomic mass unit
    m = 28*u; % particle mass
else

n = round(T/h);
t = linspace(0, n*h, n+1);
W = zeros(n, length(initialConditions));  % matrix for x, y, u and v values
W(1,:) = initialConditions;

% Get data points
for i = 1:n,
    W(i+1,:) = rk4Step(t(i), W(i,:), h, V_DC, V_AC, m);
end

% find if particle leaves accepted area
stable = true;
r_0 = 3e-3; % electrode distance to origo
for i = 1:n
    if (sqrt(W(i,1)^2 + W(i,2)^2) > r_0) 
        stable = false; 
        break;
    end
end

if (sqrt(W(n+1,1)^2 + W(n+1,2)^2) > r_0/2)
    stable = false;
end

end