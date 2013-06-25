function otpt = tsmean(inpt, tscale, varargin)

pp = inputParser;
pp.addRequired('inpt', @(x)ismatrix(x));          % Input dataset (cell)
pp.addRequired('tscale',  @isstr);                % Time-scale (monthly, annual, ...)

pp.addParamValue('datatype', 'full');
pp.addParamValue('period', 0, @isnumeric);        % Period for averaging
pp.addParamValue('clms', [1 2 4], @isnumeric);    % Columns with m/y/dta
pp.addParamValue('miss', -9999, @(x) ...          % Missing value (-9999)
              (isnumeric(x) | strcmp(x, 'NaN')));
pp.addParamValue('method', 'mean')
pp.parse(inpt, tscale, varargin{:})

period   = pp.Results.period;
datatype = pp.Results.datatype;
clms     = pp.Results.clms;
miss     = pp.Results.miss;
method   = pp.Results.method;

clear pp

if strcmp(miss, 'NaN')
    inpt(isnan(inpt)) = -99999;
    miss = -99999;
end

if period ~= 0
    inpt = findtstps_ts(inpt, [period(1) period(2)]);
end

if inpt(1, clms(1)) == 0
    indvec = inpt(1, clms(3):end);
    inpt   = inpt(2:end, :);
end

if strcmp(tscale, 'annual')
    
    yrs = unique(inpt(:, clms(2)));

    for i = 1:length(yrs)
        indx = find(inpt(:,clms(2)) == yrs(i));
        flds = inpt(indx, clms(3):end);
        
        if strcmp(method, 'mean')          
            otpt(i,:) = [yrs(i) nanmean(flds,1)];
        elseif strcmp(method, 'sum')
            otpt(i,:) = [yrs(i) sum(flds,1)];
        elseif strcmp(method, 'wmean')
            nrd  = eomday(inpt(indx, clms(2)), inpt(indx, clms(1)));
            flds = flds.*(nrd*ones(1, size(flds,2)));
            otpt(i,:) = [yrs(i) sum(flds, 1)./sum(nrd)];           
        end
    end

elseif strcmp(tscale, 'ltm')
    flds = inpt(:, clms(3):end);
    if strcmp(method, 'mean')          
            otpt = nanmean(flds,1);
    elseif strcmp(method, 'sum')
            otpt = nansum(flds,1);
%     elseif strcmp(method, 'wmean')
%             nrd  = eomday(inpt(:, clms(2)), inpt(:, clms(1)));
%             flds = flds.*(nrd*ones(1, size(flds,2)));
%             otpt = nansum(flds, 1)./sum(nrd);           
    end




elseif strcmp(tscale, 'monthly')
    for i = 1:12
        indx = find(inpt(:,clms(1)) == i);  
        otpt(i,:) = [i nanmean(inpt(indx, clms(3):end),1)];     
    end   
    
elseif strcmp(tscale, 'seasonal')
    
    for i = 1:4
        if i == 1
            indx_1 = find(inpt(:, clms(1)) == 12);
            indx_2 = find(inpt(:, clms(1)) == 1);
            indx_3 = find(inpt(:, clms(1)) == 2);            
        else
            indx_1 = find(inpt(:, clms(1)) == i*3-3);
            indx_2 = find(inpt(:, clms(1)) == i*3-2);
            indx_3 = find(inpt(:, clms(1)) == i*3-1);
        end
        otpt(i,:) = [i nanmean(inpt([indx_1; indx_2; indx_3], clms(3):end), 1)];
        clear indx*        
    end
    
elseif strcmp(tscale, 'seasonal_mnthly')

    syr = inpt(1, clms(2));
    eyr = inpt(end, clms(2));
    
    dte = dtevec([12 syr-1], [11 eyr]);
    dte = dte(2:3:end, :);
    
    % If inpt does not start in January or does not end in December
    inpt = findtstps_ts(inpt, [12 syr-1 11 eyr]);
    
    bwd = inpt(1:3:end-2, clms(3):end);
    cnt = inpt(2:3:end-1, clms(3):end);
    fwd = inpt(3:3:end,   clms(3):end);
    
    mask_bwd = zeros(size(bwd));
    mask_cnt = zeros(size(bwd));
    mask_fwd = zeros(size(bwd));
    
    mask_bwd(~isnan(bwd)) = 1;
    mask_cnt(~isnan(cnt)) = 1;
    mask_fwd(~isnan(fwd)) = 1;
    
    div = mask_bwd + mask_cnt + mask_fwd;
    
    otpt = (bwd + cnt + fwd)./div;
    otpt = [dte, otpt];
    
 
end

if exist('indvec')
    if ~strcmp(tscale, 'ltm')
        if strcmp(tscale, 'seasonal_mnthly')
            otpt = [0 0 0 indvec; otpt];
        else
            otpt = [0 indvec; otpt];
        end
    else 
        otpt = [indvec; otpt];
    end
end
