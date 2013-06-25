function otpt = findindx(inpt, indx_vec)


otpt(:, 1:3) = inpt(:, 1:3);

for i = 1:length(indx_vec)
    indx = find(inpt(1, :) == indx_vec(i));
    otpt(:, i+3) = inpt(:, indx);
end

    