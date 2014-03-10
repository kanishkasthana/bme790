%% BME 790.01 F13 Engineering Programming and Signal Processing
%% Worksheet 5 Kanishk Asthana ka112@duke.edu
%% Task 2 Initializing y(t) and t
dt=0.01;
t=0:dt:7;
y=zeros(1,length(t));
%% Task 3 Plotting calculated values of y(t)
y(t>=1 & t<=2)=1-1.*exp(-1.*t(t>=1 & t<=2)+1);
y(t>=2 & t<=3)=exp(-1.*t(t>=2 & t<=3)+2).*(t(t>=2 & t<=3)-1)-1.*exp(-1.*t(t>=2 & t<=3)+1);
y(t>=3 & t<=4)=2.*exp(-1.*t(t>=3 & t<=4)+2)-1.*exp(-1.*t(t>=3 & t<=4)+1);
y(t>=4 & t<=5)=2.*exp(-1.*t(t>=4 & t<=5)+2)-exp(-3.*ones(1,length(t(t>=4 & t<=5))));
y(t>=5 & t<=6)=exp(-1.*t(t>=5 & t<=6)+2).*(-1.*t(t>=5 & t<=6)+6);
plot(t,y);
ylabel('y(t)');
xlabel('t');
title('Hardcoded result');
%Modifying acnv
%Results are the same look at figures
