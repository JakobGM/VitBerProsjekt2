function initialConditions = getRandomInitialConditions()
% Returns 1000 sets of initial conditions [x_0 y_0 z_0 u_0 v_0 w_0]

% Generating random initial distances to z-axis (maximum r_0/2)
r_0 = 3e-3; % electrode distance to origo
initialDistRatio = rand(1,1000);
initialDistSquared = (initialDistRatio*r_0/2).^2;
initialXSquaredRatio = rand(1,1000);
initialYSquaredRatio = 1 - initialXSquaredRatio;
initialX = sqrt(initialXSquaredRatio.*initialDistSquared);
initialY = sqrt(initialYSquaredRatio.*initialDistSquared);

% Generating random speed angles to the z-axis
initialAngleRatio = rand(1,1000);
initialAngle = initialAngleRatio*2/180*pi;

% Generating initial speed components
initialSpeedZ = ones(1,1000)*5000;
initialSpeedXYSquared = (initialSpeedZ.*sin(initialAngle)).^2;
initialSpeedXSquaredRatio = rand(1,1000);
initialSpeedYSquaredRatio = 1 - initialSpeedXSquaredRatio;
initialSpeedX = sqrt(initialSpeedXSquaredRatio.*initialSpeedXYSquared);
initialSpeedY = sqrt(initialSpeedYSquaredRatio.*initialSpeedXYSquared);

% Return initial conditions
initialConditions = [initialX; initialY; zeros(1,1000); initialSpeedX; ...
    initialSpeedY; initialSpeedZ];

end