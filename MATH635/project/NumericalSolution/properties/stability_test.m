function diff = stability_test(f, c, initials, interval, perturbation)
% Compute the normed difference between the numerical solution for the
% unperturbed solution and the perturbed solution 
% (adding perturbation to f) for the numerical scheme
% to the problem to -u''(x) + c*u(x) = f(x) on the passed interval 
% with the initial conditions u(interval(1)) = initials(1) and 
% u(interval(2)) = initials(2). 
%
% Returns the vector diff showing the normed difference between the 
% solution for the unperturbed problem and the solution for the perturbed 
% problem for each of the given h_values.

% Get values of h from h=1000 to h = 21,000.

h_values = [10, feval(@(x) 1000.*x, 1:2:15)];
h_values = [1.5e4];

diff = [];
for i=1:length(h_values)
    h = h_values(i);
    
    % Compute unperturbed solution
    [x, u] = numerical_scheme(f, c, initials, interval, h);
    
    % Compute perturbed solution
    [x_z, z] = numerical_scheme(@(x) f(x) + perturbation, c, initials, interval, h);
    
    diff = [diff; norm(u - z, inf)];
end
