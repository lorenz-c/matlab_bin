function usgs = read_usgs(fname)

d = importdata(fname, '\t', 37);
data = d.data;

mnths  = data(:, 5);
yrs    = data(:, 4);
numdte = datenum(yrs, mnths, 15);

usgs = [0 0 0 data(1,1); mnths, yrs, numdte, data(:, 6)];


