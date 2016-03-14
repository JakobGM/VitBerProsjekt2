function plotDetectedPercentage(atomicMassValues, V_DC)
% Plotting percentage of detected particles with masses defined in
% atomicMassValues and charge e, with "random" entrances, and dirrect
% current voltage V_DC

% Parameters ant initializing
T = 20e-6; % total time
h = 1e-8;  % time step
u = 1.66054e-27; % atomic mass unit
detectedPercentage = zeros(1, length(atomicMassValues));

% Get percentages
for i = 1:length(atomicMassValues)
    mass = atomicMassValues(i)*u;
    detectedPercentage(i) = getDetectedPercentage(h, mass, V_DC);
end

% Plot percentages
barDetectedPercentage = figure();
bar(atomicMassValues, detectedPercentage, 0.4);
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');
xlabel('Masse $m$ [u]');
ylabel('Andel partikler detektert [\%]');

saveTightFigure(barDetectedPercentage, ...
    'figures/barDetectedPercentage.pdf');

end