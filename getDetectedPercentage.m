function getDetectedPercentage(h, m)
% Get the percentage detected of 1000 particles 

r_0 = 3e-3; % electrode distance to origo

ic
T = 20e-6;
n = round(T/h)+1;
t = linspace(0,T,n);
Y = zeros(n,length(ic)-2); % matrix for storing x, y, u and v values
Y(1,:) = ic([1 2 4 5]);

% get data points
for i=1:n-1
    Y(i+1,:) = RK4(t(i),Y(i,:),h,@ydot_V_AC);
end

z_pos = linspace(ic(3),ic(6)*T,n);

end