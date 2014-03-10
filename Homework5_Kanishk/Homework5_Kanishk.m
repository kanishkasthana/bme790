%% BME 790.01F13 Engineering Programming and Signal Processing
%% Homework 5 Kanishk Asthana ka112@duke.edu
%% Part 3 
%% (b)

close all;
clear;
b= [ 0 0 0 0.04]
a=[1 15 50 0]
[r,p,k]=residue(b,a)
r
p
k

% Defining time vector for plotting result
dt=0.01;
t=0:dt:2;
cpt= 0.008-0.0016*exp(-5*t)+0.008*exp(-10*t);
plot(t,cpt);
title('Concentration of Protein over time');
xlabel('time');
ylabel('concentration');

%% (c)

hold on;
%New concentration term

cpt2=0.008-0.0016*exp(-5*t)+0.108*exp(-10*t);
plot(t,cpt2,'r');

%% (d) 

%Using residue again
b=[0 0 0.05];
a=[1 15 50];
[r,p,k]=residue(b,a);
r
p
k
hold on;
cpt3=0.008+0.0084*exp(-5*t)-0.0092*exp(-10*t);
plot(t,cpt3,'g');

%% (e)

%Fourth condition
cpt4=0.008+0.0084*exp(-5*t)+0.0008*exp(-10*t);
hold on;
plot(t,cpt4,'k');
legend('CR(0)=0,CP(0)=0','CR(0)=0,CP(0)=0.1','CR(0)=0.5,CP(0)=0','CR(0)=0.5,CP(0)=0.01');


%% Part 4

%Taking value of RC to be 1

t=-5:dt:10;
%Finding vector for first part of expression
y1t=zeros(1,length(t));
y1t(t>=0)=exp(-1*t(t>=0));

%Finding vector for second part of expression
%Initializing
y2t=zeros(1,length(t));

y2t(t>=2)=exp(-1*t(t>=2)+2);

%Subtracting and plotting the two parts:

figure;
yt=y1t-y2t;

plot(t,yt);
title('Output for input of u(t)-u(t-2) and RC=1');
xlabel('time');
ylabel('Output y(t)');


