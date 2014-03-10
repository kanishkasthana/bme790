%% BME 790.01F13 Engineering Programming and Signal Processing

%% Homework 3 Kanishk Asthana ka112@duke.edu

%% Part 3

%% (a) & (b)

clear;
clf;
%Downloading and loading 'EKGdata.mat'

%% (c)

%Testing program on Square wave

%Defining time step for input signal
dt=0.001;
%Defining fundamental time period
T=1;

%Input signal goes from -T/2 to T/2;
t=-1*T/2:dt:T/2;

%Defining input signal
input=zeros(1,length(t));
input(t>=-1*T/8 & t<=3*T/8)=ones(1,length(find(t>=-1*T/8 & t<=3*T/8)));
order=20;

%Testing Modified FourierS
[index,x,a,b,wo,Series]=FourierS(input,order,T);


%% (d)
figure(1);
hold on;
plot(t,input,'r');
plot(t,Series,'g');
title(['Comparison of Original Function with Fouries Series of Order ' num2str(order)]);
ylabel('Series/Input');
xlabel('t');
legend('Input','Series','Location','NorthWest');
%Scaling is correct

%% (e)

% The fundamental period for the above square wave is taken a 1 second so
% a value of k would correspond to a frequency of 1*k.

%Plotting the arguments and phase of current input:
figure(2);

%Dividing indexes by Fundamental period to represent frequencies in hertz.
stem(index/T,abs(x),'k');
title('Magnitude as function of Frequency');
xlabel('Frequency(Hz)');
ylabel('|X[K]|');

figure(3);

%%Dividing indexes by Fundamental period to represent frequencies in hertz.
stem(index/T,angle(x),'k');
xlabel('Frequency(Hz)');
ylabel('Phase');
title('Phase as a function of Frequency');

%% (f)

%Making new square wave:

input=zeros(1,length(t));
input(t>=-1*T/4 & t<=T/4)=ones(1,length(find(t>=-1*T/4 & t<=T/4)));
order=20;

%Reevaluating Fourier Series
[index,x,a,b,wo,Series]=FourierS(input,order,T);

%What happens to phase and magnitude coefficients:
%The |x(k)| coefficients remain the same;
%The phase is shifted for most of the x(k)s.
figure(2);
hold on;
stem(index/T,abs(x),'*g');
legend('Original','Left Shift by T/8');

figure(3);
hold on;
stem(index/T,angle(x),'*g');
legend('Original','Left Shift by T/8');

%% (g)

%Loading EKGdata.mat
load('EKGdata.mat');
figure(4);
plot(Time,EKG);
title('EKGdata');
xlabel('Time');

%% (h)

% To get the RR Interval Such that I have one complete heart beat, I need
% to find the index of the two peaks and find the EKGvector between them.
% Since the two peaks are more towards the sides of the EKG I can divide
% the EKGdata into two equal parts in the middle and find the indexes where
% the Maximum value occurs in each part.

%Calculating Maximum value in first half of EKGdata

%Using round of length(EKG)/2 because length(EKG)/2 may not be a whole
%number
firsthalf=EKG(1:round(length(EKG)/2));
secondhalf=EKG(round(length(EKG)/2):end);

firstmax=max(firsthalf)
secondmax=max(secondhalf)
%Finding indexes in the first half of EKG where this index is attained
maxindexs1=find(EKG==firstmax)
maxindexs2=find(EKG==secondmax)

%Using this approach I get multiple indexes where the maximum value is
%obtained for each peak.
%The best way to approximately get one complete heart beat would be to take
%Middle index of the first one to the Middle index of the second one;

%Rounding to get whole number
firstindex=maxindexs1(round(length(maxindexs1)/2))
secondindex=maxindexs2(round(length(maxindexs2)/2))

%Getting new EKG that contains one heartbeat
newEKG=EKG(firstindex:secondindex);

%Getting new time that starts at firstindex with value of 0 and ends at
%secondindex
newTime=Time(firstindex:secondindex)-Time(firstindex);

%Plotting cut EKG

figure(5);
plot(newTime,newEKG);
title('New EKG');
xlabel('Time');
ylabel('EKG Amplitude');

%To speculate on the identity of the species we can calculate the heart
%rate from the time period of this single heart beat, this data can then be
%Heart rates are good indicators of the identity of the specie.

oneheartbeat=newTime(end)
number_of_heart_beats_in_one_second= 1/oneheartbeat
number_of_heart_beats_in_one_minute=60*number_of_heart_beats_in_one_second

%Thats about 174 beats per minute.
%This is most probably the resting heart beat of a monkey smaller in size
%than humans, or a human who is running.

%Generally the higher the heart rate smaller the mammal.
%Humans generally have a resting heart rate of 72 beats per mintue.
%So this is the heart rate of most probably a mackaque monkey.

%% (i)

%Converting column vector to row vector for analysis
newEKG=newEKG';
%Finding fourier series of Order 20;
order=20;
[index,x,a,b,wo,EKGSeries]=FourierS(newEKG,order,newTime(end));

%% (j)

% Plotting estimate and raw signal

figure(6);
plot(newTime,newEKG,'k',newTime,EKGSeries,'g');
legend('Raw Signal','Fourier Estimate');
title('Comparison of Fourier Estimate of order 20 and Raw signal');
xlabel('Time');
ylabel('Amplitude');

%% (k)

%Increasing order to check if fit improves
order2=100;
[index2,x2,a2,b2,wo2,EKGSeries2]=FourierS(newEKG,order2,newTime(end));
figure(7);
plot(newTime,newEKG,'k',newTime,EKGSeries2,'g');
legend('Raw Signal','Fourier Estimate');
title('Comparison of Fourier Estimate of order 100 and Raw signal');
xlabel('Time');
ylabel('Amplitude');

%The fit does become better as the order of the fourier series is increase
%to 100. Whether this signal is good enough or not would depend on the what
%level of detail we require from our signal.

%If we want to compress our signal data and just want the general structure
%of the EKG then a lower resolution is just fine. However, if we need to
%analyse a large number of frequency components of our signal to identify
%unique features then a larger order might be more useful.

%% (l)

%To plot |X(K)| and angle(X(k)) as a function of frequency we need to
%convert ks to frequencies. We know k=1 corresponds to the fundamental frequecy
%all other ks are just multiples.

fundamentalfrequency=1/newTime(end);
frequencies= fundamentalfrequency.*index;
figure(8);
stem(frequencies,abs(x));
title('Magnitude as function of Frequency for EKG series');
xlabel('Frequency(Hz)');
ylabel('|X[K]|');

figure(9);
stem(frequencies,angle(x));
xlabel('Frequency(Hz)');
ylabel('Phase');
title('Phase as a function of Frequency for EKG series');

%% (m)

%The noise is not apparent in the plots above as the highest frequency is just below 60
%, taking higher order for the series might reveal the 60hz noise. Lets check

order=25;
[index,x,a,b,wo,EKGSeries]=FourierS(newEKG,order,newTime(end));

fundamentalfrequency=1/newTime(end);
frequencies= fundamentalfrequency.*index;
figure(10);
stem(frequencies,abs(x));
title('Magnitude as function of Frequency for EKG series: Order 25');
xlabel('Frequency(Hz)');
ylabel('|X[K]|');

figure(11);
stem(frequencies,angle(x));
xlabel('Frequency(Hz)');
ylabel('Phase');
title('Phase as a function of Frequency for EKG series: Order 25');


% This new plot indeed shows that there is noise just after 60hz in the
% Magnitude plot.

%One way that fourier series can be used to reduce the 60hz noise is by
%imagining the signal to be composed of multiple sums of sins and cosines.
% So the 60hz noise can be removed by removing the 60hz component of the
% from x(t).

%x(t)-X[K=21]*Exp(21iw0t)-X[K=-21]*Exp(-21iwot);

%% (n)

%Subtracting the 60hz term from the original signal, this corresponds to a
%K of 21 and of -21:

newEKGwithoutnoise=newEKG-x(index==21).*exp(21*wo*i*newTime')-x(index==-21).*exp(-21*wo*i*newTime');
figure(12);
plot(newTime,newEKGwithoutnoise);
xlabel('Time');
ylabel('Amplitude');
title('Signal Without 60hz noise');
order=25;
[index,x,a,b,wo,EKGnonoiseSeries]=FourierS(newEKGwithoutnoise,order,newTime(end));

%Plotting new Phase and Magnitude plots to Check if the 60hz noise is gone
%or not.
fundamentalfrequency=1/newTime(end);
frequencies= fundamentalfrequency.*index;
figure(13);
stem(frequencies,abs(x));
title('Magnitude as function of Frequency for EKG series: Order 25');
xlabel('Frequency(Hz)');
ylabel('|X[K]|');

figure(14);
stem(frequencies,angle(x));
xlabel('Frequency(Hz)');
ylabel('Phase');
title('Phase as a function of Frequency for EKG series: Order 25');

%Looking at the magnitude plot we can clearly see that the noise around
%60hz is now gone once it was subtracted from te original signal. Awesome
%the noise is gone

