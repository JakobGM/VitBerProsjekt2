function y = RK4(t, y, h, ydot, V_DC, V_AC)
% One step of RK4
% Input: Current time t, current value y, stepsize h
% Output: Approximate solution value at time t+h
if nargin == 4;
    s1 = ydot(t, y);
    s2 = ydot(t+h/2, y+(h/2)*s1);
    s3 = ydot(t+h/2, y+(h/2)*s2);
    s4 = ydot(t+h, y+h*s3);

    y = y+(h/6)*(s1+2*s2+2*s3+s4);

else
    s1 = ydot(t, y, V_DC, V_AC);
    s2 = ydot(t+h/2, y+(h/2)*s1, V_DC, V_AC);
    s3 = ydot(t+h/2, y+(h/2)*s2, V_DC, V_AC);
    s4 = ydot(t+h, y+h*s3, V_DC, V_AC);

    y = y+(h/6)*(s1+2*s2+2*s3+s4);
end

end