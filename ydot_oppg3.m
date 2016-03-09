function z=ydot_oppg3(t,y)
% Right-hand side of particle ODE's from oppg3
% constants
V_DC = 5; % DC-voltage
m = 28*1.66*10^(-27); % particle mass
q = 1.60*10^(-19); % particle charge
r_0 = 3*10^(-3); % electrode distance to origo

% positions
x_pos = y(1);
y_pos = y(2);

% e-field components
E_x = -V_DC*2*x_pos/r_0^2;
E_y =  V_DC*2*y_pos/r_0^2;

% velocities
u = y(3);
v = y(4);

% form the equations
z  = zeros(1,4);

% velocities
z(1) = u;
z(2) = v;

% accelerations
z(3) = q*E_x/m;
z(4) = q*E_y/m;

end