function ddt = wcdiffs_cell(inpt, clms, wghts, mval)

if nargin < 4, mval = -9999; end
if nargin < 3, wghts = 1; end
if nargin < 2, clms = [3 4 8]; end

mnths = cell2mat(:, clms(1)));
yrs   = cell2mat(:, clms(2)));
dom = eomday(yrs, mnths);

fields = inpt(:, clms(3));

ddt(:, 1) = inpt(:, clms(1));
ddt(:, 2) = inpt(:, clms(2));

for i = 1:length(dom)
    if i == 1
        ddt{1,3} = (dom(2)*fields{2} - dom(1)*fields{1})/((dom(2) + dom(1))*(dom(2)/2 + dom(1)/2));
    elseif i == length(dom)
        ddt{i,3} = (dom(i)*fields{i} - dom(i-1)*fields{i-1})/((dom(i) + dom(i-1))*(dom(i)/2 + dom(i-1)/2));
    else
        ddt{i,3} = (dom(i+1)*fields{i+1} - dom(i-1)*fields{i-1})/((dom(i+1)+dom(i-1))*(dom(i+1)/2+dom(i)+dom(i-1)/2));
    end
    
    ddt{i,3}(fields{i} == mval) = mval;
end


        



