function plotMaxError(h_vec)
% Plotting error of numerical solutions for time steps defined in h_vec

% Parameters and initializing
initialConditions = [1e-3, 0, 0, 0]; % [x_0, y_0, u_0, v_o]
n = length(h_vec);
maxErrorEuler = zeros(1,n);
relativeErrorEuler = zeros(1,n);
maxErrorRK4 = zeros(1,n);
relativeErrorRK4 = zeros(1,n);

% Get errors
for i = 1:n
    [maxErrorEuler(i), relativeErrorEuler(i)] = getError(h_vec(i), ...
        initialConditions, @eulerStep);
    [maxErrorRK4(i), relativeErrorRK4(i)] = getError(h_vec(i), ...
        initialConditions, @rk4Step);
end

% test
% h = 1e-9;  % time step
% maxE_euler = getMaxError(h, initialConditions, @eulerstep, ydot);
% maxE_RK4 = getMaxError(h, initialConditions, @RK4, ydot);
% test end

% Plot maximum error
plotMaxError = figure();
loglog(h_vec, maxErrorEuler, h_vec, maxErrorRK4);
axis([1e-9 10^(-7.5) 1e-16 1e-2]); 

set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');
xlabel('Tidssteg $\Delta t$ [s]');
ylabel('Feil i estimert $x$-posisjon $E_x$ [m]');
legend('Eulers metode', 'RK4');

saveTightFigure(plotMaxError, 'figures/loglogPlotMaxError.pdf');

% Relative error plot
% figure;
% loglog(h_vec, relativeErrorEuler, 'bx', h_vec, relativeErrorRK4, 'rx');
% axis([1e-9 10^(-7.5) 1e-12 1e2]);
% xlabel('Tidssteg $h$ [s]');
% ylabel('Relativ feil i estimert $x$-posisjon $E_{x,rel}$ [m]');
% title('Relativ feil i estimert $x$-posisjon som funksjon av tidssteg $h$');

disp(['Relativ feil med tidssteg 10^(' num2str(h_vec(end)) '): ' ...
    num2str(relativeErrorRK4(end))]);

end