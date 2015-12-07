interval = [0,1];
points = [0.25, 0.5, 0.75];


% This is the actual solution to the differential equation
y = @(x) (exp(x) - 1)/(exp(1) - 1);

% This is the approximation to the solution
y_n = solution(interval, 15);

for i=1:length(points)
    point = points(i)
    exact = y(point)
    approx = double(subs(y_n, point))
    diff = abs(exact - approx)
    rel_error = (diff / abs(exact)) * 100
end