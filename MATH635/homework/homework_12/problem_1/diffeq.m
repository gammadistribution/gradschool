function y = diffeq(interval, initials)

syms y(x);

eqn = diff(y, 2) + y == 3*x.^2;

y = dsolve(eqn, y(interval(1)) == initials(1), y(interval(2)) == initials(2));

end