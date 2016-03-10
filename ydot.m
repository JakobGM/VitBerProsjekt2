function z=ydot(t, y, V_DC, V_AC, m)
% Right-hand side of particle ODE's from oppg3
% constants
if nargin == 4
    u = 1.66054e-27; % atomic mass unit
    m = 28*u; % particle mass
end
w = 1e7; % angular frequency
q = 1.60217646e-19; % particle charge
r_0 = 3e-3; % electrode distance to origo

% Positions
x_pos = y(1);
y_pos = y(2);

% E-field components
E_x = -(V_DC + V_AC*cos(w*t))*2*x_pos/r_0^2;
E_y =  (V_DC + V_AC*cos(w*t))*2*y_pos/r_0^2;

% Velocities
u = y(3);
v = y(4);

% Form the equations
z  = zeros(1,4);

% Velocities
z(1) = u;
z(2) = v;

% accelerations
z(3) = q*E_x/m;
z(4) = q*E_y/m;

end
