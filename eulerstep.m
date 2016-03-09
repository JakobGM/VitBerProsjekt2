function y=eulerstep(t,y,h,ydot)
% One step of Euler’s Method
% Input: Current time t, current value y, stepsize h
% Output: Approximate solution value at time t+h
y=y+h*ydot(t,y);

end