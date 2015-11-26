f = @(x) x;
c = 1;
initials = [0, 1];
interval = [0, 1];
subintervals = 10;

[x, u] = numerical_scheme(f, c, initials, interval, subintervals);

solution = analytical_solution(f, c, initials);

u_h = [];
for i=1:length(x)
    u_h = [u_h; double(solution(x(i)))];
end

norm(u_h - u, inf);

