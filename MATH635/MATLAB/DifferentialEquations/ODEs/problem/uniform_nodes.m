function t = uniform_nodes(interval, n)
% Create uniform nodes on the given interval with n subintervals.
%
% Returns array of endpoints for each subinterval.

a = interval(1);
b = interval(2);

t = [];

for i=1:n+1
    x_i = a + (b - a)*((i - 1)/n);
    
    t = [t, x_i];
end
    
end
