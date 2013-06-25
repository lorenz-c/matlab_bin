function [] = zonal_contour_plot(inpt, range)

lats = 1:360;
mnth = 1:12;

x_tck{1} = 'J';
x_tck{2} = 'F';
x_tck{3} = 'M';
x_tck{4} = 'A';
x_tck{5} = 'M';
x_tck{6} = 'J';
x_tck{7} = 'J';
x_tck{8} = 'A';
x_tck{9} = 'S';
x_tck{10} = 'O';
x_tck{11} = 'N';
x_tck{12} = 'D';

y_tck{1} = '90S';
y_tck{2} = '60S';
y_tck{3} = '30S';
y_tck{4} = '0';
y_tck{5} = '30N';
y_tck{6} = '60N';
y_tck{7} = '90N';



load /home/lorenz-c/Data/colormaps/precip_zonal.mat
figure

contourf(flipud(inpt), range, 'linestyle', 'none')

axis([1.5 13.5 61 330]);
% axis([1.5 13.5 1 360]);
set(gca, 'xtick', 2:1:13);
set(gca, 'xticklabel', x_tck, 'fontsize', 14);

set(gca, 'ytick', 1:60:360);
set(gca, 'yticklabel', y_tck, 'fontsize', 14);

colormap(precip_zonal)
grid on
pbaspect([12 6 1])
caxis([0 9])