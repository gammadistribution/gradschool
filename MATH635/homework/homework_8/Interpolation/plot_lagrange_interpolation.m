clear
interval = [-5, 5];
% XRange for plot
X = -5:0.01:5;
subintervals = [10, 20, 40, 80];


% Use uniform nodes.
subplots = [];    

for i=1:length(subintervals) 
    subplots(i) = subplot(length(subintervals), 2, 1 + 2*(i-1));

    n = subintervals(i);

    nodes = uniform_nodes(interval, n);
    lagrange_interpolation = @(x) lagrange(x, nodes, @interpolating_function);

    Y = arrayfun(lagrange_interpolation, X);
    
    p = plot(X, Y);
    title(sprintf('Interpolating Polynomial with Uniform nodes for subintervals n = %i', n));
end


% Use chebyshev nodes.
for i=1:length(subintervals) 
    subplots(i) = subplot(length(subintervals), 2, 2*i);

    n = subintervals(i);

    nodes = chebyshev_nodes(interval, n);
    lagrange_interpolation = @(x) lagrange(x, nodes, @interpolating_function);

    Y = arrayfun(lagrange_interpolation, X);
    
    p = plot(X, Y);
    title(sprintf('Interpolating Polynomial with Chebyshev nodes for subintervals n = %i', n));
end

linkaxes(subplots, 'xy');
