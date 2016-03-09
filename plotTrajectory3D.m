function plotTrajectory3D(T, h, p, ic, r_0, IVPSolver, ydot)
% Plot trajectory of object/particle, calculated from initial conditions
% (x_0, y_0, u_0, v_0), IVPSolver and rhs-equations in ydot with time step
% h, with steps per point plottet p over total time T

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

% figure style
axisLimitXY = 4*10^(-3);
r_0 = 3*10^(-3); % r_0: electrode distance to origo
figure(1);
hold on;
plot3([-r_0 -r_0], [0 0], [0 0.1], 'r', ...
      [r_0 r_0], [0 0], [0 0.1], 'r', ... % positive electrodes
      [0 0], [-r_0 -r_0], [0 0.1], 'b', ...
      [0 0], [r_0 r_0], [0 0.1], 'b', 'linewidth', 2); % negative electrodes
fill3(r_0/2*cos(linspace(0,2*pi,60)),r_0/2*sin(linspace(0,2*pi,60)), ...
    ones(1,60)*0.1,'g','FaceAlpha',0.5);
view(-155,10);
axis([-axisLimitXY axisLimitXY -axisLimitXY axisLimitXY 0 0.1]);
grid on;

% animate
head=line('color','r','Marker','.','markersize',20, ...
'xdata',[],'ydata',[],'zdata',[]);
legend(head,{'$N_2^+$'},'Interpreter','latex','location','NorthEast');

for i=1:p:n+1,
    set(head,'XData',Y(i,1),'YData',Y(i,2),'ZData',z_pos(i));
    drawnow; pause(h*p);
end

end