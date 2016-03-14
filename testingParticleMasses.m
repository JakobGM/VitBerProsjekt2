function testingParticleMasses()

% Voltages
V_DC_Good = 7.25;
V_AC_Good = 46.25;
V_DC_Bad = 3.5;
V_AC_Bad = 46.25;

% Parameters
T = 20e-6; % total time
h = 1e-8; % step size for numeric method (RK4)
initialConditions = [0.001, 0.001, 0, 0];
u = 1.66054e-27; % atomic mass unit

j = 1;
% Get data points
for i = 10 : 0.2 : 80
    m = i*u;
    x(j) = i;
    
    if getTrajectoryStability(T, h, initialConditions, ...
        V_DC_Good, V_AC_Good, m) == true
        testGood(j) = 100;
    else
        testGood(j) = 0;
    end
    
    if getTrajectoryStability(T, h, initialConditions, ...
        V_DC_Bad, V_AC_Bad, m) == true
        testBad(j) = 100;
    else
        testBad(j) = 0;
    end
    
    j = j + 1;
end

% Plot detectable masses
testingMasses = figure();
hold on;
plot(x, testGood, 'r', 'linewidth', 2);
plot(x, testBad, 'b', 'linewidth', 2);
axis([10, 80, 0.5, 105]);

set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

xlabel('$m$ [$u$]');
ylabel('Partikler som detekteres [$\%$]');
legend('Bra verdier', 'Darlige verdier', 'location', 'best');
saveTightFigure(testingMasses, ...
    'figures/testingParticleMasses.pdf'); % saves figure

end