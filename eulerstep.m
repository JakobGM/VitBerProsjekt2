function y = eulerstep(t,y,h,ydot)
% One step of Euler�s Method
% Input: Current time t, current value y, stepsize h, and the function ydot(t,y) which has the following properties
    % Input (t,y), where t is the time and y = [x, y, u, v]
    % Returns vector z = [u v a_x a_y]
% Output of eulerstep: Approximate solution value [x, y, u, v] at time t+h

y = y + h*ydot(t,y);

end
