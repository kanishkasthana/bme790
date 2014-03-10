%% BME 790.01 Engineering Programming Signal Processing
%% Kanishk Asthana ka112@duke.edu Homework 2
%% Part 4:
%Doing 2.40(a) as a convolution
clear;
clf;
%Defining time step:
dt=0.01;
%Defining first time vector:
t1=-1:dt:1;
%Defining second time vector:
t2=0:dt:4;
%Defining time vector for convolved function:
t3=(t1(1)+ t2(1)):dt:(t1(end)+t2(end));

%Defining first function x(t)
xt=ones(1,length(t1));

%Initializing second fucntion y(t)
yt=ones(1,length(t2));
 
yt(t2>2)= 2.*ones(1,length(find(t2>2))); 
plot(t1,xt,'*');
hold on;
plot(t2,yt,'g');
title('Fucntions to be convolved');
legend('x(t)','y(t)');
xlabel('t');
figure(2);
mt=conv(yt,xt);
%Answer (a)
%Convolution gives the result multiplied by a factor equal to inverse of
%dt.
%This is because you have more addition of the same part of the curve
%as dt increases (as part of the convolution algorithm there are more data
%points so the convolution sum also increases as the number of data points
%increases. So a curve is actually streched out or shrunk if dt is
%changed. Multiplying the convolution result by dt fixes this problem and
%compensates for changes in dt. Math works.
plot(t3,mt,'*g');

%Initializing manually computed result:
actualresult=zeros(1,length(t3));

actualresult(t3<3)=t3(t3<3)+1;
actualresult(t3>=3)=10-2.*t3(t3>=3);
hold on;
plot(t3,actualresult,'b');
legend('Matlab result','Result manually computed');
xlabel('t');
title('Comparison of MATLAB result with manually computed result');

figure(3);
%Answer (b)
%Adjusting for dt (Explanation below).
mt=conv(yt,xt).*dt;
plot(t3,mt,'*g');
hold on;
plot(t3,actualresult,'b');
legend('Matlab adjusted result','Result manually computed');
xlabel('t');
title('Comparison of adjusted MATLAB result with manually computed result');
%Result is correct! Math works

%% Part 5
%(a)
%Initializing image
n=1:128;
in=zeros(1,128);
%Setting pixels 40 to 82 as 1
in(40:82)=1;
%Plotting Image;
figure(4);
plot(n,in);
title('Plot of Image');
xlabel('n');
%(b)
%Defining h[n] as x[n] as mentioned in Problem 2.34(a).
%Initializing h[n];
h1n=ones(1,7);
%h[n] is not memoryless. Only a delta function has no memory.
%h[n] is not causal because response will start y[n] will have a response
%even when I[n] for that n has no values.
%Since my h[n] is composed mainly of ones I hypothize that it will sum the
%values over a range of 7 pixels, essentially sharp transitions should be
%mellowed down. I hypothesize this will act as a low pass filter.
%(c)
newImage=conv(in,h1n);
figure(5);
plot(newImage);
title('New Image');

%I[n] was increased in amplitude and the edges were now slanting. However,
%it did not act as a low pass filter as I predicted it as there are still
%high sharp transitions in the image. Apparrently my filter width was too
%low to have any effect. Increasing the filter size decreases the width of
%the image at the top but high frequency componenets don't disappear. I
%most probably needed a filter with weighted sums to acheive a better
%smooting. A triangular filter convolved with our rect should give that
%effect.
%(d)
%Choosing w[n] from problem as a second filter. I hypothesize this will act
%as an edge enhancer, while reducing sharp transitions. So a bandpass
%filter 
%This function is not causal and is not memoryless.
h2n=[-1 0 1 2 3 2 1 -1 0];
%(e)
newImage2=conv(in,h2n);
figure(6);
plot(newImage2);
title('New Image 2');
%This is indeed bandpass filter.

%% (f)
load('Head.mat');
%(g)
figure(7);
colormap('bone');
subplot(3,2,1);
imagesc(Head);
colorbar;
title('Original');
%(h)
newHead=conv2(Head,h1n);
colormap('bone');
subplot(3,2,2);
imagesc(newHead);
colorbar;
title('Convolved with h1[n]');
%The image is blurred in the horizontal direction which is as expected
%(i)
%Convolving brain image with h2[n]

newHead2=conv2(Head,h2n);
colormap('bone');
subplot(3,2,3);
imagesc(newHead2);
colorbar;
title('Convolved with h2[n]');
%I should blurring with slight increase in contrast between black and white
%parts
%This seems to work.
%(j)
%The filters I have created only affect the x direction because the seems
%operate in one pixel row at a time. So I should see blurring of the entire
%image in both directions if I use a square rect.

%(k)
newHead3=conv2(Head,h1n');
colormap('bone');
subplot(3,2,4);
imagesc(newHead3);
colorbar;
title('Convolved with transpose of h1[n]');
%The image is blurred in the vertical direction this time.

%(l)
newHead4=conv2(Head,h2n');
subplot(3,2,5);
colormap('bone');
imagesc(newHead4);
colorbar;
title('Convolved with transpose of h2[n]');

%The image is blurred in the vertical direction with greater contrast
%between dark and white parts.

%(m)
%Creating square h1[n]
h1nsquare=ones(7);
figure(8);
%Mesh plot
mesh(h1nsquare);
title('Square h1[n]');
figure(7);
newHead5=conv2(Head,h1nsquare);
subplot(3,2,6);
colormap('bone');
imagesc(newHead5);
colorbar;
title('Convolved with square h1[n]');
%This should give me equal blurring in both x and y directions and the
%result is as expected.
%(n)
%Sampling my first fucntion h1[n] at a higher rate will result in a wider
%rect fucntion convolving with a larger rect fucntion results in even
%greater blurring than before. So increase sampling results in a biger
%kernel and hence greater number of elements are considered accross the
%image for the convolution sum this results in greater blurring in our
%case.
figure(9);
subplot(3,1,1);
colormap('bone');
imagesc(Head);
colorbar;
title('Original');
subplot(3,1,2);
colormap('bone');
imagesc(newHead);
colorbar;
title('Convolved with default h1[n]');
subplot(3,1,3);
h1nnew=ones(1,14);%Double size array represents double sampling rate
colormap('bone');
newHead6=conv2(Head,h1nnew);
imagesc(newHead6);
colorbar;
title('Double sampling leads to more blurring');








