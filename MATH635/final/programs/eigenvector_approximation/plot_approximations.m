clear all
nodes = [2, 8, 15, 50];
plot_nodes = 0:0.001:pi;

for j=1:length(nodes)
    n = nodes(j);

    y_n = eigenvector_approximation(@hat_basis, n);

    subplot(length(nodes), 1, j)    
    
    subplot_title = sprintf('-0.85sin(x) vs Approximation y%i', n);

    approximations = [];
    for i=1:length(plot_nodes)
        plot_node = plot_nodes(i);
        approximations = [approximations, y_n(plot_node)];
    end

    plot(plot_nodes, feval(@(x) -0.85*sin(x), plot_nodes), plot_nodes, approximations)
    legend('Exact Solution', 'Approximation')
    title(subplot_title)
end
