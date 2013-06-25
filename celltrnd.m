function [a, b, varargout] = celltrnd(inpt, mask, mval, clms, method)


if size(clms) == 1
    findx = clms(1);
elseif size(clms) == 2
    findx = clms(2);
else
    findx = clms(3);
end

[r, c]      = size(inpt{1, findx});

[F, c_indx] = cell2catchmat(inpt(:, findx), mask);


[nts, npxls]   = size(F);
% F = F - ones(nts, 1)*mean(F);
t = (0:nts-1)';

A = [ones(nts, 1) t];

if strcmp(method, 'daywghts') & size(clms) == 3
    mnths = cell2mat(inpt(:, clms(1)));
    yrs   = cell2mat(inpt(:, clms(2)));
    
    dom   = eomday(yrs, mnths);
    P     = diag(dom);
    
elseif strcmp(method, 'daywghts') & size(clms) == 2
    
    yrs   = cell2mat(inpt(:, clms(1)));
    
    for i = 1:length(yrs)
        doy(i) = sum(eomday(yrs(i), 1:12));
    end
    
    P     = diag(doy);
    
else
    P     = eye(nts);
end



for i = 1:npxls
    
    N = inv(A'*P*A);
    xht = N*A'*P*F(:,i);
    
    a_vec(i)       = xht(1);    
    b_vec(i) = xht(2);
    
    sigma_aa_vec(i) = N(1,1);
    sigma_bb_vec(i) = N(2,2);
    sigma_ab_vec(i) = N(1,2);

    
end

a = catchmat2cell(a_vec, c_indx, r, c, mval);
b = catchmat2cell(b_vec, c_indx, r, c, mval);

if nargout > 2
    varargout{1} = catchmat2cell(sigma_aa_vec, c_indx, r, c, mval);
    varargout{2} = catchmat2cell(sigma_bb_vec, c_indx, r, c, mval);
    varargout{3} = catchmat2cell(sigma_ab_vec, c_indx, r, c, mval);
end



