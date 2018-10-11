% Week 1 Day 4 Practice 2 Problem 11
% compute the N-point trapezoidal rule approximation of the integral of the
% input function
% wirter: Yu Tian

%furhter improvement possible as lecturer has shown that we can instead use
%linspace(a, b, N) to get the grid points!

function fint = trapIntegral(f, a, b, N)
if a > b
    c = a;
    a = b;
    b = c;
end
n = (b-a)/N;
sum = 0;
for i = 0:(N-1)
    sum = f(a+i*n) + f(a+(i+1)*n) + sum; %remember to add them each time!
end
fint = 0.5*n*sum;
end

    