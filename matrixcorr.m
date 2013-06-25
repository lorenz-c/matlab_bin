function R = matrixcorr(ts1, ts2);

[n, p] = size(ts1);

mn1  = mean(ts1,1);
mn2  = mean(ts2,1);

std1 = std(ts1,1);
std2 = std(ts2,1);

for i = 1:p
    R(1, i) = 1/(n-1)*((ts1(:,i) - mn1(i))'*(ts2(:,i) - mn2(i)))/(std1(i)*std2(i));
end

