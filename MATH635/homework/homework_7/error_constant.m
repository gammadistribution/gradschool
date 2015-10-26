% Choose polynomial q(x) = x^4. Then the fourth derivative of q is 24 and
% we can easily compute the error constant.

func = @(x) x.^4;

quadrature = simpsons_rule(func);
integral = quad(func, 0, 1, eps);

fourth_derivative = 24;

constant = (integral - quadrature) / fourth_derivative;

fprintf('The error constant c_s38 = %d.\n', constant)
