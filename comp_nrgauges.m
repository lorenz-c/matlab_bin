function [cpc, gpcc, ngauges] = comp_nrgauges

load /media/storage/Data/Precipitation/CPC/CPC_GAUG.mat
load /media/storage/Data/Precipitation/GPCC/GPCC_NGAUGv4.0.mat

load continents.asc

for t = 1:216
    for i = 1:11
        tmp1 = zeros(360, 720);
        tmp2 = zeros(360, 720);
    
        tmp1(continents == i) = 1;
        tmp2(continents == i) = 1;
        
        tmp1 = tmp1.*cpc_gaug{t,9};
        tmp2 = tmp2.*gpcc_ngaug{t+120,9};
        
        ngauges{1,1}(t,i) = sum(sum(tmp1));
        ngauges{1,2}(t,i) = sum(sum(tmp2));
    end
end


for j = 1:11
    k = 1;
    for i = 1:12:216
        cpc(k, j) = mean(ngauges{1}(i:i+11,j));
        gpcc(k, j) = mean(ngauges{2}(i:i+11,j));
        k = k+1;
    end
end
% 
for i = 1:11
    ngauges{1,1}(:,i) = ngauges{1,1}(:,i)/ngauges{1,1}(1,i);
    ngauges{1,2}(:,i) = ngauges{1,2}(:,i)/ngauges{1,2}(1,i);
    cpc(:,i) = cpc(:,i)/cpc(1,i);
    gpcc(:,i) = gpcc(:,i)/gpcc(1,i);
end
        
    
    