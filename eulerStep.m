function new_w = eulerStep(t, w, h, V_DC, V_AC, m)
% One step of Euler's Method
% Input: Current time t, current value y, stepsize h, and the function ydot(t,y) which has the following properties
    % Input (t,y), where t is the time and y = [x, y, u, v]
    % Returns vector z = [u v a_x a_y]
% Output of eulerstep: Approximate solution value [x, y, u, v] at time t+h

if nargin == 5;
    new_w = w + h*wdot(t, w, V_DC, V_AC);
    
elseif nargin == 6
    new_w = w + h*wdot(t, w, V_DC, V_AC, m);
    
else
    error('eulerStep() was not given the proper amount of arguments');
end

end

