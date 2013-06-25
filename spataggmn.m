function otpt = spataggmn(inpt, id_map, area_id, varargin)
% The function computes time-series of area-weighted means over selected 
% areas. These areas are defined in the id_map (a matrix where connected
% regions have the same id). The user can choose multiple areas according
% to their area_id. 
% If information about the timesteps (year, month) is provided, the 
% function saves the months and years in the first two columns of the 
% output and the appropriate serial date number (according to matlabs 
% datetick-specification) in the third column. The first row contains the
% area_id(s) of the selected regions while the elements of the remaining
% (2:end) rows are the area-weighted means of the areas.
%--------------------------------------------------------------------------
% Input:        inpt      {m x n}   Cell array which contains the input 
%                                   fields.                
%               id_map    [i x j]   Map which defines the different areas
%               area_id   [1 x k]   Vector (or scalar) which contains the
%                                   ids of the desired areas
%               clms      [1 x 3]   column indices of the input containing 
%                                   month, year and the corresponding field 
%                         [1 x 1]   column index of the input fields
%               miss      [1 x 1]   value of undefined elements in the
%                                   input fields
%                                        
% Output:       otpt      [m x k]   matrix containing the area-weighted 
%                                   means      
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   July 2011
%--------------------------------------------------------------------------
% Uses: area_wghts.m, cell2catchmat.m
%--------------------------------------------------------------------------
% Updates: - 25.01.2013 For-loops removed, switched to matrix-based 
%                       computation 
%--------------------------------------------------------------------------

% Checking input arguments and setting default values
pp = inputParser;
pp.addRequired('inpt', @(x)iscell(x));   
pp.addRequired('id_map', @(x) (isnumeric(x) | iscell(x)));
pp.addRequired('area_id', @isnumeric);                     

pp.addParamValue('theta', (89.75:-0.5:-89.75)', @isnumeric);
pp.addParamValue('dlambda', 0.5, @isnumeric);
pp.addParamValue('clms', [3 4 8], @isnumeric);              
pp.addParamValue('miss', -9999, @(x) (isnumeric(x) | strcmp(x, 'NaN')));
pp.addParamValue('method', 'wmean')
pp.addParamValue('areamethod', 'regular')

pp.parse(inpt, id_map, area_id, varargin{:})

clms = pp.Results.clms;
miss = pp.Results.miss;
method = pp.Results.method;
theta = pp.Results.theta;
dlambda = pp.Results.dlambda;
areamethod = pp.Results.areamethod;

clear pp

nr_tstps = length(inpt(:, clms(1)));
nr_catch = length(area_id);


if length(clms) == 4
    dys   = cell2mat(inpt(:, clms(1)));
    mnths = cell2mat(inpt(:, clms(2)));
    yrs   = cell2mat(inpt(:, clms(3)));
    dte   = datenum(yrs, mnths, dys);
    [f_rws, f_cls] = size(inpt{1,clms(3)});
   
     
    flds = inpt(:,clms(4));
    otpt = zeros(nr_tstps + 1, nr_catch + 4);
    otpt(1, 5:end) = area_id;
    otpt(2:end, 1) = dys;
    otpt(2:end, 2) = mnths;
    otpt(2:end, 3) = yrs;
    otpt(2:end, 4) = dte;
    
    dte_els = 4;
    
    
    
elseif length(clms) == 3
    
    mnths = cell2mat(inpt(:, clms(1)));
    yrs   = cell2mat(inpt(:, clms(2)));
    dte   = datenum(yrs, mnths, ones(nr_tstps,1)*15);
    [f_rws, f_cls] = size(inpt{1,clms(3)});
    
    flds = inpt(:,clms(3));
    otpt = zeros(nr_tstps + 1, nr_catch + 3);
    otpt(1, 4:end) = area_id;
    otpt(2:end, 1) = mnths;
    otpt(2:end, 2) = yrs;
    otpt(2:end, 3) = dte;
    
    dte_els = 3;
    
elseif length(clms) == 1
    
    [f_rws, f_cls] = size(inpt{1,clms(1)});
    
    otpt = zeros(nr_tstps + 1, nr_catch + 1);
    otpt(1, 2:end) = area_id;
    otpt(2:end, 1) = (1:nr_tstps)';
    
    flds = inpt(:,clms(1));
    
    dte_els = 1;
    
end

clear inpt


% Create a binary mask to remove all "unwanted" elements
bin_mask = zeros(size(flds{1}));

for i = 1:nr_catch
    bin_mask(id_map == area_id(i)) = 1;
end

% Go through the input dataset and set all missing elements to zero in the
% binary and the id map
for i = 1:nr_tstps
    bin_mask(flds{i} == miss) = 0;
end
id_map(bin_mask == 0) = 0;


% Re-arrange the maps to vectors which contain only the non-zero elements
% of bin_mask
bin_vec = bin_mask(bin_mask ~= 0);
id_vec  = id_map(bin_mask ~= 0);



% For each region, a row in the matrix H is created. At this stage, H is
% binary and defines if an element in the data matrix contains to the
% current catchment or not.
for i = 1:nr_catch
    tmp = bin_vec;
    tmp(id_vec ~= area_id(i)) = 0;
    H(:, i) = tmp;
end

% For weighted computations, a matrix A_mer is created which contains the
% areas of the pixels. This is used, depending on the chosen method, to
% apply area weights to the elements in the data matrix. As these are all 
% linear operations (y=A*H), the weights are added to the H-matrix.
if strcmp(method, 'wmean')   
    A_mer = area_wghts(theta', dlambda, 'mat', areamethod);
    A_mer = A_mer(bin_mask ~= 0);
    
    H = H.*repmat(A_mer, [1 nr_catch]);
    H = H./(ones(length(bin_vec), 1)*sum(H));
    
elseif strcmp(method, 'mean')         
    H = H./(ones(length(bin_vec), 1)*sum(H))
    
elseif strcmp(method, 'wsum')    
    A_mer = area_wghts(theta', dlambda, 'mat', areamethod);
    A_mer = A_mer(bin_mask ~= 0);
    
    H = H.*repmat(A_mer, [1 nr_catch]);
end

% Re-arrange the input fields in a big matrix, which contains only the
% pixels which are located in one of the areas of interest
flds_mat = cell2catchmat(flds, bin_mask);

% Now, the aggregated values can be computed by simple matrix
% multiplication:
otpt(2:end, dte_els+1:end) = flds_mat*H;


    
    
        
        
        
       
    
    
        
    


