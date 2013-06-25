function otpt = mergets(period, clms, datatype, varargin)

if strcmp(datatype, 'full')
    sind = 2;
else
    sind = 1;
end

syr_1   = -inf;
smnth_1 = -inf;
eyr_1   = inf;
emnth_1 = inf;

for i = 1:length(varargin)
    syr_2   = varargin{i}(sind, clms(2));
    smnth_2 = varargin{i}(sind, clms(1));
    eyr_2   = varargin{i}(end, clms(2));
    emnth_2 = varargin{i}(end, clms(1));
    
    if syr_2 > syr_1
        syr_1   = syr_2; 
        smnth_1 = smnth_2;
    elseif syr_2 == syr_1
        if smnth_2 > smnth_1
            smnth_1 = smnth_2;
        end
    end
    
    if eyr_2 < eyr_1
        eyr_1   = eyr_2; 
        emnth_1 = emnth_2;
    elseif eyr_2 == eyr_1
        if emnth_2 < emnth_1
            emnth_1 = emnth_2;
        end
    end
end


for i = 1:length(varargin)
    sindx = find(varargin{i}(:, clms(1)) == smnth_1 & ...
                 varargin{i}(:, clms(2)) == syr_1);
    eindx = find(varargin{i}(:, clms(1)) == emnth_1 & ...
                 varargin{i}(:, clms(2)) == eyr_1);
    if i == 1  
        otpt(:, 1) = varargin{i}(sindx:eindx, clms(1));
        otpt(:, 2) = varargin{i}(sindx:eindx, clms(2));
    end
    
    otpt(:, i+2) = varargin{i}(sindx:eindx, clms(3));
end





    
    
    
    
 
    
    
    
    
    