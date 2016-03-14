function testingParticleMasses()

T = 0.00002; % total time
h = 1e-7; % step size for numeric method (RK4)
initialConditions = [0.001, 0.001, 0, 0];
u = 1.66054e-27; % atomic mass unit

j = 1;
V_DC_Good = 7.25;
V_AC_Good = 46.25;
V_DC_Bad = 3.5;
V_AC_Bad = 46.25;
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

fs = 12; % font size
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

testingMasses = figure();
hold on;
plot(x, testGood, 'r', 'LineWidth', 2);
plot(x, testBad, 'b', 'LineWidth', 2);
xlabel('$m$ [$u$]', 'FontSize', fs);
ylabel('Partikler som når detektoren [%]', 'FontSize', fs);
legend('Bra verdier', 'Dårlige verdier', 'Location', 'best');
axis([10, 80, 0.5, 105]);
saveTightFigure(testingMasses, ...
            'figures/testingParticleMasses.pdf'); % saves figure


end