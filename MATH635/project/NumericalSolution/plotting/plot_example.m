addpath(genpath('../'))  

f = @(x) x;
c = 1;
initials = [0, 0];
interval = [0, 1];

h_values = [5, 10, 50];
    
for i=1:length(h_values)
    h = h_values(i);
    
    subplots(i) = subplot(length(h_values), 1, i)
    
    [x, u] = numerical_scheme(f, c, initials, interval, h);
    
    solution = analytical_solution(f, c, initials);
    
    u_h = subs(solution, x);
    
    plot_interpolation(x, u);
end    
