function otpt = spataggmn(inpt, clms, miss, id_map, area_id)
% The function computes time-series of area-weighted means over selected 
% areas. These areas are defined in the id_map (a matrix where connected
% regions have the same id). The user can choose multiple areas according
% to their area_id. 
%--------------------------------------------------------------------------
% Input:        n         [1 x 1]   angular side length of a pixel [deg]
%                                   (default: n = 0.5°)   
%               theta     [n x 1]   co-latitude of the pixel center [deg] 
%                                        
% Output:       A         [n x 1]   area of the pixels on the surface
%                                   of the Earth [m^2]          
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   January 2008
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------


if size(area_id,1) > 1
    area_id = area_id';
end

mnths = cell2mat(inpt(:, clms(1)));
yrs   = cell2mat(inpt(:, clms(2)));
flds = inpt(:, clms(3));
clear inpt

theta = 0.25:0.5:179.75;
A_mer = area_wghts(theta, 'mat');

nr_tmestps = length(mnths);
nr_catch   = length(area_id);

dte = datenum(yrs, mnths, ones(nr_tmestps,1)*15);

otpt = zeros(nr_tmestps + 1, nr_catch + 3);
otpt(1, 4:end) = area_id;
otpt(2:end, 1) = mnths;
otpt(2:end, 2) = yrs;
otpt(2:end, 3) = dte;

mask = zeros(360, 720);
tmp  = zeros(nr_tmestps,1);

h = waitbar(0,'','Name','...% of catchments computed'); 
for i = 1:nr_catch
    mask = ismember(id_map, area_id(i));
    tmp = cellfun(@(x) comp_c_sig(x, miss, mask, A_mer), flds);
    otpt(2:end, i+3) = tmp;
    waitbar(i/nr_catch, h, [int2str((i*100)/nr_catch) '%'])
end
close(h)

function catch_sig = comp_c_sig(fld, miss, mask, A_mer)
    mask(fld == miss) = 0;
    tmp    = mask.*A_mer;
    A_ctch  = tmp/sum(sum(tmp)); 
    catch_sig = sum(sum(fld.*A_ctch));



