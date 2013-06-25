function [R_ja, R_ju, E_ja, E_ju, S_ja, S_ju] = crt_taylorARSCHFOTZE(R_ja, R_ju, E_ja, E_ju, S_ja, S_ju, i, inpt1, inpt2)


[glb_r, glb_e, glb_s] = comp_glob_corr(inpt1, inpt2, [1989 2006], 'monthly_s', 1, [4 5 9], -9999);
R_ja{1}(:,i) = glb_r(1, 2:end)';
R_ju{1}(:,i) = glb_r(7, 2:end)';
E_ja{1}(:,i) = glb_e(1, 2:end)';
E_ju{1}(:,i) = glb_e(7, 2:end)';
S_ja{1}(:,i) = glb_s(1, 2:end)';
S_ju{1}(:,i) = glb_s(7, 2:end)';

[glb_r, glb_e, glb_s] = comp_glob_corr(inpt1, inpt2, [1989 2006], 'monthly_s', 4, [4 5 9], -9999);
R_ja{2}(:,i) = glb_r(1, 2:end)';
R_ju{2}(:,i) = glb_r(7, 2:end)';
E_ja{2}(:,i) = glb_e(1, 2:end)';
E_ju{2}(:,i) = glb_e(7, 2:end)';
S_ja{2}(:,i) = glb_s(1, 2:end)';
S_ju{2}(:,i) = glb_s(7, 2:end)';

[glb_r, glb_e, glb_s] = comp_glob_corr(inpt1, inpt2, [1989 2006], 'monthly_s', 5, [4 5 9], -9999);
R_ja{3}(:,i) = glb_r(1, 2:end)';
R_ju{3}(:,i) = glb_r(7, 2:end)';
E_ja{3}(:,i) = glb_e(1, 2:end)';
E_ju{3}(:,i) = glb_e(7, 2:end)';
S_ja{3}(:,i) = glb_s(1, 2:end)';
S_ju{3}(:,i) = glb_s(7, 2:end)';

[glb_r, glb_e, glb_s] = comp_glob_corr(inpt1, inpt2, [1989 2006], 'monthly_s', 6, [4 5 9], -9999);
R_ja{4}(:,i) = glb_r(1, 2:end)';
R_ju{4}(:,i) = glb_r(7, 2:end)';
E_ja{4}(:,i) = glb_e(1, 2:end)';
E_ju{4}(:,i) = glb_e(7, 2:end)';
S_ja{4}(:,i) = glb_s(1, 2:end)';
S_ju{4}(:,i) = glb_s(7, 2:end)';

[glb_r, glb_e, glb_s] = comp_cont_corr(inpt1, inpt2, [1989 2006], 'monthly_s', 7, [4 5 9], -9999);
R_ja{5}(:,i) = glb_r(1, 2:end)';
R_ju{5}(:,i) = glb_r(7, 2:end)';
E_ja{5}(:,i) = glb_e(1, 2:end)';
E_ju{5}(:,i) = glb_e(7, 2:end)';
S_ja{5}(:,i) = glb_s(1, 2:end)';
S_ju{5}(:,i) = glb_s(7, 2:end)';

[glb_r, glb_e, glb_s] = comp_cont_corr(inpt1, inpt2, [1989 2006], 'monthly_s', 6, [4 5 9], -9999);
R_ja{6}(:,i) = glb_r(1, 2:end)';
R_ju{6}(:,i) = glb_r(7, 2:end)';
E_ja{6}(:,i) = glb_e(1, 2:end)';
E_ju{6}(:,i) = glb_e(7, 2:end)';
S_ja{6}(:,i) = glb_s(1, 2:end)';
S_ju{6}(:,i) = glb_s(7, 2:end)';

[glb_r, glb_e, glb_s] = comp_cont_corr(inpt1, inpt2, [1989 2006], 'monthly_s', 3, [4 5 9], -9999);
R_ja{7}(:,i) = glb_r(1, 2:end)';
R_ju{7}(:,i) = glb_r(7, 2:end)';
E_ja{7}(:,i) = glb_e(1, 2:end)';
E_ju{7}(:,i) = glb_e(7, 2:end)';
S_ja{7}(:,i) = glb_s(1, 2:end)';
S_ju{7}(:,i) = glb_s(7, 2:end)';

[glb_r, glb_e, glb_s] = comp_cont_corr(inpt1, inpt2, [1989 2006], 'monthly_s', 8, [4 5 9], -9999);
R_ja{8}(:,i) = glb_r(1, 2:end)';
R_ju{8}(:,i) = glb_r(7, 2:end)';
E_ja{8}(:,i) = glb_e(1, 2:end)';
E_ju{8}(:,i) = glb_e(7, 2:end)';
S_ja{8}(:,i) = glb_s(1, 2:end)';
S_ju{8}(:,i) = glb_s(7, 2:end)';

[glb_r, glb_e, glb_s] = comp_cont_corr(inpt1, inpt2, [1989 2006], 'monthly_s', 9, [4 5 9], -9999);
R_ja{9}(:,i) = glb_r(1, 2:end)';
R_ju{9}(:,i) = glb_r(7, 2:end)';
E_ja{9}(:,i) = glb_e(1, 2:end)';
E_ju{9}(:,i) = glb_e(7, 2:end)';
S_ja{9}(:,i) = glb_s(1, 2:end)';
S_ju{9}(:,i) = glb_s(7, 2:end)';

[glb_r, glb_e, glb_s] = comp_cont_corr(inpt1, inpt2,  [1989 2006], 'monthly_s', 1, [4 5 9], -9999);
R_ja{10}(:,i) = glb_r(1, 2:end)';
R_ju{10}(:,i) = glb_r(7, 2:end)';
E_ja{10}(:,i) = glb_e(1, 2:end)';
E_ju{10}(:,i) = glb_e(7, 2:end)';
S_ja{10}(:,i) = glb_s(1, 2:end)';
S_ju{10}(:,i) = glb_s(7, 2:end)';