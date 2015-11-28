format long;

c = 1;
initials = [1, 0.5];
interval = [0, 1];
max_order = 5;

functions = {@(x) x, @(x) x.^2, @(x) x.^3, @(x) x.^4, @(x) x.^5};
functions = {@(x) x};
body = [];

for f=1:length(functions)
    e = convergence_test(functions{f}, c, initials, interval, max_order);
    body = [body, e];
end

disp(functions);
fprintf('------------------------------------------------------------------------\n');
disp(body);
