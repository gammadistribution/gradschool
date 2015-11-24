function u = analytical_solution(f, c, initials)
% For the given function f, find the analytical solution to the second 
% order differential equation -u''(x) + c * u(x) = f(x) where the passed
% parameter c is positive and subject to the initial conditions u(0) =
% initials(1) and u(1) = initials(2).
%
% Returns a function representing the analytical solution to the above 
% differential equation.

if c <= 0
    error('c must be positive.')
end

epsilon = initials(1);
delta = initials(2);
omega = sqrt(c);

syms r;
syms s;

% Define function to help compute particular solution and constants.
kappa = @(x) int(exp(-2.*omega*s)*int(f(r)*exp(omega.*r), 0, s), 0, x);

% Specify the constants unique to choice of initial conditions.
den = exp(-omega) - exp(omega);
c_1 = (epsilon.*exp(-omega) - delta - exp(omega) .* kappa(1)) ./ den;
c_2 = (-epsilon.*exp(omega) + delta + exp(omega) .* kappa(1)) ./ den;

% Define the homogeneous solution.
u_h = @(x) c_1 * exp(omega .* x) + c_2 .* exp(-omega .* x);

% Define the particular solution.
u_p = @(x) -exp(omega .* x) .* kappa(x);

% The solution to the differential equation is the homogeneous solution 
% plus the particular solution
u = @(x) u_h(x) + u_p(x);

end