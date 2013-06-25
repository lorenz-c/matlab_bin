function [] = showeofana(eof_s, pcs, theta, lambda, sel_area, mxmde);
load coast
k = 1;
for i = 1:mxmde
    subplot(mxmde, 2, k);
    imagesc(lambda, theta, eof_s{i});
    hold on
    plot(long, lat, 'k', 'linewidth', 1.5)
    axis([sel_area(1), sel_area(2), sel_area(3), sel_area(4)]);
    axis xy
%     caxis([0 1]);
    
    subplot(mxmde, 2, k+1);
    plot(pcs(:,i));
    
    k = k + 2;
end