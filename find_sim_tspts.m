function [fld1_out, fld2_out] = find_sim_tspts(fld1, fld2, tref, dailydta);


if nargin < 4, dailydta = 0; end
if nargin < 3, tref = 1; end

if tref == 1
    if dailydta == 1
        dtes_1 = fld1(2:end, 4);
        dtes_2 = fld2(2:end, 4);
        
        sdte_1 = dtes_1(1);
        edte_1 = dtes_1(end);
    
        sdte_2 = dtes_2(1);
        edte_2 = dtes_2(end);
    else
        dtes_1 = fld1(2:end, 3);
        dtes_2 = fld2(2:end, 3);
        
        sdte_1 = dtes_1(1);
        edte_1 = dtes_1(end);
    
        sdte_2 = dtes_2(1);
        edte_2 = dtes_2(end);
    end
end


if sdte_1 <= sdte_2
    sindx_1 = find(dtes_1 == sdte_2);
    sindx_2 = 1;
elseif sdte_2 < sdte_1
    sindx_1 = 1;
    sindx_2 = find(dtes_2 == sdte_1);
end

if isempty(sindx_1) | isempty(sindx_2)
    error('Datasets do not cover the same time-period!')
end

if edte_1 <= edte_2
    eindx_1 = length(dtes_1);
    eindx_2 = find(dtes_2 == edte_1);
elseif edte_2 < edte_1
    eindx_1 = find(dtes_1 == edte_2);
    eindx_2 = length(dtes_2);
end

if isempty(eindx_1) | isempty(eindx_2)
    error('Datasets do not cover the same time-period!')
end

fld1_out = [fld1(1, :); fld1(sindx_1 + 1 : eindx_1 + 1, :)];
fld2_out = [fld2(1, :); fld2(sindx_2 + 1 : eindx_2 + 1, :)];
