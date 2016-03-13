% Plotting electric and potential field lines for both a quadrupole and for a hyperbolic approximation
% NB! Using only SI-units
close all
clear all
format long

% Constants
r_0 = 3e-3;

% Experimental parameters for applied voltage (not reallt important for this task)
V_DC = 5;
V_AC = 0;

% Inessential variabels since V_AC = 0
omega = 1;
t = pi/2;

appliedVoltage = @(t) V_DC + V_AC .* cos(omega*t);

% Positions of point charges, number 1 starting at (r_0, 0) and incrementing in positive rotational direction
pos1 = [r_0, 0];
pos2 = [0, r_0];
pos3 = [-r_0, 0];
pos4 = [0, -r_0];

% Potential generated by each respective point charge
% r is a vector in the form of [x,y]
V_q1 = @(x,y) -0.5 .* log( (x-pos1(1)).^2 + (y-pos1(2)).^2 );
V_q2 = @(x,y) 0.5 .* log( (x-pos2(1)).^2 + (y-pos2(2)).^2 );
V_q3 = @(x,y) -0.5 .* log( (x-pos3(1)).^2 + (y-pos3(2)).^2 );
V_q4 = @(x,y) 0.5 .* log( (x-pos4(1)).^2 + (y-pos4(2)).^2 );

% Superpositioning electric potentials
correctionFactor = 1/2.002610287264105; % Only used for testing, as qualitative comparison is only needed
V_q = @(x,y) correctionFactor * appliedVoltage(t) .* (V_q1(x,y) + V_q2(x,y) + V_q3(x,y) + V_q4(x,y));

% Deriving electric field from potential function
syms xPos yPos
nablaV = -gradient(V_q(xPos, yPos));
E_qx = matlabFunction(nablaV(1));
E_qy = matlabFunction(nablaV(2));

% Magnitude of electric field
E_q = @(x,y) sqrt(E_qx(x,y).^2 + E_qy(x,y).^2);

% Defining hyperbolic functional approximations
V_h = @(x,y) appliedVoltage(t) .* (x.^2 - y.^2) ./ r_0.^2;
E_hx = @(x,y) -appliedVoltage(t) .* 2.*x ./ r_0^2;
E_hy = @(x,y) appliedVoltage(t) .* 2.*y ./ r_0^2;
E_h = @(x,y) sqrt(E_hx(x,y).^2 + E_hy(x,y).^2);

% Printing out som test values
xTest = [0 1 -1] .* 1e-3;
yTest = [0 0 1] .* 1e-3;
disp(V_h(xTest, yTest))

%Declaring plot-values
ds = 0.112e-4;
xPlot = -2*r_0:ds:2*r_0;
yPlot = xPlot;
grey = [0.4 0.4 0.4]; % For color definition in plots
xLabelText = 'x [mm]';
yLabelText = 'y [mm]';

% Use LaTeX for figure titles, etc.
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');

[xGrid, yGrid] = meshgrid(xPlot, yPlot);
V_qPlot = V_q(xGrid, yGrid);
E_qxPlot = E_qx(xGrid, yGrid);
E_qyPlot = E_qy(xGrid, yGrid);

% Plotting the quadrupole point charges
pointChargeFieldFigure = figure;
V_qFig = contour(xGrid.*1e3, yGrid.*1e3, V_qPlot);
hold on
vecPlot1 = streamslice(xGrid.*1e3, yGrid.*1e3, E_qxPlot, E_qyPlot);
set(vecPlot1, 'Color', grey)
% Point charges
posFig = plot([pos1(1) pos3(1)].*1e3, [pos1(2) pos3(2)].*1e3, 'r.', 'markersize', 30);
negFig = plot([pos2(1) pos4(1)].*1e3, [pos2(2) pos4(2)].*1e3, 'b.', 'markersize', 30);
legend([posFig, negFig],  'Positiv linjeladning',  'Negativ linjeladning');
xlabel(xLabelText);
ylabel(yLabelText);

% Plotting the hyperbolic approximation
V_hPlot = V_h(xGrid, yGrid);
E_hxPlot = E_hx(xGrid, yGrid);
E_hyPlot = E_hy(xGrid, yGrid);

hyperbolicFieldFigure = figure;
contour(xGrid.*1e3, yGrid.*1e3, V_hPlot);
hold on
vecPlot2 = streamslice(xGrid.*1e3, yGrid.*1e3, E_hxPlot, E_hyPlot);
set(vecPlot2, 'Color', grey)

% Point charges
posFig2 = plot([pos1(1) pos3(1)].*1e3, [pos1(2) pos3(2)].*1e3, 'r.', 'markersize', 30);
negFig2 = plot([pos2(1) pos4(1)].*1e3, [pos2(2) pos4(2)].*1e3, 'b.', 'markersize', 30);
legend([posFig2, negFig2],  'Positiv linjeladning',  'Negativ linjeladning');
xlabel(xLabelText);
ylabel(yLabelText);

% Plotting a comparison between the two method
r_0Comparison = r_0;
dsComparison = r_0Comparison*1e-3;
xPlotComparison = -0.70*r_0Comparison:dsComparison:0.70*r_0Comparison;
yPlotComparison = xPlotComparison;
[xGridComparison, yGridComparison] = meshgrid(xPlotComparison, yPlotComparison);
V_qComparison = V_q(xGridComparison, yGridComparison);
V_hComparison = V_h(xGridComparison, yGridComparison);
comparisonFigure = figure;
contour(xGridComparison.*1e3, yGridComparison.*1e3, V_qComparison, '-', 'linecolor', 'b');
hold on
contour(xGridComparison.*1e3, yGridComparison.*1e3, V_hComparison, '--', 'linecolor', 'r');
xlabel(xLabelText);
ylabel(yLabelText);

% Saving figures
saveTightFigure(pointChargeFieldFigure, 'figures/pointChargeFieldFigure.pdf')
saveTightFigure(hyperbolicFieldFigure, 'figures/hyperbolicFieldFigure.pdf')
saveTightFigure(comparisonFigure, 'figures/comparisonFigure.pdf')
