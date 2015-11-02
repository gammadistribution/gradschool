clear
interval = [-5, 5];
% XRange for plot
X = -5:0.01:5;
subintervals = [10, 20, 40, 80];


% Use uniform nodes.
subplots = [];    

for i=1:length(subintervals) 
    subplots(i) = subplot(length(subintervals), 2, 1 + 2*(i-1));

    hold on;
    
    n = subintervals(i);

    nodes = uniform_nodes(interval, n);
    lagrange_interpolation = @(x) lagrange(x, nodes, @interpolating_function);

    Y = arrayfun(lagrange_interpolation, X);
    Y_actual = arrayfun(@interpolating_function, X);
    
    p = plot(X, Y);
    p_actual = plot(X, Y_actual);
    
    alpha(0.6);
    
    title(sprintf('Uniform nodes for subintervals n = %i', n));
end


% Use chebyshev nodes.
for i=1:length(subintervals) 
    subplots(i) = subplot(length(subintervals), 2, 2*i);

    hold on;
    
    n = subintervals(i);

    nodes = chebyshev_nodes(interval, n);
    lagrange_interpolation = @(x) lagrange(x, nodes, @interpolating_function);

    Y = arrayfun(lagrange_interpolation, X);
    Y_actual = arrayfun(@interpolating_function, X);
    
    p = plot(X, Y);
    p_actual = plot(X, Y_actual);

    alpha(0.6);

    title(sprintf('Chebyshev nodes for subintervals n = %i', n));
end

linkaxes(subplots, 'xy');

leg = legend([p, p_actual], {'P_n(f, x)', 'f(x)'}, 'Orientation', 'horizontal');

set(leg, 'Position', [0.457407 0.0126621 0.118518 0.0585683], 'Units', 'normalized');