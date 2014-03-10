%% BME 790.01F13: Engineering Programming and Signal Processing
%% Worksheet 4 Kanishk Asthana ka112@duke.edu
%% Task 1

% Intializing time variable t from -2 to 4 with a step size of 0.1
t=-2:0.1:4;
%% Task 2

%Initializing x(t) vector with same size as t
x=zeros(length(t),1);
%Function described in class was a piecewise function defined as x(t)= -t+2
%for t in the interval [0,2] and x(t)=t-2 for the interval (2,4];

%Specifying first part of the piecewise function x(t)
x(t>=0 & t<=2)=(-1.*t(t>=0 & t<=2))+2;
%Specifying the second part of piecewise function x(t)
x(t>2 & t<=4)=t(t>2 & t<=4)-2;
%Plotting x(t) versus t in blue colour.
plot(t,x,'b');

%% Task 3

%Holding on to compare new shifted function with the original.
hold on;
% The new required function is a plot of x(-t/4 -2) vs t.
%Let the value -t/4 -2 be represented by t', so the original function can be
%thought of as a plot of x(t') vs t'(I have only changed the name of the
%variable this is a valid math operation).
%Since we have assumed t'=-t/4-2 the original function can be thought of as
%a plot of x(-t/4 -2) vs (-t/4-2). However what we need is a plot between
%x(-t/4-2) vs t. So by changing the time vector we can replot the orignial
%values of the function both shifted and scaled.
%Since we have all the values of the original time vector t' we can use
%this to compute the values of the t vector.
%We have the relation t'=-t/4-2 so t'+2=-t/4 or 4t'+8=-t or t=-4t-8
%There for plotting -4*t'-8 (where t' is the original time vector we can
%scale and shift our function.
%Plotting:
plot(-4.*t-8,x,'r');
%Annotating plot
title('Not using user defined flipshift function');
legend('Original Function','Shifted function');

%% Task 4

%Using the above explaination an arbitary flip and shift function can be
%defined.
%Defining a new MATLAB function flipshift.m (please see file for
%implementation and explanation)
%Using the new flipshift fucntion to create the new fucntion x(-t/4-2)
%Using the notation defined in the function (please see flipshift.m) we see
%the scale is -1/4 and the shift is +8. Passing these values to the
%function we should get the same result as in the previous task
tnew=flipshift(x,t,-0.25,8);
%Plotting original x(t) vector against shited and scaled to to get shited
%and scaled funciton:
figure;
hold on;
plot(t,x,'r');
plot(tnew,x,'g');
%Annotating plot
title('Using user defined flipshift function');
legend('Original Function','Shifted function');