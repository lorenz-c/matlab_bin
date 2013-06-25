function [zonal_prec] = comp_zon_prec(inpt, clms, time, cswitch, tscale)


if cswitch == 1
    load indexfile3.asc
    mask = indexfile3;
    mask(mask>0) = 1;
    mask(mask == -9999) = 0;
end


yrs = time(1):1:time(2);

sind = find(cell2mat(inpt(:,4)) == 1   &  cell2mat(inpt(:,5)) == time(1));
eind = find(cell2mat(inpt(:,4)) == 12  &  cell2mat(inpt(:,5)) == time(2));

if strcmp(tscale, 'yr')
    jan_ind = sind:12:eind;

    theta = 0.25:0.5:179.75;
    A     = area_wghts(theta, 0.5);
    A     = A';

    for i = 1:length(jan_ind)
    
        mask = indexfile3;
        mask(mask>0) = 1;
        mask(mask == -9999) = 0;
    
        ann_mean = zeros(360, 720);
    
        for j = 1:12
        
            tmp = inpt{jan_ind(i) + j - 1, 9};
            mask(tmp == -9999) = 0;
            tmp =  tmp.*mask;

            ann_mean = ann_mean + tmp;

        end
    
        valid_cells  = sum(mask,2);
        tot_lat_area = A.*valid_cells;
        total_area   = sum(tot_lat_area);
        lat_weights  = tot_lat_area./total_area;

        zonal_prec_tmp(:,i) = sum(ann_mean,2).*lat_weights;
%     keyboard
        plot(zonal_prec_tmp(:,i));
        hold on
    end
    zonal_prec = mean(zonal_prec_tmp,2);
    
elseif strcmp(tscale, 'mnth')
    
    tmp_fields = inpt(sind:eind,:);
    
    for i = 1:12
        
        
        mnth_ind = find(cell2mat(tmp_fields(:, 4)) == i);
        
        mnth_mean = zeros(360, 720);
        
        mask = indexfile3;
        mask(mask>0) = 1;
        mask(mask == -9999) = 0;
        
        for j = 1:length(mnth_ind)
            tmp = tmp_fields{mnth_ind(j), 9};
            mask(tmp == -9999) = 0;
            tmp =  tmp.*mask;
            
            mnth_mean = mnth_mean + tmp;
        end

        valid_cells  = sum(mask,2);
        tot_lat_area = A.*valid_cells;
        total_area   = sum(tot_lat_area);
        lat_weights  = tot_lat_area./total_area;
        
        zonal_prec(:,i) = sum(mnth_mean,2).*lat_weights;
    end
end

            
            
            
        
        
    
    


        




   

