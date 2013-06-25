function otpt = tavgflds(inpt, mval)

for i = 1:length(inpt)
    if i == 1
        otpt{i,1} = 3/4*inpt{1} + 1/4*inpt{2};
    elseif i == length(inpt)
        otpt{i,1} = 3/4*inpt{i} + 1/4*inpt{i-1};
    else
        otpt{i,1} = 1/4*inpt{i-1} + 1/2*inpt{i} + 1/4*inpt{i+1};
    end
%     otpt{i}(inpt{i} == mval) = mval;
end
