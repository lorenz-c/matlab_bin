function [new_fld, n_lon, n_lat, glbl_fld] = wrf2glbl(old_fld, o_lon, o_lat, glbl_fld)


if abs(o_lon(1,1)-fix(o_lon(1,1))) > 0.5
    start_lon = round(o_lon(1,1))-sign(o_lon(1,1))*0.5;
elseif abs(o_lon(1,1)-fix(o_lon(1,1))) < 0.5
    start_lon = fix(o_lon(1,1));
elseif abs(o_lon(1,1)-fix(o_lon(1,1))) == 0.5
    start_lon = o_lon(1,1);
end

if abs(o_lon(1,end)-fix(o_lon(1,end))) > 0.5
    end_lon = round(o_lon(1,end))-sign(o_lon(1,end))*0.5;
elseif abs(o_lon(1,end)-fix(o_lon(1,end))) < 0.5
    end_lon = fix(o_lon(1,end));
elseif abs(o_lon(1,end)-fix(o_lon(1,end))) == 0.5
    end_lon = o_lon(1,1);
end

if abs(o_lat(1,1)-fix(o_lat(1,1))) > 0.5
    end_lat = round(o_lat(1,1))-sign(o_lat(1,1))*0.5;
elseif abs(o_lat(1,1)-fix(o_lat(1,1))) < 0.5
    end_lat = fix(o_lat(1,1));
elseif abs(o_lat(1,1)-fix(o_lat(1,1))) == 0.5
    end_lat = o_lat(1,1);
end

if abs(o_lat(end,1)-fix(o_lat(end,1))) > 0.5
    start_lat = round(o_lat(end,1))-sign(o_lat(end,1))*0.5;
elseif abs(o_lat(end,1)-fix(o_lat(end,1))) < 0.5
    start_lat = fix(o_lat(end,1));
elseif abs(o_lat(end,1)-fix(o_lat(end,1))) == 0.5
    start_lat = o_lat(end,1);
end



lambda = start_lon-0.25*sign(start_lon):0.5:end_lon-0.25*sign(end_lon);
theta  = start_lat-0.25*sign(start_lat):0.5:end_lat-0.25*sign(end_lat);

[n_lon, n_lat] = meshgrid(lambda,flipud(theta));

n_lat = flipud(n_lat);

new_fld = interp2(o_lon, o_lat, old_fld, n_lon, n_lat, 'bicubic');


lambda_glbl = -179.75:0.5:179.75;
theta_glbl  = 89.75:-0.5:-89.75;

u_th = find(theta_glbl == n_lat(1,1));
l_th = find(theta_glbl == n_lat(end,1));

u_la = find(lambda_glbl == n_lon(1,1));
l_la = find(lambda_glbl == n_lon(1,end));

glbl_fld(u_th:l_th, u_la:l_la) = new_fld;








