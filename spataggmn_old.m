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
% Uses: area_wghts.m
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


if size(area_id,1) > 1
    area_id = area_id';
end


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
[nlats, nlons] = size(flds{1});

A_mer  = area_wghts(theta', dlambda, 'mat', areamethod);

if nr_catch > 10
    h = waitbar(0,'','Name','...% of catchments computed'); 
end

for i = 1:nr_catch
       
    for j = 1:nr_tstps
        mask = zeros(nlats, nlons);
        mask(id_map == area_id(i)) = 1; 
        if isnan(miss)
            mask(isnan(flds{j})) = 0;
            flds{j}(isnan(flds{j})) = 0;
        else
            mask(flds{j} == miss) = 0;
        end
        
        if strcmp(method, 'wmean')
            tmp       = mask.*A_mer;
            A_ctch    = tmp/sum(sum(tmp));
            otpt(j+1, i+dte_els) = sum(sum(flds{j}.*A_ctch));
        
        elseif strcmp(method, 'mean')
            tmp       = mask.*flds{j};
            otpt(j+1, i+dte_els) = sum(sum(tmp))/sum(sum(mask));
            
        elseif strcmp(method, 'sum')
            tmp       = mask.*flds{j};
            otpt(j+1, i+dte_els) = sum(sum(tmp));
            
        elseif strcmp(method, 'wsum')
            tmp       = mask.*A_mer.*flds{j};
            otpt(j+1, i+dte_els) = sum(sum(tmp));
        end
    end

        
    if exist('h')
        waitbar(i/nr_catch, h, [int2str((i*100)/nr_catch) '%'])
    end
    
end

if exist('h')
    close(h)
end
    
    
        
        
        
       
    
    
        
    


