function equation = plane_equation(p1, p2, p3)
% Given three points on the plane, return the equation of the plane in 
% terms of x and y in the cartesian 2-D plane. We assume points p1 and p2
% are the points with 0 in the z-component.

v1 = p3 - p1;
v2 = p2 - p1;

n = cross(v1, v2);

x0 = p1(1); y0 = p1(2); z0 = p1(3);

a = n(1); b = n(2); c = n(3);

equation = @(x, y) ((-a * (x - x0) - b * (y - y0)) / c) + z0;

end
