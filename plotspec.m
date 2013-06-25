function [] = plotspec(type, f, ax, varargin)


if isempty(type)
    type = 'Amp';
end

clr = [   0    0    0;
         30   60  255;
        250   60   60;
          0  220    0;
        240  130   40;
          0  200  200;
        230  220   50;
        160    0  200;
        160  230   50;
          0  160  255;
        240    0  130;
        230  175   45;
          0  210  140;
        130    0  220]/255; 
    
    
figure

for i = 1:length(varargin)

    spectrm = varargin{i};   
    if strcmp(ax, 'lin')
        plot(f, spectrm, 'Color', clr(i,:), 'linewidth', 1)
    elseif strcmp(ax, 'log')
        semilogy(f, spectrm, 'Color', clr(i,:), 'linewidth', 1)
    end
    hold on
end

xlabel('Frequency', 'fontsize', 12);

if strcmp(type, 'Amp')
    ylabel('|Y(f)|', 'Fontsize', 12);
    title('Single-sided amplitude spectrum', 'fontsize', 12);
elseif strcmp(type, 'PSD')
    ylabel('Power/Frequency', 'fontsize', 12);
    title('Power spectral density', 'fontsize', 12);
end
    
   