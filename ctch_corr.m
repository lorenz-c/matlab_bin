function otpt = ctch_corr(corr, catch_indx, indexfle)

otpt = zeros(360,720);

for i = 1:length(catch_indx)
    otpt(indexfle == catch_indx(i)) = corr(i);
end
