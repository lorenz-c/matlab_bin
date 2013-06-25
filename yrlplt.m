function yrlplt(inpt, ts_clm, mnth_clm, yr_clm, strt_rw, nme)

mnth = inpt(strt_rw:end,mnth_clm);
yr   = inpt(strt_rw:end,yr_clm);

for i = 1:length(ts_clm)
    ts(:,i) = inpt(strt_rw:end,ts_clm);
end



