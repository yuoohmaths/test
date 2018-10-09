%week 1 day 1 matlab crash course practice 0
%Written by Yu Tian
%08/10/2018 

%comments on problem 6: this picture actually shows the plot of the central finite
%difference approximation to second derivative of the function f =
%sin(pi*x)


clear, clc, close all

v = ones(15, 1);
D2 = diag(v, -1) + diag(-2*[v;1]) + diag(v,1); %this should be done in order (at least in my computer)
D2(1, 16) = 1;
D2(16, 1) = 1;
h = 2/16;
D2 = (1/h)^2 * D2

D2 = (1/h)^2 * toeplitz([-2, 1, zeros(1, 13), 1])

N = 16;
h = 2/N;
v = ones(N-1, 1);
D2 = diag(v, -1) + diag(-2*[v;1]) + diag(v,1); 
D2(1, N) = 1;
D2(N, 1) = 1;
D2 = (1/h)^2 * D2


D2 = (1/h)^2 * toeplitz([-2, 1, zeros(1, N-3), 1])

for i = 1:4
    N = 16*i;
    h = 2/N;
    D2 = (1/h)^2 * toeplitz([-2, 1, zeros(1, N-3), 1])
end

x = -1: 2/N: 1 - 2/N;
f = sin(pi*x');
D2f = D2*f;
plot(x, D2f)

figure(1)
subplot(2,1,1)
plot(x, D2f); %first plot the approximation
title("finite difference approximation to d^2(sin(pi*x))/dx^2");
xlabel('x');
ylabel('-pi^2*sin(pi*x)');
subplot(2,1,2)
plot(x, (-pi^2*f)-D2f); %then plot the error, remember to put bracket!
xlabel('x');
ylabel('approximation error')

clf %clean all the figures
N = 256;
h = 2/N;
D2 = (1/h)^2 * toeplitz([-2, 1, zeros(1, N-3), 1]);
x = -1: 2/N: 1 - 2/N; %this actually produces here is a row vector
f = exp(sin(pi*x'));
D2f = D2 * f;
plot(x, f)
hold on
plot(x, D2f)

fpp = @(x)[pi^2*exp(sin(pi*x')).*(cos(pi*x').^2-sin(pi*x'))];
plot(x, fpp(x))
hold off
xlabel('x')

plot(x, (D2f - fpp(x))) %remember to keep the dimension matching!

N = 256;
h = 2/N;
D2 = (1/h)^2 * toeplitz([-2, 1, zeros(1, N-3), 1]);
x = -1: 2/N: 1 - 2/N; %this actually produces here is a row vector
f = sin(pi*x');
A = (D2 - eye(N))/(1+pi^2);
plot(x, A\f) %actually solution to y''-y=(1+pi^2)sin(pi*x)


N = 256; 
h = 2/N;
e = ones(N,1);
D2 = spdiags([e -2*e e], -1:1, N, N); %this creates the sparse NxN matrix, with diagonal specified by [] with diagonal -1:1
D(1, N) = 1;
D(N, 1) = 1;
x = -1: 2/N: 1 - 2/N; %this actually produces here is a row vector
f = sin(pi*x');
A = (D2 - eye(N))/(1+pi^2);
plot(x, A\f)
title('Finite difference approximation to d^2y/dx^2 sin(pi*x)')
xlabel('x');
ylabel('-pi^2*sin(pi*x)')

e = eig(D2) %this gives all the eigenvalues of the matrix







