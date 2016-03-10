function ic = getRandomInitialConditions()
% generating random initial distances to z-axis (maximum r_0/2)
particleInitialPosRatioSquared = rand(1,1000).^2;
particleInitialXRatioSquared = rand(1,1000).*particleInitialPosRatioSquared;
particleInitialYRatio = particleInitialPosRatioSquared ...
    - particleInitialXRatioSquared;
particleInitialX = particleInitialXRatioSquared*r_0/2;
particleInitialY = particleInitialYRatio*r_0/2;

% generating random speed angles to the z-axis
particleInitialAngleRatio = rand(1,1000);
particleInitialAngle = particleInitialAngleRatio*2/180*pi;

% generating initial speed components
initialSpeedZ = 5000;
initialSpeedXY = 5000*sin(paricleInitialAngle);
particleInitialXSRatio = rand(1,1000)*initialSpeedXY;
particleInitialYSRatio = particleInitialPosRatioSquared - particleInitialXRatioSquared;

end