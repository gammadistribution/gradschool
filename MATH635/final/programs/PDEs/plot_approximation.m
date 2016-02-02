f = @(x) 1 - x;

u_7 = finite_element_approximation(f);

n = 10;
x_bound = [-4, 4];
y_bound = [-2, 2];

X = linspace(x_bound(1), x_bound(2), n);
Y = linspace(y_bound(1), y_bound(2), n);
