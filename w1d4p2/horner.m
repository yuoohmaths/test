% week 1 day 3 practice 2 problem 3: Horner's scheme
% function to generate coefficients s is in coeffcos.m
%writer: Yu Tian

function out = horner (x, s)
n = length(s);
b = zeros (n, 1);
b(n) = s(n);
for i = 1:(n-1)
    b(n-i) = s(n-i) + b(n+1-i)*x; %rememeber the index
end
out = b;
end
