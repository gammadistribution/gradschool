% Find the exact degree of precision of Simpson's 3/8 rule.

for i=0:4
    func = @(x) x.^i;
    quadrature = simpsons_rule(func);
    integral = quad(func, 0, 1, eps);
    if abs(integral - quadrature) > eps
        fprintf('The quadrature has exact degree of precision %i. \n', i -1)
    end
end
    