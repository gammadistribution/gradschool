function [t, u] = solution(interval, n, epsilon)
% Function that is the exact solution to the differential equation found 
% in first_derivative.m.
%
% Returns the vector of nodes and the exact solution at those nodes.
t = uniform_nodes(interval, n);
u = 1/3 - t + epsilon * exp(-150.*t);

u = u';

end
