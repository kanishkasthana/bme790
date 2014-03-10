%% BME790.01F13:Worksheet 4 Kanishk Asthana ka112@duke.edu
function [x,tnew] = flipshift(x,t,scale,shift)
%flipshift: A function to arbitarily flip and shift a mathematical function
%x(t)
% Suppose we already have a function of time x(t) as  a vector and the
% original time vector t; and we need a shifted and scaled function 
% x(scale(t-shift)) (where flip and scale have been combined into a single
% scale). Then, we can find the shifted and scaled function by assuming the
% following: t'=scale(t-shift). we already know the plot x(t') vs t' (which
% is same as the orginal function plotted against t. since we have assumed
% t'=scale(t-shift), we can say we already have a plot of x(scale(t-shift))
% vs scale(t-shift). However we need a plot of x(scale(t-shift)) vs t.
%We can find the value of this plot by computing the value of the new t
%array using the original t array. Since t'=scale(t-shift);
%t'/scale=t-shift. or 
%t=t'/scale -shift.
%Wring t as tnew and t' as the original t we get the following calculation:
tnew=(t./scale)-shift;


end

