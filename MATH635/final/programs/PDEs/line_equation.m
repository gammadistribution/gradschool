function y = line_equation(p1, p2)
% Determine the equation of the line passing through the two points in 2D.

difference = p2 - p1;
slope = difference(2) / difference(1); x0 = p1(1); y0 = p1(2);

y = @(x) slope * (x - x0) + y0;

end