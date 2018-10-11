% week 1 day 3 practice 2 problem 3: Fibonacci number
% function to generate coefficients s is in coeffcos.m
%writer: Yu Tian

function out = fibonacci (n)
f = ones(n,1);
if n == 0 
    out = 0;
else if n == 1
        out = 1;
    else
    for i = 3:n
        f(i) = f(i-1) + f(i-2);
    end
    out = f(n);
end
end


