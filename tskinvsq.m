function xhat = tskinvsq(tskin, q, time, period, cswitch, clms_t, clms_q)




sind_t = find(cell2mat(tskin(:,clms_t(1))) == 1   & ...
                                cell2mat(tskin(:,clms_t(2))) == time(1));
eind_t = find(cell2mat(tskin(:,clms_t(1))) == 12  & ...
                                cell2mat(tskin(:,clms_t(2))) == time(2));
                            
sind_q = find(cell2mat(q(:,clms_q(1))) == 1   & ...
                                cell2mat(q(:,clms_q(2))) == time(1));
eind_q = find(cell2mat(q(:,clms_q(1))) == 12  & ...
                                cell2mat(q(:,clms_q(2))) == time(2));                            
                            
                          
fields      = tskin(sind_t:eind_t, clms_t);
fields(:,4) = q(sind_q:eind_q, clms_q(3));

clear tskin q

skintemp = comp_spat_mean(fields, time, period, [1 2 3], -9999, 0);
qtot     = comp_spat_mean(fields, time, period, [1 2 4], -9999, 0);

load continents.asc
mask_t = zeros(size(fields{1,3}));

if cswitch == 0
	mask_t = mask_t + 1;                  % All values          
elseif cswitch == 1
    mask_t(continents ~= -9999) = 1;      % Continental values   
    mask_t(continents == 4) = 0;
elseif cswitch == 2
    mask_t(continents == -9999) = 1;      % Oceanic values
    mask_t(continents == 4)    = 1;
elseif cswitch == 3
    mask_t(continents ~= -9999) = 1;      % Without ice shelf
	mask_t(continents == 4)    = 0;
elseif cswitch == 4
    mask_t(continents ~= -9999) = 1;      % Without polar regions
    mask_t(continents == 0)    = 0;
	mask_t(continents == 4)    = 0;
end

if iscell(skintemp)
    for i = 1:length(skintemp)
        [tmp1, indx] = sort(skintemp{i}(mask_t ~= 0), 'ascend');
        tmp2 = qtot{i}(mask_t ~= 0);
        tmp2 = tmp2(indx);
        
        A = [ones(length(tmp1),1) log(tmp1)];
        l = log(tmp2);
        
        xhat(:,i) = inv(A'*A)*A'*l;
        tt = 230:5:305;
        ln = exp(xhat(1,i))*tt.^xhat(2,i);
        loglog(tmp1(1:100:end), tmp2(1:100:end), 'xy');
        hold on
        loglog(tt, ln, 'g')
    end
else
    [tmp1, indx] = sort(skintemp(mask_t ~= 0), 'ascend');
	tmp2 = qtot(mask_t ~= 0);
	tmp2 = tmp2(indx);
        
	A = [ones(length(tmp1),1) log(tmp1)];
	l = log(tmp2);
        
	xhat = inv(A'*A)*A'*l;
    
    tt = 230:5:305;
    ln = exp(xhat(1))*tt.^xhat(2);
    loglog(tmp1, tmp2, 'o');
    hold on

    loglog(tt, ln, 'r')
end



    
        
       
        
        
    