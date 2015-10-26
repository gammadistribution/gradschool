function quadrature = simpsons_rule(func)
% Using simpson's 3/8 quadrature rule, find the quadrature of the passed
% function, func over the interval [0, 1].

quadrature = (1/8)*(func(0) + 3*func(1/3) +3*func(2/3) + func(1));

end

