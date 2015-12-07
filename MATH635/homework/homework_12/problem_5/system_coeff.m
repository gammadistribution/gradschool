function coeff = system_coeff(i, j, interval)

syms x;

int_1 = int((x + 1)*i*j*(pi^2)*cos(i*pi*x)*cos(j*pi*x), x, interval(1), interval(2));

int_2 = int((x + 2)*sin(i*pi*x)*sin(j*pi*x), x, interval(1), interval(2));

coeff = int_1 + int_2;

end

