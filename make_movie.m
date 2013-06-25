function F = make_movie(data, tles, out_name, lims, lam, th, cxis, aspct)



load coast
load cmap_grace.mat

aviobj = avifile(out_name, 'compression', 'none', 'fps', 3, 'quality', 100, 'colormap', cmap_grace);

% 'units', 'normalized', 
hf=figure('visible', 'on');
set(hf, 'units', 'pixels');
% rect = get(hf,'Position')
% % keyboard
% rect(1:2) = [0 0];
hax = axes;

set(hf, 'DoubleBuffer', 'on');
h = imagesc(lam, th, data{1}, 'Parent', hax, 'EraseMode', 'xor');
hold on
plot(long, lat, 'k', 'linewidth', 2, 'Parent', hax);

grid on
caxis(cxis);
axis(lims);
pbaspect(aspct);
axis xy
colormap(cmap_grace)
g = colorbar('eastoutside');
set(get(g, 'ylabel'), 'String', '[mm/month]', 'fontsize', 20);
set(hax, 'xtick', -180:30:180, 'fontsize', 20);
set(hax, 'ytick', -90:30:90);

title(tles{1}, 'fontsize', 25);
pause

rect = get(hf,'Position')
rect(1:2) = [0 0];

F = getframe(hf, rect);
aviobj = addframe(aviobj, F);


for i = 2:length(data)
    set(h, 'CData', data{i}, 'Parent', hax);
    title(tles{i}, 'fontsize', 15);
    
    F = getframe(hf,rect);
    aviobj = addframe(aviobj, F);

end

close(hf); 
aviobj = close(aviobj);

    
    
    
    

