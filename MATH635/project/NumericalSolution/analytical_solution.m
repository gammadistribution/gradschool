function u = analytical_solution(f, c, initials, x)
% For the given function f, find the analytical solution to the second 
% order differential equation -u''(s) + c * u(s) = f(s) where the passed
% parameter c is positive subject to the initial conditions u(0) =
% initials(1) and u(1) = initials(2).
%
% Returns the solution to the differential equation u(s) evaluated at x.

if c <= 0
    error('c must be positive.')
end

epsilon = initials(1);
delta = initials(2);
omega = sqrt(c);

syms r;
syms s;

% For our particular solution u_p, u_p(x) = kappa(x) * exp()
kappa = @(y) -int(exp(-2 * omega * s) * int(@(r) exp(omega * r)* f(r), 0, s), 0 , y);

denominator = exp(-omega) - exp(omega);
c_1 = (epsilon * exp(-omega) - delta - exp(omega) * kappa(1)) / denominator;
c_2 = (-epsilon * exp(-omega) + delta + exp(omega) * kappa(1)) / denominator;

homogeneous_solution = c_1 * exp(omega * x) + c_2 * exp(-omega * x);
particular_solution = kappa(x) * exp(omega * x);

% The analytical solution is given by the homogeneous solution plus the 
% particular solution.
u = homogeneous_solution + particular_solution;

end