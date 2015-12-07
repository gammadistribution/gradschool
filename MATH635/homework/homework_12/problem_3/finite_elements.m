function coefficients = finite_elements(interval)

syms x;
syms a_1;

phi_1 = x*sin(pi*x);

u = a_1*phi_1;

M = diff(u, 2) + u.^2 - x;

int_1 = int(M * phi_1, x, interval(1), interval(2));
simplify(int_1)
coefficients = solve(int_1 == 0)


end
