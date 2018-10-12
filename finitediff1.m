% Week 1 Day 5 Problem sheet 7 finite difference 
% Possion equations in 1d
%writer: Yu Tian

N = 1000;
xmin = 0;
xmax = 1;
a = 0;
b = 0.1;
h = (xmax - xmin)/N;
xg = linspace(xmin,xmax,N+1);
f = @(x)(10*sin(20*x) + cos(x.^5));
fr = f(xg)';
fr(1) = a;
fr(N + 1) = b;
D1 = (1/h)^2 * toeplitz([-2, 1, zeros(1, N-1)]);
D1(1, 1) = 1;
D1(1, 2) = 0;
D1(N + 1, N) = 0;
D1(N + 1, N + 1) = 1;
u = D1\fr;
plot(xg,u)