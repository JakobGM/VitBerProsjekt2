function new_w = rk4Step(t, w, h, V_DC, V_AC, m)
% One step of Runge-Kutta method of order four
% Input: Current time t, current value y, stepsize h
% Output: Approximate solution value at time t+h

if nargin == 5;
    s1 = lhs_dot(t, w, V_DC, V_AC);
    s2 = lhs_dot(t + h/2, w + (h/2)*s1, V_DC, V_AC);
    s3 = lhs_dot(t + h/2, w + (h/2)*s2, V_DC, V_AC);
    s4 = lhs_dot(t + h, w + h*s3, V_DC, V_AC);

    new_w = w+(h/6)*(s1 + 2*s2 + 2*s3 + s4);

elseif nargin == 6
    s1 = lhs_dot(t, w, V_DC, V_AC, m);
    s2 = lhs_dot(t + h/2, w + (h/2)*s1, V_DC, V_AC, m);
    s3 = lhs_dot(t + h/2, w + (h/2)*s2, V_DC, V_AC, m);
    s4 = lhs_dot(t + h, w + h*s3, V_DC, V_AC, m);

    new_w = w + (h/6)*(s1 + 2*s2 + 2*s3 + s4);

else
  error('rk4Step() was not given the proper amount of parameters');
end

end
