function plotStableUnstable()

V_AC = 5; % AC-voltage
step_V_AC = 0.5; % step size V_AC
step_V_DC = 0.5; % step size V_DC
values = []; % line between stable and unstable
T = 0.00002; % total time
h = 1e-7; % step size for numeric method (RK4)
ic = [0.001, 0.001]; % initial conditions (x,y)
u = 1.66054e-27; % atomic mass unit
m = 28*u; % particle mass

i = 1;
for V_DC = 1 : step_V_DC : 10
    stable = getTrajectoryStability(T, h, ic, V_DC, V_AC, m);
    while (stable == false)
        V_AC = V_AC + step_V_AC;
        stable = getTrajectoryStability(T, h, ic, V_DC, V_AC, m);
    end
    values(i,1) = V_AC;
    values(i,2) = V_DC;
    i = i + 1;
    
    while (stable == true)
        V_AC = V_AC + step_V_AC;
        stable = getTrajectoryStability(T, h, ic, V_DC, V_AC, m);
    end
    values(i,1) = V_AC;
    values(i,2) = V_DC;
    i = i + 1;

end



end