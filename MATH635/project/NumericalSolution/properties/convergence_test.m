function e = convergence_test(f, c, initials, interval, max_order)
% Compute the normed difference between the numerical solution and
% analytical solution to -u''(x) + c*u(x) = f(x) on the passed interval 
% with the initial conditions u(interval(1)) = initials(1) and 
% u(interval(2)) = initials(2) on nodes of increasing size from 10^1 to 
% 10^max_order. 
%
% Returns the vector e showing the normed difference for each 
% subinterval size. As the subinterval size increases, i.e. as the h-value 
% increases, the normed difference should be decreasing.

e = [];
subintervals = feval(@(x) 10.^x, 1:max_order);

solution = analytical_solution(f, c, initials);

for i=1:length(subintervals)
    h = subintervals(i);
    
    % Compute numerical scheme for given h-value.
    [x, u] = numerical_scheme(f, c, initials, interval, h);

    % Compute analytical solution at given nodes
    u_h = subs(solution, x);
    
    % Add to epsilon vector the norm of the difference.
    e = [e; double(norm(u_h - u, inf))];
end
