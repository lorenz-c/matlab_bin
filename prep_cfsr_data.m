function otpt = prep_cfsr_data(fname, quant, nme)

mnth = 1;
year = 1979;
tmp = nj_varget(fname, quant);

if size(tmp,2) == 361
    grd_flg = 1;
elseif size(tmp,2) == 360
    grd_flg = 0;
end
for i = 1:size(tmp,1)
    
    otpt{i,1} = 'CFSR';
    otpt{i,2} = nme;
    otpt{i,3} = 1;
    otpt{i,4} = mnth;
    otpt{i,5} = year;
    otpt{i,6} = 'Global';
    otpt{i,7} = 89.75:-0.5:-89.75;
    otpt{i,8} = -179.75:0.5:179.75;
    
    otpt{i,9} = shiftdim(tmp(i,:,:));
    
    if grd_flg == 1
        otpt{i,9} = (otpt{i,9}(1:end-1,:) + otpt{i,9}(2:end,:))/2;
        otpt{i,9} = (otpt{i,9} + [otpt{i,9}(:, 2:end) otpt{i,9}(:, 1)])/2;
    end
    
    otpt{i,9} = [otpt{i,9}(:, 361:end) otpt{i,9}(:,1:360)];
    
    
    
    mnth = mnth + 1;
    if mnth == 13
        mnth = 1;
        year = year + 1;
    end
    
    
end