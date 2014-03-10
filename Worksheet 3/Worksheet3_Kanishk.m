%% BME 790.01 Engineering Programming and Signal Processing Fall 2013 Worksheet 3 :Kanishk Asthana ka112@duke.edu 

%% Task 1: 

%Clearing any previous figures and variables
clf;
clear;
%Specifying Time step dt
dt=0.01;
%Creating time array t
t=3.5:dt:4.5;
%Defining x(t)
x=1./exp(t-7);
%Plotting x(t) vs time
plot(t,x,'r');

%% Task 2:

%Defining x(t+1)
xtplus1=1./exp(t-6);
%hold on command will ensure that the proceeding plot is on the same figure
%as x(t)
hold on;
%Plotting x(t+1) vs time
plot(t,xtplus1,'k');

%% Task 3:

%Initializing delta(4-t) function
delta4minust=zeros(1,length(t));
%As per definition specifing value of this delta function at t=4 as 1
delta4minust(t==4)=1;
%Since hold is on the following plot will display this delta function along
%with the previous two plots
plot(t,delta4minust,'b');
%Annotating first figure
legend('x(t)','x(t+1)','delta(4-t)');
ylabel('Function values');
xlabel('Time (t)');
title('Figure 1');

%% Task 4:

%Creating the function x(t+1)*delta(4-t)
task4function=xtplus1.*delta4minust;
%Creating new figure window for proceeding plots
figure;
%Dividing figure into three subplots
subplot(3,1,1);
%First subplot function x(t+1)*delta(4-t) vs t
plot(t,task4function);
%Annotating plot
xlabel('Time (t)');
ylabel('Function Value');

%% Task 5:

%Since the delta function in discrete space is defined to have a value of 1 at
%delta(0), the area under the integration curve can only be corrected for
%when this height is changed to 1/dt. Therefore when the area at delta(0)
%is calculated it will be 1/dt*(dt); which is 1; if we would have corrected
%this height the area under the integration curve for this delta function
%would have been dt.

%Recalculating delta(4-t) and x(t+1)*delta(4-t) with corrected height.
delta4minust(find(t==4))=1/dt;
task4function=xtplus1.*delta4minust;

%The integral from -infinity to +infinity for x(t+1)*delta(4-t) should
%therefore be the Summation of x(t+1)*delta(4-t)*dt
%for all t.
%We can find this sum by first creating an array of all the elements
%x(t+1)*delta(4-t)*dt
%Let this matrix be called integralmatrix
integralmatrix=task4function.*dt;
%Therefore sum of all the elements of this matrix should give the value of
%the desired integral
integral=sum(task4function.*dt);

%This integral is only a single number. To visualize this number on a plot
%we can create an array of ones the same length as the time array and
%multiply it elmentwise with the integral above.

newintegral=ones(1,length(t)).*integral;
%Plotting integral value in second subplot.
subplot(3,1,2);
plot(t,newintegral);
%Annotating plot
xlabel('Time (t)');
ylabel('Function Value');

%% Task 6:

%Let us call the required function integralfunction.
%Creating zeros array the same size as the time array.
integralfunction=zeros(1,length(t));
%To plot this function we need to evaluate the integralfunction for every t
%in the time array. This can be done using a for loop.
%Since the integralmatrix defined above contains the elements of sumation
%for the whole time domain; summation of this matrix upto the corresponding
%time index should give the value of the integralfunction for a specific
%time point.

for var=1:length(t)
    integralfunction(var)=sum(integralmatrix(t<=t(var)));
end
%Plotting integral value in third subplot.
subplot(3,1,3);
plot(t,integralfunction);
%Annotating plot
xlabel('Time (t)');
ylabel('Function Value');

%% Task 7:

%As explained in task 5. To get an accurate result the height of the delta
%functions has to be corrected for such that the area calculated is 1
%rather than dt. It is only after this correction that we get the desired
%result

%% Task 8:

%Creating new figure
figure;
%Creating a 256x256 matrix of zeros
imagematrix=zeros(256);

%Now the central 51x51 part of the matrix is to be changed to ones
%This can be done by using tow indexing arrays, both of which go from 128-25 to
%128+25 (which is the central 51 elements).

%Nested for loops can be used to access each one of the required elements.
for xindex=(length(imagematrix)/2-25):(length(imagematrix)/2+25)
  for yindex=(length(imagematrix)/2-25):(length(imagematrix)/2+25)
     imagematrix(xindex,yindex)=1; 
  end
end

%Spliting the figure into two row subplots
subplot(2,1,1);
%imshow should automatically take care of scaling, while keeping pixel
%sizes equivalent.
imshow(imagematrix)

%% Task 9:

%Creating second subplot for third figure window
subplot(2,1,2);
%Plotting central line of image matrix created above.
plot(imagematrix(length(imagematrix)/2,:));
