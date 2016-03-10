function plotTrajectory2D(T, h, p, ic, IVPSolver, ydot)
% Plot trajectory of object/particle, calculated from initial conditions
% (x_0, y_0, u_0, v_0), IVPSolver and rhs-equations in ydot with time step
% h, with steps per point plottet p over total time T

r_0 = 3e-3; % electrode distance to origo
n = round(T/h)+1;
t = linspace(0,T,n);
Y = zeros(n,length(ic)); % matrix for storing x, y, u and v values
Y(1,:) = ic;

% get data points
for i=1:n-1
    Y(i+1,:) = IVPSolver(t(i),Y(i,:),h,ydot);
end

% plot the trajectories
figure();
hold on;
fs = 12; % font size
plot(Y(:,1),Y(:,2),'k');
xlabel('x','FontSize',fs); ylabel('y','FontSize',fs);

% figure style
axisLimit = 4e-3; r_0 = 3e-3; % r_0: electrode distance to origo
plot([-r_0 r_0],[0 0],'r.', ... % positive electrodes
	 [0 0],[-r_0 r_0],'b.','markersize',30); % negative electrodes
axis([-axisLimit axisLimit -axisLimit axisLimit]); % freeze axes
grid on;
line([-axisLimit axisLimit],[0 0],'color','k','linewidth',0.5);
line([0 0],[-axisLimit axisLimit],'color','k','linewidth',0.5);

% animate
head=line('color','r','Marker','.','markersize',20, ...
    'xdata',[],'ydata',[]);

% analytic solution for x_0=1mm, y_0=0
if ic(2) == 0
    V_DC = 5; % DC-voltage
    m = 28*1.66e-27; % particle mass
    q = 1.60e-19; % particle charge
    a = 2*V_DC*q/(m*r_0^2);
    analyticSolX = ic(1)*cos(sqrt(a)*t);

    head2=line('color','c','Marker','.','markersize',15, ...
        'xdata',[],'ydata',[]);
    legend([head head2], {'$N_2^+$', '$N_2^+$ analytic'}, ...
        'Interpreter','latex');

    for i=1:p:n
        set(head,'XData',Y(i,1),'YData',Y(i,2));
        set(head2,'XData',analyticSolX(i),'YData',0);
        drawnow; pause(h*p);
    end

    % Comparison with analytic solution
    figure();
    plot(t,Y(:,1),'r','linewidth',1.5);
    hold on;
    plot(t,analyticSolX,'c--','linewidth',1.5);
    hold off;

% without analytic
else
    legend(head,{'$N_2^+$'},'Interpreter','latex');

    for i=1:p:n
        set(head,'XData',Y(i,1),'YData',Y(i,2));
        drawnow; pause(h*p);
    end

end

hold off;

end
