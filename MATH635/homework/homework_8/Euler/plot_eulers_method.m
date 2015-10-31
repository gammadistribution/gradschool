% Define parameters.
func = @first_derivative;
interval = [0, 1];
eta = 1/3;
epsilon = 0;

sub_intervals = [10, 20, 40];

subplots = [];

for i=1:length(sub_intervals)
    subplots(i) = subplot(length(sub_intervals), 1, i);
    
    n = sub_intervals(i);

    [t, u] = eulers_method(func, interval, eta, n, epsilon);
    
    h = plot(t, u, 'ob', 'MarkerFaceColor', 'b');
    title(sprintf('Solution for n = %i', n));
    ylabel('y');
end

subplot(3, 1, 3).XLim = interval;
subplot(3, 1, 3).YLim = [-10, 10];
linkaxes(subplots, 'x');
