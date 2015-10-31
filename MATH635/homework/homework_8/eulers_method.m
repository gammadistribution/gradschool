function [t, u] = eulers_method(func, interval, eta, n, epsilon)
% Computes the approximate solution to the first order cauchy problem 
% over the passed interval where func(t, y) is the first order derivative 
% of y. Note that eta is the initial condition of the problem, n is the
% number of partitions of the interval to compute the solution, and epsilon
% is the error in the value of the initial condition. 
% 
% Returns the points within the interval used to compute the solution, t, 
% and the values of the first derivative at those points.
a = interval(1);
b = interval(2);

t = [];

% Create array of points within interval.
for i=1:n+1
    if i == 1
        element = a;
    else
        element = t(i-1) + 1/n;
    end
    t(i) = element;
end

% The first element of the solution array is the initial condition.
u = [eta + epsilon];

% Create the solution array.
for i=1:length(t) - 1
    u(i + 1) = u(i) + (t(i + 1) - t(i))*func(t(i), u(i));
end  

t = t';
u = u';

end
