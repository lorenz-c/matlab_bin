function [f, g] = plotglbl(inpt_map, theta, lambda)

if nargin < 3, lambda = -179.75:0.5:179.75; end
if nargin < 2, theta  = 89.75:-0.5:-89.75; end


load coast

scrsz = get(0,'ScreenSize');
f = figure('OuterPosition',[1 scrsz(4)/2 scrsz(3)/3 scrsz(4)/2])

imagesc(lambda, theta, inpt_map)
hold on
plot(long, lat, 'k', 'linewidth', 1.5)
pbaspect([2 1 1])
axis xy
g = colorbar('eastoutside', 'fontsize', 14);

% 
% colormap([160    0  200;
%         130    0  220;
%          30   60  255;
%           0  160  255;
%           0  200  200;
%           0 210 140  ;
%           0 220   0  ;
%           160 230  50;
%           230 220  50 ;
%           230 175  45  ;
%           240 130  40;
%           250  60  60;
%           240   0 130]/255);  

