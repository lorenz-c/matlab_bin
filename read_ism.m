function [dta, qf] = read_ism(dtadir, gauge, sensor, subset, period, pltflg, tscale)


% Format of ISMN-data
frmt = '%4u %*1c %2u %*1c %2u %3u %*3c %9f %*2c';

if strcmp(tscale, 'monthly')
    if strcmp(subset, 'scan')
        % Construct the filenames
        fnme{1} = [dtadir, gauge, '/SCAN_SCAN_', gauge, '_sm_0.050800_0.050800_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
        fnme{2} = [dtadir, gauge, '/SCAN_SCAN_', gauge, '_sm_0.101600_0.101600_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
        fnme{3} = [dtadir, gauge, '/SCAN_SCAN_', gauge, '_sm_0.203200_0.203200_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
        fnme{4} = [dtadir, gauge, '/SCAN_SCAN_', gauge, '_sm_0.508000_0.508000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
        fnme{5} = [dtadir, gauge, '/SCAN_SCAN_', gauge, '_sm_1.016000_1.016000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];  

        % Get some data...
        for i = 1:5
            fprintf('Reading file %s \n', fnme{i})
            [yr, mnth, day, hr, fld(:, i)] = textread(fnme{i}, frmt, -1, 'headerlines', 1);
        end
 
        intym        = yr*100 + mnth;
        intym_unique = unique(intym);
    
        for i = 1:length(intym_unique)

            indx = find(intym == intym_unique(i)); 
            dta(i,1)  = rem(intym_unique(i), 100);
            dta(i,2)  = floor(intym_unique(i)/100);
            dta(i,3)  = datenum(floor(intym_unique(i)/100), rem(intym_unique(i), 100), 15);
        
            qf(i,1)  = rem(intym_unique(i), 100);
            qf(i,2)  = floor(intym_unique(i)/100);
            qf(i,3)  = datenum(floor(intym_unique(i)/100), rem(intym_unique(i), 100), 15);
        
            dta(i,4:8) = nanmean(fld(indx, :));

        
            length_nan(1,1) = sum(isnan(fld(indx, 1)));
            length_nan(1,2) = sum(isnan(fld(indx, 2)));
            length_nan(1,3) = sum(isnan(fld(indx, 3)));
            length_nan(1,4) = sum(isnan(fld(indx, 4)));
            length_nan(1,5) = sum(isnan(fld(indx, 5)));
            qf(i,4:8)       = (length(indx) - length_nan)./length(indx);
        
            for j = 1:5
                if qf(i, j+3) < 0.8
                    fprintf('Less than 80 percent of data for TS %u and depth %u \n', intym_unique(i), j)
                end
            end
        end
    
        if pltflg 
        
            clr = [  60   60    60;
                    050  136   189;
                    244  109    67;
                    026  152   080;
                    240  130   40;
                 0  200  200;
               230  220   50;
               160    0  200;
               160  230   50;
                 0  160  255;
               240    0  130;
               230  175   45;
                 0  210  140;
               130    0  220]/255; 
           
           
            figure
            tlt = ['Soil moisture vs. data availability at ', gauge];
            title(tlt, 'fontsize', 12); hold on; 
        
            plot(dta(:,3), dta(:,4), 'Color', clr(1,:), 'Linewidth', 1.5);
            plot(dta(:,3), dta(:,5), 'Color', clr(2,:),  'Linewidth', 1.5);
            plot(dta(:,3), dta(:,6), 'Color', clr(3,:),  'Linewidth', 1.5);
            plot(dta(:,3), dta(:,7), 'Color', clr(4,:), 'Linewidth', 1.5);
            plot(dta(:,3), dta(:,8), 'Color', clr(5,:),  'Linewidth', 1.5);
        
            plot(dta(:,3), qf(:,4),  '--', 'Color', clr(1,:), 'Linewidth', 1.5);   
            plot(dta(:,3), qf(:,5),  '--', 'Color', clr(2,:), 'Linewidth', 1.5);
            plot(dta(:,3), qf(:,6),  '--', 'Color', clr(3,:), 'Linewidth', 1.5);
            plot(dta(:,3), qf(:,7),  '--', 'Color', clr(4,:), 'Linewidth', 1.5);
            plot(dta(:,3), qf(:,8),  '--', 'Color', clr(5,:), 'Linewidth', 1.5);
        
            ylim([0 1]);
            datetick('x', 'yyyy')
            pbaspect([3 1 1])
            legend('5cm', '10cm', '20cm', '50cm', '100cm');

        end
    
    elseif strcmp(subset, 'icn')
        if strcmp(gauge, 'OrrCenter(Perry)')
            fnme{1}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.000000_0.100000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{2}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.100000_0.300000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{3}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.300000_0.500000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{4}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.500000_0.700000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{5}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.700000_0.900000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{6}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.900000_1.100000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
        
            depth = [10, 20, 20, 20, 20, 20];
        
        else   
            fnme{1}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.100000_0.300000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{2}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.300000_0.500000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{3}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.500000_0.700000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{4}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.700000_0.900000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{5}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.900000_1.100000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{6}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_1.100000_1.300000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{7}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_1.300000_1.500000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{8}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_1.500000_1.700000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{9}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_1.700000_1.900000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{10} = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_1.900000_2.000000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
        
            depth = [20, 20, 20, 20, 20, 20, 20, 20, 20,  10];
        end
    
        % Get some data...
        for i = 1:length(fnme)
            fprintf('Reading file %s \n', fnme{i})
            [yr, mnth, day, hr, fld(:, i)] = textread(fnme{i}, frmt, -1, 'headerlines', 1);
        end
    
        intym        = yr*100 + mnth;
        intym_unique = unique(intym);
    
        for i = 1:length(intym_unique)
            indx = find(intym == intym_unique(i)); 
            dta(i,1)  = rem(intym_unique(i), 100);
            dta(i,2)  = floor(intym_unique(i)/100);
            dta(i,3)  = datenum(floor(intym_unique(i)/100), rem(intym_unique(i), 100), 15);
        
            dta(i,4:4+length(fnme)-1) = nanmean(fld(indx, :));
        end
    
        if pltflg 
         
            clr = [ 60   60    60;
               050  136  189;
               244  109   67;
               026  152  080;
               240  130   40;
                 0  200  200;
               230  220   50;
               160    0  200;
               160  230   50;
                 0  160  255;
               240    0  130;
               230  175   45;
                 0  210  140;
               130    0  220]/255; 
            figure
            tlt = ['Soil moisture at ', gauge];
            title(tlt, 'fontsize', 12); hold on; 
        
            if strcmp(gauge, 'OrrCenter(Perry)')
                plot(dta(:,3), dta(:,4), 'Color', clr(1,:), 'Linewidth',  1.5);
                plot(dta(:,3), dta(:,5), 'Color', clr(2,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,6), 'Color', clr(3,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,7), 'Color', clr(4,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,8), 'Color', clr(5,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,5), 'Color', clr(6,:),  'Linewidth', 1.5);
            
                ylim([0 1]);
                datetick('x', 'yyyy')
                pbaspect([3 1 1])
                legend('0-10cm', '10-30cm', '30-50cm', '50-70cm', '70-90cm', '90-110cm');
            else
            
                plot(dta(:,3), dta(:,4),  'Color', clr(1,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,5),  'Color', clr(2,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,6),  'Color', clr(3,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,7),  'Color', clr(4,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,8),  'Color', clr(5,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,9),  'Color', clr(6,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,10), 'Color', clr(7,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,11), 'Color', clr(8,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,12), 'Color', clr(9,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,13), 'Color', clr(10,:), 'Linewidth', 1.5);
            
                ylim([0 1]);
                datetick('x', 'yyyy')
                pbaspect([3 1 1])
                legend('10-30cm', '30-50cm', '50-70cm', '70-90cm', '90-110cm', '110-130cm', '130-150cm', '150-170cm', '170-190cm', '190-200cm');

        


            end
        end
    qf = 1;
    end

elseif strcmp(tscale, 'daily')
    if strcmp(subset, 'scan')
        % Construct the filenames
        fnme{1} = [dtadir, gauge, '/SCAN_SCAN_', gauge, '_sm_0.050800_0.050800_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
        fnme{2} = [dtadir, gauge, '/SCAN_SCAN_', gauge, '_sm_0.101600_0.101600_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
        fnme{3} = [dtadir, gauge, '/SCAN_SCAN_', gauge, '_sm_0.203200_0.203200_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
        fnme{4} = [dtadir, gauge, '/SCAN_SCAN_', gauge, '_sm_0.508000_0.508000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
        fnme{5} = [dtadir, gauge, '/SCAN_SCAN_', gauge, '_sm_1.016000_1.016000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];  

        % Get some data...
        for i = 1:5
            fprintf('Reading file %s \n', fnme{i})
            [yr, mnth, day, hr, fld(:, i)] = textread(fnme{i}, frmt, -1, 'headerlines', 1);
        end
 
        intymd        = yr*10000 + mnth*100 + day;
        intymd_unique  = unique(intymd);
    
        for i = 1:length(intymd_unique)

            indx = find(intymd == intymd_unique(i)); 
        
            tmp_dte = num2str(intymd_unique(i));
            dta(i,1)  = str2num(tmp_dte(7:8));
            dta(i,2)  = str2num(tmp_dte(5:6));
            dta(i,3)  = str2num(tmp_dte(1:4));
            dta(i,4)  = datenum(dta(i,3), dta(i,2), dta(i,1));

            qf(i, 1:4) = dta(i, 1:4);
      
        
            dta(i,5:9) = nanmean(fld(indx, :));

        
            length_nan(1,1) = sum(isnan(fld(indx, 1)));
            length_nan(1,2) = sum(isnan(fld(indx, 2)));
            length_nan(1,3) = sum(isnan(fld(indx, 3)));
            length_nan(1,4) = sum(isnan(fld(indx, 4)));
            length_nan(1,5) = sum(isnan(fld(indx, 5)));
            qf(i,5:9)       = (length(indx) - length_nan)./length(indx);
        
            for j = 1:5
                if qf(i, j+4) < 0.8
                    fprintf('Less than 80 percent of data for TS %u and depth %u \n', intymd_unique(i), j)
                end
            end
        end
    
        if pltflg 
        
            clr = [ 60   60    60;
               050  136  189;
               244  109   67;
               026  152  080;
               240  130   40;
                 0  200  200;
               230  220   50;
               160    0  200;
               160  230   50;
                 0  160  255;
               240    0  130;
               230  175   45;
                 0  210  140;
               130    0  220]/255; 
           
           
            figure
            tlt = ['Soil moisture vs. data availability at ', gauge];
            title(tlt, 'fontsize', 12); hold on; 
        
            plot(dta(:,4), dta(:,5), 'Color', clr(1,:), 'Linewidth', 1.5);
            plot(dta(:,4), dta(:,6), 'Color', clr(2,:),  'Linewidth', 1.5);
            plot(dta(:,4), dta(:,7), 'Color', clr(3,:),  'Linewidth', 1.5);
            plot(dta(:,4), dta(:,8), 'Color', clr(4,:), 'Linewidth', 1.5);
            plot(dta(:,4), dta(:,9), 'Color', clr(5,:),  'Linewidth', 1.5);
        
            plot(dta(:,4), qf(:,5),  '--', 'Color', clr(1,:), 'Linewidth', 1.5);   
            plot(dta(:,4), qf(:,6),  '--', 'Color', clr(2,:), 'Linewidth', 1.5);
            plot(dta(:,4), qf(:,7),  '--', 'Color', clr(3,:), 'Linewidth', 1.5);
            plot(dta(:,4), qf(:,8),  '--', 'Color', clr(4,:), 'Linewidth', 1.5);
            plot(dta(:,4), qf(:,9),  '--', 'Color', clr(5,:), 'Linewidth', 1.5);
        
            ylim([0 1]);
            datetick('x', 'yyyy')
            pbaspect([3 1 1])
            legend('5cm', '10cm', '20cm', '50cm', '100cm');

        end
    elseif strcmp(subset, 'icn')
        if strcmp(gauge, 'OrrCenter(Perry)')
            fnme{1}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.000000_0.100000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{2}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.100000_0.300000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{3}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.300000_0.500000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{4}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.500000_0.700000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{5}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.700000_0.900000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{6}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.900000_1.100000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
        
            depth = [10, 20, 20, 20, 20, 20];
        
        else   
            fnme{1}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.100000_0.300000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{2}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.300000_0.500000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{3}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.500000_0.700000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{4}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.700000_0.900000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{5}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_0.900000_1.100000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{6}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_1.100000_1.300000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{7}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_1.300000_1.500000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{8}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_1.500000_1.700000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{9}  = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_1.700000_1.900000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
            fnme{10} = [dtadir, gauge, '/ICN_ICN_', gauge, '_sm_1.900000_2.000000_', sensor, '_', num2str(period(1)), '_', num2str(period(2)), '.stm'];
        
            depth = [20, 20, 20, 20, 20, 20, 20, 20, 20,  10];
        end
    
        % Get some data...
        for i = 1:length(fnme)
            fprintf('Reading file %s \n', fnme{i})
            [yr, mnth, day, hr, fld(:, i)] = textread(fnme{i}, frmt, -1, 'headerlines', 1);
        end
    
        intymd         = yr*10000 + mnth*100 + day;
        intymd_unique  = unique(intymd);
    keyboard
        for i = 1:length(intymd_unique)
            
            indx = find(intymd == intymd_unique(i)); 
        
            tmp_dte = num2str(intymd_unique(i));
            dta(i,1)  = str2num(tmp_dte(7:8));
            dta(i,2)  = str2num(tmp_dte(5:6));
            dta(i,3)  = str2num(tmp_dte(1:4));
            dta(i,4)  = datenum(dta(i,3), dta(i,2), dta(i,1));

            dta(i,5:4+length(fnme)-1) = nanmean(fld(indx, :));
            
        
        end
    
        if pltflg 
         
            clr = [ 60   60    60;
               050  136  189;
               244  109   67;
               026  152  080;
               240  130   40;
                 0  200  200;
               230  220   50;
               160    0  200;
               160  230   50;
                 0  160  255;
               240    0  130;
               230  175   45;
                 0  210  140;
               130    0  220]/255; 
            figure
            tlt = ['Soil moisture at ', gauge];
            title(tlt, 'fontsize', 12); hold on; 
        
            if strcmp(gauge, 'OrrCenter(Perry)')
                plot(dta(:,3), dta(:,4), 'Color', clr(1,:), 'Linewidth',  1.5);
                plot(dta(:,3), dta(:,5), 'Color', clr(2,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,6), 'Color', clr(3,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,7), 'Color', clr(4,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,8), 'Color', clr(5,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,5), 'Color', clr(6,:),  'Linewidth', 1.5);
            
                ylim([0 1]);
                datetick('x', 'yyyy')
                pbaspect([3 1 1])
                legend('0-10cm', '10-30cm', '30-50cm', '50-70cm', '70-90cm', '90-110cm');
            else
            
                plot(dta(:,3), dta(:,4),  'Color', clr(1,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,5),  'Color', clr(2,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,6),  'Color', clr(3,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,7),  'Color', clr(4,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,8),  'Color', clr(5,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,9),  'Color', clr(6,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,10), 'Color', clr(7,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,11), 'Color', clr(8,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,12), 'Color', clr(9,:),  'Linewidth', 1.5);
                plot(dta(:,3), dta(:,13), 'Color', clr(10,:), 'Linewidth', 1.5);
            
                ylim([0 1]);
                datetick('x', 'yyyy')
                pbaspect([3 1 1])
                legend('10-30cm', '30-50cm', '50-70cm', '70-90cm', '90-110cm', '110-130cm', '130-150cm', '150-170cm', '170-190cm', '190-200cm');

        


            end
        end
        qf = 1;
    end

    
        
    end
end

    
        
  


