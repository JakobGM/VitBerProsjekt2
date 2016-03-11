function new_w = lhs_dot(t, w, V_DC, V_AC, m)
% Right-hand side of particle ODE's from Task 3

% Constants
if nargin == 4
    u = 1.66054e-27; % atomic mass unit
    m = 28*u; % particle mass
end
omega = 1e7; % angular frequency
q = 1.60217646e-19; % particle charge
r_0 = 3e-3; % electrode distance to origo

% Positions
x_pos = w(1);
y_pos = w(2);

% E-field components
E_x = -(V_DC + V_AC*cos(omega*t))*2*x_pos/r_0^2;
E_y =  (V_DC + V_AC*cos(omega*t))*2*y_pos/r_0^2;

% Velocities
u = w(3);
v = w(4);

% Form the equations
new_w  = zeros(1,4);

% Velocities
new_w(1) = u;
new_w(2) = v;

% Accelerations
new_w(3) = q*E_x/m;
new_w(4) = q*E_y/m;

end
