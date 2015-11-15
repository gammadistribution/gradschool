function [t, u] = runge_kutta_method(func, interval, eta, n, epsilon)
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

    k_1 = func(t(i), u(i));
    k_2 = func(t(i) + h/2, u(i) + (h/2)*k_1);
    k_3 = func(t(i) + h/2, u(i) + (h/2)*k_2);
    k_4 = func(t(i) + h, u(i) + h*k_3);
    
    phi = (1/6)*(k_1 + 2*k_2 + 2*k_3 + k_4);
    
    u(i + 1) = u(i) + h*phi;
end  

t = t';
u = u';

end
