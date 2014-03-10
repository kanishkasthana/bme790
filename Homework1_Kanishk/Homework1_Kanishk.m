%% BME 790.01F13: Engineeering Programming and Signal Processing

%% Homework 1 Kanishk Asthana ka112@duke.edu

%% Problem 1:
clf;
clear;
%Defining time vector:
dt=0.01;
t=-10:dt:10;
%Initializing x(t)
xt=zeros(1,length(t));
%Changing x(t) piecewise:
xt(t>=-1 & t<0)=t(t>=-1 & t<0)-1;
xt(t>=0 & t<1)=t(t>=0 & t<1);
xt(t>=1 & t<2)=1;
xt(t>=2 & t<3)=-1.*t(t>=2 & t<3)+3;
%Plotting x(t) to check
plot(t(t>=-2 & t<=4),xt(t>=-2 & t<=4),'b');
title('x(t)');
%Plot seems correct
%Initializing y(t);
yt=zeros(1,length(t));
%Changing y(t) piecewise:
yt(t>=-2 & t<-1)=1;
yt(t>=-1 & t<0)=-1;
yt(t>=0 & t<1)=t(t>=0 & t<1)-1;
yt(t>=1 & t<2)=1;
%Plotting y(t) to check
figure(2);
plot(t(t>=-3 & t<=3),yt(t>=-3 & t<=3),'b');
title('y(t)');
%Plot seems correct

%(a) Using user defined flipshift function to yet the values of y(t-1)
%As we are doing only a shift and not a scale this shifting operation
%should not lead to a change in time step.
[ytminus1,tnew]=flipshift(yt,t,1,-1);
%Since taking values of t and tnew from -4 to 4 should cover the relevant
%ranges of both function
compositefunction=zeros(1,length(t>=-4 & t<=4));
compositefunction=xt(t>=-4 & t<=4).*ytminus1(tnew>=-4 & tnew<=4);
figure(3);
subplot(3,1,1);
plot(t(t>=-4 & t<=4),xt(t>=-4 & t<=4),'r');
title('x(t)');
subplot(3,1,2);
plot(tnew(tnew>=-4 & tnew<=4),ytminus1(tnew>=-4 & tnew<=4),'g');
title('y(t-1)');
subplot(3,1,3);
plot(t(t>=-4 & t<=4),compositefunction);
title('x(t)y(t-1)');

%(b)Since the second part of this question required a flip y(-t); I cannot
%use the flipshift function to generate to arrays that I can multiply
%elementwise to get the correct answer. I will have to redefine y(-t) to
%get the correct answer.
%Since the time array that I have defined is symmetric. I can use the
%MATLAB built in function fliplr() to solve this problem.
yminust=fliplr(yt);
%Since taking values of t and tnew from -4 to 4 should cover the relevant
%ranges of both functions.
compositefunction=zeros(1,length(t>=-4 & t<=4));
compositefunction=yminust(t>=-4 & t<=4).*ytminus1(tnew>=-4 & tnew<=4);
figure(4);
subplot(2,2,1);
plot(t(t>=-4 & t<=4),yt(t>=-4 & t<=4),'k')
title('y(t)');
subplot(2,2,2);
plot(t(t>=-4 & t<=4),yminust(t>=-4 & t<=4),'r');
title('y(-t)');
subplot(2,2,3);
plot(tnew(tnew>=-4 & tnew<=4),ytminus1(tnew>=-4 & tnew<=4),'g');
title('y(t-1)');
subplot(2,2,4);
plot(t(t>=-4 & t<=4),compositefunction);
title('y(t-1)y(-t)');
%This last subplot shows unusual edge effects at t=-1 and t=2; I'm not sure
%how to get rid of these effects.

%(c)Since this part requires two scale operations using the user defined
%flipshit will lead to a change in size of dt such that an elementwise
%muliplication will lead to the wrong result.
%x(2t) will lead to a compression of dt by a factor or 2.
%Lets redefine x(t) with a new dt to combat this problem, and then use the
%flipshit to get the desired matrix for x(2t):
dt2=2*dt;
t2=-20:dt2:20;
%When this new time vector is compressed using the flipshit we should get
%the same size dt as before for xt;
%Initializing x(t)

xt2=zeros(1,length(t2));
%Changing x(t) piecewise:
xt2(t2>=-1 & t2<0)=t2(t2>=-1 & t2<0)-1;
xt2(t2>=0 & t2<1)=t2(t2>=0 & t2<1);
xt2(t2>=1 & t2<2)=1;
xt2(t2>=2 & t2<3)=-1.*t2(t2>=2 & t2<3)+3;
[xt2new,t2new]=flipshift(xt2,t2,2,0);
figure(5);
subplot(3,1,1);
plot(t,xt);
title('x(t)');
subplot(3,1,2);
plot(t2(t2>=-10 & t2<=10),xt2(t2>=-10 & t2<=10));
title('x(t) with twice the time step');
subplot(3,1,3);
plot(t2new(t2new>=-10 & t2new<=10),xt2new(t2new>=-10 & t2new<=10));
title('x(2t)');

%Redefining time step for y(1/2t + 1); As it will strech
dt3=dt/2;
t3=-5:dt3:5;
%Initializing y(t);
yt2=zeros(1,length(t));
%Changing y(t) piecewise:
yt2(t3>=-2 & t3<-1)=1;
yt2(t3>=-1 & t3<0)=-1;
yt2(t3>=0 & t3<1)=t3(t3>=0 & t3<1)-1;
yt2(t3>=1 & t3<2)=1;
%While doing this shifting and scaling when multiplying two of these
%fucntions I felt: "There has to be a more efficient way of doing this!"
%This just feels like too much code with a lot of redundancies. Can we
%discuss efficient ways of fliping and scaling when multiplying or
%operating on two or more functions in class sometime?

[yt2new,t3new]=flipshift(yt2,t3,0.5,2);
figure(6);
hold on;
plot(t,yt);
plot(t3new,yt2new,'r');
legend('y(t)','y(0.5(t+2))');
%Values in the range of -8 to 8 should take care of the range of functions
%required
figure(7);
compositefunction=zeros(1,length(t2new(t2new>=-8 & t2new <=8)));
compositefunction=xt2new(t2new>=-8 & t2new <=8).*yt2new(t3new>=-8 & t3new<=8);
subplot(3,1,1);
plot(t2new(t2new>=-8 & t2new <=8),xt2new(t2new>=-8 & t2new <=8),'g');
title('x(2t)');
subplot(3,1,2);
plot(t3new(t3new>=-8 & t3new<=8),yt2new(t3new>=-8 & t3new<=8),'r');
title('y(0.5(t+2))');
subplot(3,1,3);
plot(t2new(t2new>=-8 & t2new <=8),compositefunction);
title('x(2t)*y(0.5(t+2))');
%% Problem 2:

%Using flipshit function defined previously to plot y(0.5(t+2)) and y(t) on
%the same plot
figure(8);
hold on;
plot(t,yt);
[ytflipshift,tflipshift]=flipshift(yt,t,0.5,2);
plot(tflipshift(tflipshift>=-10 & tflipshift<=10),ytflipshift(tflipshift>=-10 & tflipshift<=10),'r'); 

%% Problem 3:

figure(9);
hold on;
plot(t(1:end-1),yt(1:end-1));
%Taking derivative using diff
dydt=(diff(yt)./dt);
plot(t(1:end-1),dydt,'r');
legend('y(t)','dy(t)/dt');
%Taking integral using cumtrapz
figure(10);
integral=cumtrapz(yt).*dt;
hold on;
plot(t,integral,'g');
plot(t,yt);
legend('Cumulative integral','y(t)');

%% Problem 4:

%Using the same logic as in the user defined flip and shift function we
%know that following we have a plot of y(t') vs t'.
%This is equivalent a plot of y(t/2 +1) vs t/2 +1
%We want a plot of y(t/2 +1) vs t.
%So to get the new vector t we can tranform the original time vector.
%Therefore t'=t/2+1

%(a) If we shift and then scale we have the following two operations:
%Shift: t'-1=t/2
%So by plotting y(t') vs t'-1 we should get a plot of y(t/2+1) vs t/2
figure(10);
subplot(3,1,1);
plot(t,yt);
title('Original');
subplot(3,1,2);
plot(t-1,yt,'r');
title('Shift first');
%Scale: 2(t'-1)=t
%So by now plotting y(t') vs 2(t'-1) we should get a plot of y(t/2 +1) vs t
subplot(3,1,3);
plot(2.*(t-1),yt,'g');
title('Scale second');

%(b) If we scale and then shift we have the following two opertions:
%Scale: 2t'=t+2
%So by plotting y(t') vs 2t' we should get a plot of y(t/2 +1) vs t+2
figure(11);
subplot(3,1,1);
plot(t,yt);
title('Original');
subplot(3,1,2);
plot(2.*t,yt,'r');
title('Scale first');
%Shift 2t'-2=t
%So by plotting y(t') vs 2t'-2 we should get a plot of y(t/2+1) vs t
subplot(3,1,3);
plot((2.*t)-2,yt,'g');
title('Shift second');
%As you can the bottom most subplots of both this figure and the one before
%it are identical. This shows that math works!

