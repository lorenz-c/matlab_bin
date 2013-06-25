function [] = plotglblts(inpt_map,  cxs, unit, ttle)

if nargin < 4
    ttle = ' ';
end

if nargin < 3
    unit = '[mm/month]';
end

theta  = 89.75:-0.5:-89.75;
lambda = -179.75:0.5:179.75;

load coast

scrsz = get(0,'ScreenSize');
figure('OuterPosition',[1 scrsz(4)/2 scrsz(3)/3 scrsz(4)/2])

for i = 1:length(inpt_map)
    imagesc(lambda, theta, inpt_map{i})
    hold on
    plot(long, lat, 'k', 'linewidth', 1.5)
    pbaspect([2 1 1])
    axis xy
    caxis([cxs(1) cxs(2)])
    g = colorbar('eastoutside', 'fontsize', 14);
    hold off
    F(i) = getframe;
end