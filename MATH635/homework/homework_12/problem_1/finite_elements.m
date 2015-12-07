function u_2 = finite_elements(interval)

syms x;
syms a_1;
syms a_2;

phi_1 = x*(x-2);
phi_2 = (x.^2)*(x-2);

u = 7/4*x + a_1*phi_1 + a_2*phi_2;

M = diff(u, 2) + u - 3*x.^2;

int_1 = int(M * phi_1, x, interval(1), interval(2));
int_2 = int(M * phi_2, x, interval(1), interval(2));

coefficients = solve(int_1 == 0, int_2 == 0);

coefficients.a_1
coefficients.a_2

u_2 = subs(u, [a_1, a_2], [coefficients.a_1, coefficients.a_2]);

end