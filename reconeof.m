function [eof_s, data_s] = reconeof(eofs, pcs, c_indx, mxmde, fsze)



for i = 1:mxmde
    fld = zeros(fsze(1)*fsze(2),1);
    fld(c_indx) = eofs(:,i);
    
    eof_s{1,i} = reshape(fld, fsze(1), fsze(2));
    
    tmp = eofs*pcs(i,:)';
    
    fld = zeros(fsze(1)*fsze(2),1);
    fld(c_indx) = tmp;
    data_s{1,i} = reshape(fld, fsze(1), fsze(2));
    


end
    
    



