function z = ydot_V_DC(t,y)
% Right-hand side of particle ODE's from oppg3
% Input (t,y), where t is the time and y = [x, y, u, v]
% Returns vector z = [u v a_x a_y]

% constants
V_DC = 5; % DC-voltage
u = 1.66054e-27; % 1 atomic mass unit
m = 28*u; % particle mass
q = 1.60217646e-19; % particle charge
r_0 = 3e-3; % electrode distance to origo

% positions
x_pos = y(1);
y_pos = y(2);

% velocities
u = y(3);
v = y(4);

% e-field components
E_x = -V_DC*2*x_pos/r_0^2;
E_y =  V_DC*2*y_pos/r_0^2;

% form the equations
z  = zeros(1,4);

% velocities
z(1) = u;
z(2) = v;

% accelerations
z(3) = q*E_x/m;
z(4) = q*E_y/m;

end
