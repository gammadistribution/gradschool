% Create graph of Hilbert conditionining versus dimension for 1, 2, and
% inf norms.

% Number of plots in subplot
n_plots = 3;
fig_title = 'Hilbert Matrix H Condition vs Dimension';
x_axis = 'Dimension';

% anonymous function to get conditioning of hilbert matrix of size n for
% p-norm.
log_hil_cond = @(n, p) log(cond(hilbert(n), p));

subplots = [];

for p = 1:n_plots
    subplots(p) = subplot(n_plots, 1, p);
    
    if p > 2
        p_cond = @(n) log_hil_cond(n, inf);
        y_axis = 'log(cond(H, inf))';
        
    else
        p_cond = @(n) log_hil_cond(n, p);
        y_axis = sprintf('log(cond(H, %d))', p);
    end
    
    X = 1:24;
    Y = arrayfun(p_cond, X);
    
    h = plot(X, Y, 'ob','MarkerFaceColor','b');
    
    title(fig_title);
    ylabel(y_axis);
    xlabel(x_axis);
end
