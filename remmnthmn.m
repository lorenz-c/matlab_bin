function [rsdl, mmn] = remmnthmn(inpt, period, clms, mval)


% inpt  = findtstps(inpt, period);
mnths = cell2mat(inpt(:, clms(1)));
yrs   = cell2mat(inpt(:, clms(2)));

mmn  = spatmn(inpt, period, 'monthly', clms, mval);

for i = 1:12
    mnth_indx = find(mnths == i);

    for j = 1:length(mnth_indx)
        rsdl{mnth_indx(j), 1} = mnths(mnth_indx(j));
        rsdl{mnth_indx(j), 2} = yrs(mnth_indx(j));
        rsdl{mnth_indx(j), 3} = inpt{mnth_indx(j), clms(3)} - mmn{i};
    end
end