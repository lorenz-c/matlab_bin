function otpt = cellmovav(inpt, clms, mval, method)


if nargin < 4, method = 'wavg'; end
if nargin < 3, mval = -9999; end
if nargin < 2, clms = [3 4 8]; end

nts = length(inpt);
mnths = cell2mat(inpt(:, clms(1)));
yrs   = cell2mat(inpt(:, clms(2)));


if strcmp(method, 'wavg')
    dom = eomday(yrs, mnths);

    for i = 1:nts
        otpt{i,1} = mnths(i);
        otpt{i,2} = yrs(i);
    
        if i == 1
            otpt{i, 3} = (3*dom(i)*inpt{i, clms(3)} + ...
                          dom(i+1)*inpt{i+1, clms(3)})/sum([3*dom(i) dom(i+1)]);
        elseif i == nts
            otpt{i, 3} = (3*dom(i)*inpt{i, clms(3)} + ...
                          dom(i-1)*inpt{i-1, clms(3)})/sum([3*dom(i) dom(i-1)]);
        else
            otpt{i, 3} = (dom(i-1)*inpt{i-1, clms(3)} + ...
                          2*dom(i)*inpt{i, clms(3)} + ...
                          dom(i+1)*inpt{i+1, clms(3)})/sum([dom(i-1) 2*dom(i) dom(i+1)]);
        end

    otpt{i, 3}(inpt{i, clms(3)} == mval) = mval;
    end
    
elseif strcmp(method, 'avg')
    
    for i = 1:nts
        otpt{i,1} = mnths(i);
        otpt{i,2} = yrs(i);
    
        if i == 1
            otpt{i, 3} = 3/4*inpt{i, clms(3)} + 1/4*inpt{i+1, clms(3)};
        elseif i == nts
            otpt{i, 3} = 3/4*inpt{i, clms(3)} + 1/4*inpt{i-1, clms(3)};
        else
            otpt{i, 3} = 1/4*inpt{i-1, clms(3)} + 1/2*inpt{i, clms(3)} + ...
                         1/4*inpt{i+1, clms(3)};
        end      

        otpt{i, 3}(inpt{i, clms(3)} == mval) = mval;
    end
    
end
        

                      
                      
                      
                      
            
            