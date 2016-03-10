function y = eulerstep(t, y, h, V_DC, V_AC, m)
% One step of Euler's Method
% Input: Current time t, current value y, stepsize h, and the function ydot(t,y) which has the following properties
    % Input (t,y), where t is the time and y = [x, y, u, v]
    % Returns vector z = [u v a_x a_y]
% Output of eulerstep: Approximate solution value [x, y, u, v] at time t+h

if nargin == 5;
    y = y + h*ydot(t, y, V_DC, V_AC);
elseif nargin == 6
    y = y + h*ydot(t, y, V_DC, V_AC, m);
end

end
