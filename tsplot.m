function [f, varargout] = tsplot(nrplots, tscale, datatype, indxs, varargin)


if strcmp(datatype, 'full')
    sind = 2;
    if tscale == [1 12]
        tmeinfo = 1;
    else
        tmeinfo = 3;
    end
	if length(indxs) == 1
        for i = 1:length(varargin)
            ccol(i) = find(varargin{i}(1,:) == indxs);
        end
    else
        for i = 1:length(varargin)
            for j = 1:length(indxs)
                ccol(i,j) = find(varargin{i}(1,:) == indxs(j));
            end
        end
    end   
elseif strcmp(datatype, 'normal')
    sind = 1;
    tmeinfo = 1;
    ccol = ones(length(varargin),1)*2;
    tlte = [ ];
end

if tscale == [1 12]
    mnths = mnthnms('vshort');
end

clr = [60   60  60;
       31  120 180;
       51  160  44;
       227  26  28;
       255 127   0;
       106 061 154;
       166 206 227;
       178 223 138;
       251 154 153;
       253 191 111;
       202 178 214]/255;
% 
% clr = [ 60   60    60;
%         050  136  189;
%         244  109   67;
%         026  152  080;
%         240  130   40;
%           0  200  200;
%         230  220   50;
%         160    0  200;
%         160  230   50;
%           0  160  255;
%         240    0  130;
%         230  175   45;
%           0  210  140;
%         130    0  220]/255; 
          
        
scrsz = get(0,'ScreenSize');
f = figure('OuterPosition',[1 scrsz(4)/2 scrsz(3)/3 scrsz(4)/2]);

if nrplots == 1
    h = subplot(1,1,1);
    for i = 1:length(varargin)
        
        plot(varargin{i}(sind:end, tmeinfo), varargin{i}(sind:end, ccol(i)), 'Color', clr(i,:), 'Linewidth', 1.5);
        hold on
    end
    datetick('x')
    if tscale ~= [1 12]
        set(gca, 'xlim',  [datenum(tscale(1), 1, 15) datenum(tscale(2), 12, 15)]);
    else
        set(gca, 'xlim',  [1 12]);
        set(gca, 'xticklabel', mnths);
    end
        
    
    
else
    
    for i = 1:nrplots(1)*nrplots(2)
        h(i) = subplot(nrplots(1), nrplots(2), i);
        for j = 1:length(varargin)
            plot(varargin{j}(sind:end, tmeinfo), varargin{j}(sind:end, ccol(j, i)), 'Color', clr(j,:), 'Linewidth', 1);
            hold on
        end
        datetick('x');
        if tscale ~= [1 12]
            set(gca, 'xlim',  [datenum(tscale(1), 1, 15) datenum(tscale(2), 12, 15)]);
            pbaspect([2 1 1])
        else
            set(gca, 'xlim',  [1 12]);
            set(gca, 'xticklabel', mnths);
        end
    end
    
end

varargout{1} = h;
