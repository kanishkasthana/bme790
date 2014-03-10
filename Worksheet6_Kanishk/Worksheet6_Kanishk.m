%% BME 790.01F13 Engineering Programming and Signal Processing
%% Worksheet 6 Kanishk Asthana ka112@duke.edu

clear;
clf;
%Defining time step for input signal
dt=0.001;
%Defining fundamental time period as 10pi
T=10*pi;
%Input signal goes from -T/2 to T/2;
t=-1*T/2:dt:T/2;
input=zeros(1,length(t));
input(t>=-1*T/8 & t<=3*T/8)=ones(1,length(find(t>=-1*T/8 & t<=3*T/8)));
order=20;
%You can use an indexing array K to get X(K) awesome.
[index,x,a,b,wo,Series]=FourierS(input,order,T);
subplot(3,1,1);
stem(index,abs(x));
xlabel('K');
ylabel('|X[K]|');
title('Magnitude Stem Plot');
subplot(3,1,2);
stem(index,angle(x));
xlabel('K');
ylabel('Phase');
title('Phase Stem Plot');
subplot(3,1,3);
plot(t,Series);
xlabel('t');
ylabel('Series');
title('Series of Order 20');

%%
%This matches the solution we found in class. The magnitude and phase for
%the central terms is close to that found in class. The small difference may
%be because of the discrete nature of MATLAB. Decreasing dt indeed makes
%the solutions closer to that calculated analytically.
