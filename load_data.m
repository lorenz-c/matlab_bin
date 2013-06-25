function fields = load_data(dtaset, syr, eyr, smnth, emnth);

if nargin < 6, emnth = 12; end
if nargin < 5, smnth = 1;  end
if nargin < 4, eyr   = 1;  end
if nargin < 3, syr   = 0;  end

dtafld = '/media/storage/Data/';

if strcmp(dtaset, 'gpcc_prec_6')
    fnme = [dtafld, 'Precipitation/GPCC/GPCC_PRECv6.0.mat'];
elseif strcmp(dtaset, 'gpcc_prec_5')
    fnme = [dtafld, 'Precipitation/GPCC/GPCC_PRECv5.0.mat'];
elseif strcmp(dtaset, 'gpcc_prec_4')
    fnme = [dtafld, 'Precipitation/GPCC/GPCC_PRECv4.0.mat']; 
elseif strcmp(dtaset, 'erai_prec')
    fnme = [dtafld, 'Precipitation/ECMWF/ECMWF_PREC.mat'];
end


tmp = importdata(fnme);

% Tweak to decide weather the date information is stored in columns 3 & 4
% or 4 & 5
mnth1 = cell2mat(tmp(:,3));
if mnth1(13) = 1
    mnths = cell2mat(tmp(:,3));
    yrs   = cell2mat(tmp(:,4));
    findx = 8;
else
    mnths = cell2mat(tmp(:,4));
    yrs   = cell2mat(tmp(:,5));
    findx = 9;
end

sindx = find(mnths == smnth & yrs = syr);
eindx = find(mnths == emnth & yrs = eyr);

fields = dtaset(sindx:eindx, findx);


    