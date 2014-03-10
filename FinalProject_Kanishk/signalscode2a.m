%% BME 790.01 Engineering Programming and Signal Processing
%% MATLAB Project Kanishk Asthana and Terrance White kanishk.asthana@duke.edu, terrance.white@duke.edu

%% Original Image 

close all;
clear all;

%Image source: http://www.olympusamerica.com/seg_section/fv10i/images/FV10idata.png
%Reading image of cells:
IM=imread('image3.png');
%Displaying Orignal Image
imshow(IM);
title('Original');

%% Trying to find Cell Nuclei in original Image

[cent5,rd5]=imfindcircles(IM,[10 30]);
viscircles(cent5,rd5,'EdgeColor','r');

%% Splitting Image into RGB components
%(exchanging Blue and Blue for this image)
B=IM(:,:,1);
G=IM(:,:,2);
R=IM(:,:,3);

%Cells are labeled Blue
%Showing only the Blue components of the image
figure(2);
imshow(R);
title('Blue Channel of Image');

%Thresholding image to exclude background
bR=R>100;
%Setting all pixels to maximum value on scale of 0-255
bR=bR.*255;

%Showing thresholded image
figure(3);
imshow(bR);
title('Thresholded Image');

imfft=fft2(bR);
%Taking absolute value of fft of image so it can be visualized
imampfft=abs(imfft);
%Normalizing Maginitudes
imampfft=imampfft./max(imampfft(:));
%fft shifting magnitudes for better visualization
imampfft=fftshift(imampfft);
%Scaling up image so More frequency information is visible
figure;
imshow(imampfft*10000);
title('Normalized Scaled Frequency magnitudes');

%% Low pass filtering Thresholded Image

%Making 2D low pass filter

%Initializing 2D lowpass filter
lowpass=zeros(size(bR,1),size(bR,2));

%Finding coordinates of pixels in the center of the image
centerpixels=[size(bR,1)/2 size(bR,2)/2]

lowpass(centerpixels(1)-50:centerpixels(1)+50,centerpixels(2)-50:centerpixels(2)+50)=ones(101,101);

%Visualizing low pass filter to see if it was created properly
figure;
imshow(lowpass);
title('Checking low pass filter');

%Multiplying lowpass filter with fft of image.
lowpassedfreq=fftshift(imfft).*lowpass;
lowpassedfreq=fftshift(lowpassedfreq);

newImage=uint8(ifft2(lowpassedfreq));
figure(6);
imshow(newImage);
title('Low pass filteBlue Image');


%% Trying to find Nuclei for Thresholded Image

%Trying to find nuclei for Threshoded Image
[cent1,rd1]=imfindcircles(bR,[10 30]);
%Trying to find nuclei for Thresholded and Low passed filteBlue image
[cent2,rd2]=imfindcircles(real(newImage),[10 30]);

%Number of Nuclei Found
%size(cent1)
%size(cent2)
figure(3);
viscircles(cent1,rd1,'EdgeColor','r');
title('Finding nuclei in Thresholded Image');
figure(6);
viscircles(cent2,rd2,'EdgeColor','r');
title('Finding nuclei in Low Pass filteBlue Image');
[cent3,rd3]=imfindcircles(R,[10 30]);
figure(2);
viscircles(cent3,rd3,'EdgeColor','r');
title('Finding nuclei in Blue only channel of Image');
%% Testing Ability to Find Nuclei in High Pass filteBlue Image

%This is a highpass filter
highpass=ones(size(bR,1),size(bR,2))-lowpass;
%Visualizing high pass filter to see if it was created properly
figure;
imshow(highpass);
title('Checking High pass filter');

%Multiplying highpass filter with fft of image.
highpassedfreq=fftshift(imfft).*highpass;
highpassedfreq=fftshift(highpassedfreq);

newImage2=uint8(ifft2(highpassedfreq));
figure;
imshow(newImage2);
title('High pass filteBlue');
[cent4,rd4]=imfindcircles(real(newImage2),[10 30]);
viscircles(cent4,rd4,'EdgeColor','r');
title('Nuclei found In High Pass filteBlue Image');


%% Calcuating Intensities Across Identified Nuclei

%Defining vector to store average fluorescence intensity across cell
%nuclei
AverageIntensities=zeros(1,length(cent2));

for vari=1:length(cent2)
%Defining vector x and y to account  for all rows and columns;
x=1:size(R,2);
y=1:size(R,1);
%Defining 2D grid of same size as image
[xg,yg]=meshgrid(x,y);
% X value of center of circle;
xcenter=cent2(vari,1);
% Y value of center of circle;
ycenter=cent2(vari,2);
%radius of circle;
radius=rd2(vari);
% Extracting logical matrix which contains given circle;
logicalcircle=sqrt((xg-xcenter).^2+(yg-ycenter).^2)<=radius;

% Testing if circles extracted are correct
%figure;
%imshow(logicalcircle);

%Extracting pixel intensities for R components of image which corresponds
%to the logical circle
pixelintensities=R(logicalcircle);

%Taking mean across pixels and storing values in vector
AverageIntensities(vari)=mean(pixelintensities);
end

%Plotting histogram of intensity values;
figure;
hist(AverageIntensities);
title('Histogram Plot of Intensity Values');
ylabel('Number of Cells');
xlabel('Average Intensity on a Scale of 0-255');
