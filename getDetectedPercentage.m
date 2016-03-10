function percentage = getDetectedPercentage(h, m)
% Get the percentage detected of 1000 particles 

ic = getRandomInitialConditions(); % 1000 random initial conditions

% V_DC og V_AC = ??? - trenger fra tidligere oppg
V_DC = 5; V_AC = 45; % voltages
T = 20e-6;
n = round(T/h)+1;
t = linspace(0,T,n);
Y = zeros(1,4); % matrix for storing x, y, u and v values

% get data points
stableCount = 0;
for i = 1:1000;
    Y = [ic(1,i), ic(2,i), ic(4,i), ic(5,i)];
    stable = getTrajectoryStability(T, h, Y(1,:), V_DC, V_AC, m);
    if (stable) stableCount = stableCount+1; end
end

percentage = stableCount/10;

end