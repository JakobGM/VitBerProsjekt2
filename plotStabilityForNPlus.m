function plotStabilityForNPlus()

V_AC = 10; % AC-voltage
step_V_AC = 0.2; % step size V_AC
step_V_DC = 0.2; % step size V_DC
values = []; % line between stable and unstable
T = 0.00002; % total time
h = 10^(-8); % step size for numeric method (RK4)
ic = [0.001, 0.001, 0, 0]; % initial conditions (x,y)
u = 1.66054e-27; % atomic mass unit
m = 14*u; % particle mass

i = 1;
for V_DC = 2 : step_V_DC : 4.5
    stable = getTrajectoryStability(T, h, ic, V_DC, V_AC, m);
    while (stable == false)
        if (V_AC > 40)
            break;
        end
        V_AC = V_AC + step_V_AC;
        stable = getTrajectoryStability(T, h, ic, V_DC, V_AC, m);
    end
    if (V_AC < 40)
        values(i,1) = V_AC;
        values(i,2) = V_DC;
        i = i + 1;
    end

    while (stable == true)
        if (V_AC > 40)
            break;
        end
        V_AC = V_AC + step_V_AC;
        stable = getTrajectoryStability(T, h, ic, V_DC, V_AC, m);
    end
    if (V_AC < 40)
        values(i,1) = V_AC;
        values(i,2) = V_DC;
        i = i + 1;
    end

    V_AC = 10;

end

set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

fs = 12; % font size
stability = figure();
hold on;
plot(values(:,1), values(:,2), 'k.');
xlabel('V_{AC}', 'FontSize', fs); ylabel('V_{DC}', 'FontSize', fs);
axis([10, 30, 2, 4]);
annotation('textbox', [0.25,0.75,0.1,0.1], 'String', 'Unstable',...
    'EdgeColor',[1,1,1]); % text box in plot
annotation('textbox', [0.65,0.3,0.1,0.1], 'String', 'Stable',...
    'EdgeColor',[1,1,1]);
saveTightFigure(stability, ...
            'figures/plotStabilityForNPlus.pdf'); % saves figure

end