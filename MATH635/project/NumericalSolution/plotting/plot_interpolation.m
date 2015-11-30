function plot_interpolation(t, u)
% Given the output of the numerical scheme, use linear splines to plot the
% solution.
%
% Returns the plot of the solution.

n = length(t);
y = zeros(n, 1);

for i=1:length(t)
    y(i, 1) = feval(@linear_interpolation, t, u, t(i));
end

plot(t, y)

end