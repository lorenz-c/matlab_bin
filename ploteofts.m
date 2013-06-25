function F = ploteofts(pc, eof)


theta  = 89.75:-0.5:-89.75;
lambda = -179.75:0.5:179.75;

load coast

scrsz = get(0,'ScreenSize');
% figure('OuterPosition',[1 scrsz(4)/2 scrsz(3)/3 scrsz(4)/2])
figure('OuterPosition',[1 scrsz(4)/4 scrsz(3)/3 scrsz(4)/4])
% 
% cx_max = max(pc)*max(max(eof))
% cx_min = -min(pc)*min(min(eof))

for i = 1:732
%     inpt_map = pc(i)*eof;
    inpt_map = 1*eof{i};
    imagesc(lambda, theta, inpt_map)
    hold on
    plot(long, lat, 'k', 'linewidth', 2)
    pbaspect([2 1 1])
    axis xy
    caxis([-50 50])
%     axis([-100 -50 -30 20])
    g = colorbar('eastoutside', 'fontsize', 14);
    hold off
    F(i) = getframe;
end
