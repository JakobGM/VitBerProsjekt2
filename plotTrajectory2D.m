function plotTrajectory2D(T, h, p, ic, IVPSolver, ydot)
% Plot trajectory of object/particle, calculated from initial conditions, 
% IVPSolver and rhs-equations in ydot with time step h, with steps per 
% point plottet p over total time T

n = round(T/h);
t = 0;
Y = zeros(n+1,length(ic));
Y(1,:) = ic;

% get data points
for i=1:n,
    Y(i+1,:) = IVPSolver(t,Y(i,:),h,ydot);
    t = t+h;
end

%plot the trajectories
fs = 12; % font size
plot(Y(:,1),Y(:,2),'k');
xlabel('x','FontSize',fs); ylabel('y','FontSize',fs);

% animate
head=line('color','r','Marker','.','markersize',20, ...
    'xdata',[],'ydata',[]);

% analytic solution for y_0=0
if ic(2) == 0
    V_DC = 5; % DC-voltage
    m = 28*1.66*10^(-27); % particle mass
    q = 1.60*10^(-19); % particle charge
    r_0 = 3*10^(-3); % electrode distance to origo
    a = -2*V_DC*q/(m*r_0^2);
    analyticT = linspace(0, T, n+1);
    analyticSolutionX = 5*10^(-4) * ((exp( sqrt(a)*analyticT)) + ...
                                     (exp(-sqrt(a)*analyticT)));
                                 
    head2=line('color','c','Marker','.','markersize',15, ...
        'xdata',[],'ydata',[]);
    legend([head head2], {'$N_2^+$', '$N_2^+$ analytic'}, ...
        'Interpreter','latex');
    
    for i=1:p:n+1,
        set(head,'XData',Y(i,1),'YData',Y(i,2));
        set(head2,'XData',analyticSolutionX(i),'YData',0);
        drawnow; pause(h*p);
    end
    
else
    legend(head,{'$N_2^+$'},'Interpreter','latex');
    
    for i=1:p:n+1,
        set(head,'XData',Y(i,1),'YData',Y(i,2));
        drawnow; pause(h*p);
    end

end

end