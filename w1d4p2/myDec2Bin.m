%Week 1 Day 4 Practice 2 Problem 10 mcc
%write a function that has the same function as dec2bin, that is to
%reproduce the number from decimal to binary.
%writer: Yu Tian

function b = myDec2Bin(d)
m = 10;
Max = 2^m - 1;
b = zeros(1,m);
d = floor(d);
if d < 0 || d > Max
    b = NaN;
else if d == 0
        b = '0';
    else
        i = m;
        while d
            b(i) = rem(d,2);
            d = floor(d/2);
            i = i-1;
        end
        b(1:i) = [];
        b = 48 + b;
        b = char(b); %basic way to change from number to characters!
    end
end

       
        
    