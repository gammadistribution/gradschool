function [t, u] = implicit_eulers_method(func, interval, eta, n, epsilon)
% Computes the approximate solution to the first order cauchy problem 
% over the passed interval where func(t, y) is the first order derivative 
% of y. Note that eta is the initial condition of the problem, n is the
% number of partitions of the interval to compute the solution, and epsilon
% is the error in the value of the initial condition. 
% 
% Returns the points within the interval used to compute the solution, t, 
% and the values of the first derivative at those points.

% Create array of points within interval.
t = uniform_nodes(interval, n);

% The first element of the solution array is the initial condition.
u = [eta + epsilon];

% Create the solution array.
for i=1:length(t) - 1
    h = t(i + 1) - t(i);

    syms v;
    next_step = solve(v == u(i) + h*func(t(i) + h, v), v);

    phi = func(t(i) + h, next_step);

    u(i + 1) = u(i) + h*phi;
end  

t = t';
u = u';

end
