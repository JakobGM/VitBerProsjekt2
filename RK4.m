function y = RK4(t, y, h, V_DC, V_AC, m)
% One step of RK4
% Input: Current time t, current value y, stepsize h
% Output: Approximate solution value at time t+h
if nargin == 5;
    s1 = ydot(t, y, V_DC, V_AC);
    s2 = ydot(t + h/2, y + (h/2)*s1, V_DC, V_AC);
    s3 = ydot(t + h/2, y + (h/2)*s2, V_DC, V_AC);
    s4 = ydot(t + h, y + h*s3, V_DC, V_AC);

    y = y+(h/6)*(s1 + 2*s2 + 2*s3 + s4);
    
elseif nargin == 6
    s1 = ydot(t, y, V_DC, V_AC, m);
    s2 = ydot(t + h/2, y + (h/2)*s1, V_DC, V_AC, m);
    s3 = ydot(t+h/2, y+(h/2)*s2, V_DC, V_AC, m);
    s4 = ydot(t+h, y+h*s3, V_DC, V_AC, m);

    y = y+(h/6)*(s1+2*s2+2*s3+s4);
end

end