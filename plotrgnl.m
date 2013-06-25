function varargout = plotrgnl(nrplots, lims, dx, dy, pltrvrs, pltussts, area_mask, cxis, varargin)

if isempty(dx)
    lambda = -179.75:0.5:179.75;
else
    lambda = -180+dx/2:dx:180-dx/2;
end

if isempty(dy)
    theta  = 89.75:-0.5:-89.75;
else
    theta  = 90-dy/2:-dy:-90+dy/2;
end


if size(lims) == [1, 1]
%     load indexfile3.asc
%     mask = zeros(360, 720);
    mask = zeros(size(area_mask));
    mask(area_mask == lims) = 1;    
    [r, c] = find(mask == 1);
    mask(mask == 0) = NaN;
    
    lims = [min(lambda(c))-2 max(lambda(c))+2 ...
            min(theta(r))-2 max(theta(r))+2];
else
    for i = 1:length(varargin)
        mask{i} = ones(size(varargin{i}));
    end
end

if pltrvrs == 1
    S = shaperead('worldrivers.shp');
end

if pltussts == 1
    US = shaperead('/media/storage/Data/Masks/USA_States/states.shp');
end


load coast

scrsz = get(0, 'ScreenSize');
% f = figure('OuterPosition',[1 scrsz(4)/2 scrsz(3)/3 scrsz(4)/2]);
f = figure('OuterPosition',[1 -scrsz(4)/3 scrsz(3)/2 scrsz(4)/2]);
if length(varargin) > 1
    for i = 1:length(varargin)
        h(i) = subplot(nrplots(1), nrplots(2), i)
            imagesc(lambda, theta, varargin{i}.*mask{i})
             hold on
            plot(long, lat, 'k', 'linewidth', 0.2)
            if pltrvrs == 1
                for j = 1:128
                    plot(S(j).X, S(j).Y, 'b', 'linewidth', 0.2)
                end
            end
             if pltrvrs == 1
                for j = 1:128
                    plot(S(j).X, S(j).Y, 'b', 'linewidth', 0.2)
                end
             end
             if pltussts == 1
                for i = 1:49
                    plot(US(i).X, US(i).Y, 'k', 'linewidth', 0.2)
                end
            end
        hold off

        axis xy
        axis([lims(1) lims(2) lims(3) lims(4)])
        pbaspect([abs(lims(1) - lims(2)) abs(lims(3) - lims(4)) 1]);
        caxis([cxis(1) cxis(2)])
        
    %    g(i) = colorbar('eastoutside', 'fontsize', 10);
        
%         xlabel('Longitude', 'fontsize', 12)
%         ylabel('Latitude', 'fontsize', 12)
    end
else
    h = subplot(1,1,1);
    imagesc(lambda, theta, varargin{1})
	hold on
	plot(long, lat, 'k', 'linewidth', 1.5)
	if pltrvrs == 1
        for i = 1:128
            plot(S(i).X, S(i).Y, 'b', 'linewidth', 1.5)
        end
    end
    if pltussts == 1
        for i = 1:49
            plot(US(i).X, US(i).Y, 'k', 'linewidth', 1.5)
        end
    end
% 	hold off

	axis xy
	axis([lims(1) lims(2) lims(3) lims(4)])
	pbaspect([abs(lims(1) - lims(2)) abs(lims(3) - lims(4)) 1]);
    caxis([cxis(1) cxis(2)])
    
	g = colorbar('eastoutside', 'fontsize', 12);
	xlabel('Longitude', 'fontsize', 12)
	ylabel('Latitude', 'fontsize', 12)
end

varargout{1} = f;
varargout{2} = h;
%varargout{3} = g;

    








