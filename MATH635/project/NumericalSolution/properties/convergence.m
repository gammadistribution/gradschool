format short eng;

addpath(genpath('../'))

c = 1;
initials = [0, 0];
interval = [0, 1];
max_order = 4;

functions = {@(x) x, @(x) x.^2, @(x) x.^3, @(x) x.^4, @(x) x.^5, ...
             @(x) exp(0.5*x), @(x) sin(0.1*x)};

body = [];
for f=1:length(functions)
    disp(functions(f))
    e = convergence_test(functions{f}, c, initials, interval, max_order);
    body = [body, e];
end

disp(functions')
disp(body')
