 % Week 1 Day 3 practice 2 problem 5 mcc
 % Newton Method
 %writer: Yu Tian

function out = newton (x0)
tol = 1e-4;
err = 1;
x = x0;
while err > tol
    x = x0 - (cos(x0) + sin(x0))/(cos(x0) - sin(x0));
    err = abs(x - x0);
    x0 = x;
end
out = x;
end