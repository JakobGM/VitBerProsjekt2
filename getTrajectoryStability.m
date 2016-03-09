function stable = getTrajectoryStability(T, h, ic, r_0, IVPSolver, ...
    ydot, V_DC, V_AC)
% Find if particle has a stable trajectory, calculated from initial 
% conditions (x_0, y_0, u_0, v_0), IVPSolver and rhs-equations in ydot with
% time step h, with steps per point plottet p over total time T

n = round(T/h);
t = 0;
Y = zeros(n+1,length(ic));
Y(1,:) = ic;

% get data points
for i=1:n,
    Y(i+1,:) = IVPSolver(t,Y(i,:),h,ydot, V_DC, V_AC);
    t = t+h;
end

% find if particle leaves accepted area
stable = true;
for i = 1:n
    if (sqrt(Y(i,1)^2+Y(i,2)^2) > r_0) 
        stable = false; 
        break;
    end
end

if (sqrt(Y(n+1,1)^2+Y(n+1,2)^2) > r_0/2)
    stable = false;
end

end