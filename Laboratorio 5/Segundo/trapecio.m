clear;


f = inline ("e .^ (x .^ 2)");
M = 100000;
interval = [-1 3];

a = interval(1);
b = interval(2);
h = (b - a) / M;

subintervals = [ a :  h : b](2 : end-1);

result = h / 2 * (f(a) + f(b)) + h * sum(f(subintervals));

disp (result)








