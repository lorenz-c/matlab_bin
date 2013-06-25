function cfsr = read_cfsr(fname, variable);

ncRef = fname;
sprintf('Reading file %s', fname)
flds  = nj_varget(fname, variable);
tme   = nj_varget(ncRef, 'time');
sprintf('...done')

nr_timesteps = length(tme);

year  = 1979;
month = 1;

for i = 1:nr_timesteps
    
    dte(i,1) = month;
    dte(i,2) = year;
    month = month + 1;
    
    if month == 13
        month = 1;
        year  = year + 1;
    end
    
end


if strcmp(variable, 'Total_precipitation')
    fldnme = 'PREC';
    unit   = '[mm/month]';
elseif strcmp(variable, 'Temperature')
    fldnme = 'T2';
    unit   = '[°C]';
end

h = waitbar(0,'','Name','Reading progress...');

for i = 1:nr_timesteps
    cfsr{i,9} = shiftdim(flds(i,:,:));
    cfsr{i,9} = resizem(cfsr{i,9}, [360, 720]);
    cfsr{i,9} = [cfsr{i,9}(:, 361:end) cfsr{i,9}(:, 1:360)]; 
    cfsr{i,1} = 'CFSR';
    cfsr{i,2} = fldnme;
    cfsr{i,3} = 1;
    cfsr{i,4} = dte(i,1);
    cfsr{i,5} = dte(i,2);
    cfsr{i,6} = 'Global';
    cfsr{i,7} = 89.76:-0.5:-89.75;
    cfsr{i,8} = -179.75:0.5:179.75;
    cfsr{i,10} = unit;
    waitbar(i/nr_timesteps, h, [int2str(i) '/' int2str(nr_timesteps) ' time-steps'])
end
close(h)

    
