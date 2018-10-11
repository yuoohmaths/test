% week 1 day 3 practice 2 problem 3: bisection method  for the root of
% given function
%writer: Yu Tian

%what is bisection method? the idea behind that is intermediate theorem,
%but for practical reason, we may try part the interval even when f(a) and
%f(b) have the same sign, and set the maximum iteration number if we cannot
%find the answer in maximum times, then we need output NaN.

function r = bisec(f, a, b)
c = (a + b)/2;
err = 1;
tol = 1e-5;
i= 0;
Max = 100;
while f(c)~=0 && err > tol && i < Max
    if f(c)*f(a) <= 0
        b = c;
        c = (a + b)/2;
    end
    if f(c)*f(b)<=0 %more efficient as there check twice!
        a = c;
        c = (a + b)/2;
    end
   i = i + 1;
   err = abs(b-a);
end
if i == Max %include the condition when iteration times is too large or no solution inside, further increase the number of Max can help classify
    r = NaN;
else
    r = c;
end

    
    