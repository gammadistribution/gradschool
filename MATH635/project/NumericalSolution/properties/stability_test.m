function diff = stability_test(f, c, initials, interval, perturbation)

h_values = feval(@(x) 1000.*x, 1:15);

diff = [];
for i=1:length(h_values)
    h = h_values(i);
    disp(h)

    [x, u] = numerical_scheme(f, c, initials, interval, h);
    [x_z, z] = numerical_scheme(@(x) f(x) + perturbation, c, initials, interval, h);
    
    diff = [diff; norm(u - z, inf)];
end
