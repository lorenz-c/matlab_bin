function otpt = sub_mac(inpt);

mac = tsmean(inpt, 'monthly');


otpt = inpt;

for i = 1:12
    mind = find(inpt(:, 1) == i);
    
    for j = 1:length(mind)
        otpt(mind(j), 4:end) = inpt(mind(j), 4:end) - mac(i+1, 2:end);
    end
end