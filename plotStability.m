function plotStability()
clear;
close all;

% Physical parameters
V_AC = 5; % alternating current voltage
u = 1.66054e-27; % atomic mass unit
m = 28*u; % particle mass
T = 20e-6; % total time
initialConditions = [1e-3, 1e-3, 0, 0]; % initial conditions (x,y)

% Method parameters
h = 1e-8; % step size for numeric method (RK4)
step_V_AC = 0.2; % step size V_AC
step_V_DC = 0.2; % step size V_DC
values = []; % line between stable and unstable

% Get stability
i = 1;
for V_DC = 1:step_V_DC:8.5
    stable = getTrajectoryStability(T, h, initialConditions, V_DC, V_AC, m);

    % Get first stable V_AC-value
    while (stable == false)
        if (V_AC > 60)
            break;
        end
        V_AC = V_AC + step_V_AC;
        stable = getTrajectoryStability(T, h, initialConditions, V_DC, V_AC, m);
    end

    if (V_AC < 60)
        values(i,1) = V_AC;
        values(i,2) = V_DC;
        i = i + 1;
    end

    % Get final stable V_AC-value
    while (stable == true)
        if (V_AC > 60)
            break;
        end
        V_AC = V_AC + step_V_AC;
        stable = getTrajectoryStability(T, h, initialConditions, V_DC, V_AC, m);
    end

    if (V_AC < 60)
        values(i,1) = V_AC;
        values(i,2) = V_DC;
        i = i + 1;
    end

    V_AC = 5;
end

stability = figure();
plot(values(:,1), values(:,2), 'k.');
axis([15, 60, 1, 8]);

set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

xlabel('$V_{AC}$'); ylabel('$V_{DC}$');
annotation('textbox', [0.25,0.75,0.1,0.1], 'String', 'Ustabil',...
    'edgeColor', [1,1,1], 'Interpreter', 'latex'); % text box in plot
annotation('textbox', [0.52,0.25,0.1,0.1], 'String', 'Stabil',...
    'edgeColor', [1,1,1], 'Interpreter', 'latex');

saveTightFigure(stability, ...
    'figures/plotStability.pdf'); % saves figure

end
