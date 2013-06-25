function mn = wmnpxl(fld, lat_ref, lon_ref, lat_pxl, lon_pxl, clms);


if nargin < 6, clms = [3 4 8]; end
if length(clms) == 4
    dset = 'daily';
elseif length(clms) == 3
    dset = 'monthly';
elseif length(clms) == 2
    dset = 'annual';
end


for i = 1:length(lat_pxl)

    D_lat = lat_ref - lat_pxl(i);
    D_lon = lon_ref - lon_pxl(i);
    
    r(i) = find(abs(D_lat) == min(abs(D_lat)), 1);
    c(i) = find(abs(D_lon) == min(abs(D_lon)), 1);
    
    fld_lat = lat_ref(r(i));
    fld_lon = lon_ref(c(i));
    fprintf('Nearest pixel: lambda = %5f, theta = %5f \n', fld_lon, fld_lat)    
end
keyboard
if size(lat_ref, 2) == 1
    if strcmp(dset, 'daily')
        for i = 1:length(fld)
            mn(i,1)   = fld{i, clms(1)};
            mn(i,2)   = fld{i, clms(2)};
            mn(i,3)   = fld{i, clms(3)};
            mn(i,4)   = datenum(fld{i, clms(3)}, fld{i, clms(2)}, fld{i, clms(1)});
            
            for j = 1:length(lat_pxl)
                mn(i,j+4) = fld{i, clms(4)}(r(j), c(j));
            end
        end
        mn = [0 0 0 0 1:length(lat_pxl); mn];
    elseif strcmp(dset, 'monthly')
        for i = 1:length(fld)
            mn(i,1)   = fld{i, clms(1)};
            mn(i,2)   = fld{i, clms(2)};
            mn(i,3)   = datenum(fld{i, clms(2)}, fld{i, clms(1)}, 15);
            
            for j = 1:length(lat_pxl)
                mn(i,j+3) = fld{i, clms(3)}(r(j), c(j));
            end
        end
        mn = [0 0 0 1:length(lat_pxl); mn];
    end
        
else
    
        K = abs(D_lat) + abs(D_lon);
    
        [r, c] = find(K == min(min(K)));
   
        fld_lat = lat_ref(r, c);
        fld_lon = lon_ref(r, c);
    
end




% 
% P1_lat = D_lat(find(D_lat < delta_lat & D_lat > 0);
% P1_lon = D_lon(find(D_lon < delta_lon & D_lon > 0);
% 
% P2_lat = D_lat(find(D_lat <= delta_lat & D_lat >= 0);
% P2_lon = D_lon(find(D_lon <= delta_lon & D_lon >= 0);