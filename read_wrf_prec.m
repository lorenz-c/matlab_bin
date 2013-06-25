function rain = read_wrf_prec(fnames, rtpe, sm, sy)


for i = 1:length(fnames)-1
    tmp1 = nj_varget(fnames{i},   rtpe, [1, 1, 1], [1 inf inf]);
    tmp2 = nj_varget(fnames{i+1}, rtpe, [1, 1, 1], [1 inf inf]);
    rain{i,1} = sm;
    rain{i,2} = sy;
    rain{i,3} = tmp2 - tmp1;
    
    sm = sm + 1;
    if sm == 13
        sm = 1;
        sy = sy + 1;
    end
  
    
end

tmp1 = nj_varget(fnames{i+1}, rtpe, [1, 1, 1], [1 inf inf]);
tmp2 = nj_varget(fnames{i+1}, rtpe, [inf, 1, 1], [1 inf inf]);

rain{i+1,1} = sm + 1;
rain{i+1,2} = sy + 1;
rain{i+1,3} = tmp2 - tmp1;
