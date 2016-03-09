function plotTrajectory3D(T, h, p, ic, IVPSolver, ydot)
% Plot trajectory of object/particle, calculated from initial conditions, 
% IVPSolver and rhs-equations in ydot with time step h, with steps per 
% point plottet p over total time T

n = round(T/h);
t = 0;
Y = zeros(n+1,length(ic)-2);
Y(1,:) = ic([1 2 4 5]);

% get data points
for i=1:n,
    Y(i+1,:) = IVPSolver(t,Y(i,:),h,ydot);
    t = t+h;
end

z_pos = linspace(ic(3),ic(6)*T,n+1);

%plot the trajectories
fs = 12; % font size
plot3(Y(:,1),Y(:,2),z_pos,'k');
xlabel('x','FontSize',fs); ylabel('y','FontSize',fs);

% animate
head=line('color','r','Marker','.','markersize',20, ...
'xdata',[],'ydata',[],'zdata',[]);
legend(head,{'$N_2^+$'},'Interpreter','latex','location','NorthEast');

for i=1:p:n+1,
    set(head,'XData',Y(i,1),'YData',Y(i,2),'ZData',z_pos(i));
    drawnow; pause(h*p);
end

end