function R = spatcorr(fld1, fld2, varargin{:})




% Checking input arguments and setting default values
pp = inputParser;
pp.addRequired('fld1', @isnumeric);   
pp.addRequired('fld2', @isnumeric); 
                   
pp.addParamValue('mask', ones(size(fld1)), @isnumeric);
pp.addParamValue('method', 'awghts')
pp.addParamValue('mval1', -9999, @isnumeric);
pp.addParamValue('mval2', -9999, @isnumeric);
pp.addParamValue('theta', (89.75:-0.5:-89.75)', @isnumeric);
pp.addParamValue('dlambda', 0.5, @isnumeric);

pp.parse(fld1, fld2, varargin{:})

mask   = pp.Results.clms;
method = pp.Results.method;
mval1  = pp.Results.mval1;
mval2  = pp.Results.mval2;
theta  = pp.Results.theta;
dlamba = pp.Results.dlambda;


% Removing the missing values for both fields
mask(fld1 == mval1) = 0;
mask(fld2 == mval2) = 0;

fld1 = fld1.*mask;
fld2 = fld2.*mask;


if strcmp(method, 'awghts')
    A = area_wghts(theta, dlambda, 'mat', 'haversine');
    
    mn1 = sum(sum(fld1.*A.*mask))./sum(sum(A.*mask));
    mn2 = sum(sum(fld2.*A.*mask))./sum(sum(A.*mask));
    





