function [x, u] = numerical_scheme(f, c, initials, interval, subintervals)
% Implements the numerical scheme to solve the second order differential
% equation -u''(x) + c * u(x) = f(x). f is the handle to the specified
% function f(x) and c is the unknown constant present in the equation which
% must be positive. The array initials are the initial conditions of the
% boundary problem and the first element is the condition at the left
% endpoint of the interval and the second element is the condition at
% right endpoint of the interval passed. subintervals is the number of
% subintervals from which to construct the nodes for the scheme to use.
%
% Returns the nodes x and the solution u(x) at those nodes.

if c <= 0
    error('c must be positive.')
end

% Create uniform nodes on interval with specified number of subintervals.
if subintervals > 1
    x = uniform_nodes(interval, subintervals)';
    v = x(2:subintervals);
else
    error('Number of subintervals must be greater than 1.')
end

u_0 = initials(1);
u_N = initials(2);
h = 1 / subintervals;

% We wish to find v = [u_1, ..., u_subintervals-1] such that Av = b.

% Define b as the evaluation of f at the nodes x_1, ..., x_subintervals-1 
% with the exception of the first and last element which is 
% f(x(1)) + initials(1) and f(x(subintervals-1)) + initials(2) respectively.
b = h^2 * f(v);
b(1) = b(1) + u_0;
b(length(b)) = b(length(b)) + u_N;

% We need to construct the coefficient matrix A.
main_diag = diag(repelem([2 + c * h^2], length(v)), 0);
sub_diag = diag(repelem([-1], length(v) - 1), -1);
sup_diag = diag(repelem([-1], length(v) - 1), 1);

A = main_diag + sub_diag + sup_diag;

v = inv(A) * b;

% Our solution is then u = [u_0, v_1, ..., v_N-1, u_N].
u = [u_0; v; u_N];

end