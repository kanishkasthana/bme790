function [ yint ] = integrate( y, dx )
%Integrates the input y using trapezoid approximation, starting at the
%first time point
len=length(y);
yint=zeros(1,len);
carry=0;

for k=1:len-1
    yint(k+1)=(y(k)+y(k+1))/2*dx+carry;
    carry=yint(k+1);
end





end

