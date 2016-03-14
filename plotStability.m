function plotStability()

V_AC = 5; % AC-voltage
step_V_AC = 0.2; % step size V_AC
step_V_DC = 0.2; % step size V_DC
values = []; % line between stable and unstable
T = 0.00002; % total time
h = 10^(-7.5); % step size for numeric method (RK4)
ic = [0.001, 0.001, 0, 0]; % initial conditions (x,y)
u = 1.66054e-27; % atomic mass unit
m = 28*u; % particle mass

i = 1;
for V_DC = 1 : step_V_DC : 8.5
    stable = getTrajectoryStability(T, h, ic, V_DC, V_AC, m);
    while (stable == false)
        if (V_AC > 60)
            break;
        end
        V_AC = V_AC + step_V_AC;
        stable = getTrajectoryStability(T, h, ic, V_DC, V_AC, m);
    end
    if (V_AC < 60)
        values(i,1) = V_AC;
        values(i,2) = V_DC;
        i = i + 1;
    end

    while (stable == true)
        if (V_AC > 60)
            break;
        end
        V_AC = V_AC + step_V_AC;
        stable = getTrajectoryStability(T, h, ic, V_DC, V_AC, m);
    end
    if (V_AC < 60)
        values(i,1) = V_AC;
        values(i,2) = V_DC;
        i = i + 1;
    end

    V_AC = 5;

end

fs = 12; % font size
plot(values(:,1), values(:,2), 'k.');
hold on;
title('Stabilitets-diagram', 'FontSize', fs+4);
xlabel('V_{AC}', 'FontSize', fs); ylabel('V_{DC}', 'FontSize', fs);
mTextBox1 = uicontrol('style','text');
mTextBox2 = uicontrol('style','text');
set(mTextBox1,'String','Unstable','Position',[25,6,10,1]);
set(mTextBox2,'String', 'Unstable','Position',[42,3,10,1]);


end