%% BME 790.01F13 Engineering Programming and Signal Processing
%% Homework 4 Kanishk Asthana ka112@duke.edu
%% Part 4
%% (a)
clear;
close all;
clf;
%Loading Image;
load('Austin.mat');
figure(1);
subplot(2,2,1);
%Plotting Image in First Row
imshow(IM);
title('Original Image');
subplot(2,2,3);
%Taking 2D fft of image
imfft=fft2(IM);
%Taking absolute value of fft of image so it can be visualized
imampfft=abs(imfft);
%Normalizing Maginitudes
imampfft=imampfft./max(imampfft(:));
%fft shifting magnitudes for better visualization
imampfft=fftshift(imampfft);
%Scaling up image so More frequency information is visible
imshow(imampfft*10000);
title('Normalized Scaled Frequency magnitudes');
%% (b)
%Looking at the plot above, the majority of frequency information
%seems to be low frequency information.

%% (c)
%Making 2D low pass filter

%Initializing 2D lowpass filter
lowpass=zeros(size(IM,1),size(IM,2));

%Finding coordinates of pixels in the center of the image
centerpixels=[size(IM,1)/2 size(IM,2)/2]

lowpass(centerpixels(1)-50:centerpixels(1)+50,centerpixels(2)-50:centerpixels(2)+50)=ones(101,101);

%Visualizing low pass filter to see if it was created properly
figure(2);
imshow(lowpass);
title('Checking low pass filter');

%Multiplying lowpass filter with fft of image.
lowpassedfreq=fftshift(imfft).*lowpass;
lowpassedfreq=fftshift(lowpassedfreq);

newImage=uint8(ifft2(lowpassedfreq));
figure(1);
subplot(2,2,2);
imshow(newImage);
title('Low pass filtered');

%% (d)

%This is a highpass filter
highpass=ones(size(IM,1),size(IM,2))-lowpass;
%Visualizing high pass filter to see if it was created properly
figure(3);
imshow(highpass);
title('Checking High pass filter');

%Multiplying highpass filter with fft of image.
highpassedfreq=fftshift(imfft).*highpass;
highpassedfreq=fftshift(highpassedfreq);

newImage2=uint8(ifft2(highpassedfreq));
figure(1);
subplot(2,2,4);
imshow(newImage2);
title('High pass filtered');

%% (e)

%Taking inverse fourier transform of magnitude of image only

newImage3=uint8(ifft2(abs(imfft)));
figure(4);
imshow(newImage3);
title('Image reconstructed only using magnitude');
%This image show that the magnitude is not as important as the phase of the
%image.

%% (f)

%fftshifting the fft of the image
fftshiftedimage=fftshift(imfft);
%Setting one pixel to an artificially high value.
fftshiftedimage(2000,1000)=1000000000000000000;
%Reconstructing image after artificially increasing value of one pixel.
newImage4=uint8(ifft2(fftshift(fftshiftedimage)));
figure(5);
imshow(newImage4);
%Outputing image sample to see what happened to pixel values.
newImage4(1:10,1:10)

%Nothing happens when lower values are used but for higher values the pixel
%values also become complex. They now become either 255 or 255i.
%Because of this the image can no longer be displayed properly and only
%horizontal lines are seen across the screen which represent the real
%components of the image


