%BME 790.01 Fall 2013 In Class Worksheet 2 Kanishk Asthana ka112@duke.edu

clf;
clear;
%First Task
%First Method
t=-5:0.1:5

%Second Method
t2=linspace(-5,5,length(t))

%So to verify that they are identical we can find the difference between
%the two matrices find the standard deviation for the difference matrix and
%also find the mean of this matrix. A very small value should indicate that
%they are identical.
%Note: I tried doing this with the matlab function isequal but this seemed
%to work only for integer values stored in the two matrixes. By hypothesis
%is the minor differences in storage of these values is leading to this
%error.

difference=t-t2
std(difference)
mean(difference)

%We can also identify if they are equal visually by comparing the two
%vectors side by side in a Matrix
comparesidebyside=[t;t2]

%%Task 2:Creating new vectors:
Rect=zeros(length(t),1)'
Delta=zeros(length(t),1)'
Step=zeros(length(t),1)'
Ramp=zeros(length(t),1)'

%Verifing that they are equal:as explained above I don't know why isequal
%did not work even here
%isequal(Rect,Delta,Step,Ramp)

difference=Rect-Delta
std(difference)
mean(difference)

difference=Delta-Step
std(difference)
mean(difference)

difference=Step-Ramp
std(difference)
mean(difference)


%Task 3:
%Since a here for rect function is 2. Therefore for the indices of t where
% t>=-1 to t<=1; rect should have a value of 1
Rect(t>=-1 & t<=1)=1
plot(t,Rect,'b')

%Task 4:The delta function should have a value of 1 at the index where t=0
Delta(t==0)=1
hold on;
plot(t,Delta,'k')

%Task 5: The step function should have the value 1 for the indices where
%t>=0.
Step(t>=0)=1
plot(t,Step,'r')

%Task 6: The ramp function should be numerically equal to time for all all
%the indices where t>=0

Ramp(t>=0)=t(t>=0)
plot(t,Ramp,'g')

title('Functions');
legend('Rect','Delta','Step','Ramp','Location','NorthWest')
ylabel('Function Value')
xlabel('Time')
