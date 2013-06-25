function [] = ploticas(spatmaps, tseries, maxmde, tscale, axlims, theta, lambda)

if nargin < 7, lambda = -179.75:0.5:179.75; end
if nargin < 6, theta  = 89.75:-0.5:-89.75; end
if nargin < 5, axlims = [-180 180 -90 90]; end
if nargin < 4, tscale = 'monthly'; end
if nargin < 3, maxmde = length(spatmaps); end


if strcmp(tscale, 'monthly')
    syr = input('Start year: \n')
    smn = input('Start month: \n')

    for i = 1:length(tseries)
        dte(i) = datenum(syr, smn, 15);
        smn = smn + 1;
        if smn == 13
            smn = 1;
            syr = syr + 1;
        end
    end
elseif strcmp(tscale, 'annual')
    syr = input('Start year: \n')
    dte = syr:1:syr + length(tseries)-1;
end



load coast
figure

for i = 1:maxmde
    subplot(2, maxmde, i);
    imagesc(lambda, theta, spatmaps{i});
    axis xy
    hold on
    plot(long, lat, 'k', 'linewidth', 1.5);
    axis(axlims);
    pbaspect([length(axlims(1):axlims(2)), length(axlims(3):axlims(4)), 1])
    modenr = ['IC Mode ', num2str(i)];
    title(modenr)
end




for i = 1:maxmde    
    subplot(2, maxmde, maxmde + i);
    plot(dte, tseries(:, i));  
    if strcmp(tscale, 'monthly')
        datetick('x', 'yyyy');
    end
    axis([dte(1), dte(end), min(tseries(:,i)), max(tseries(:,i))]);
 end


    
