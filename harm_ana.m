function [R, Phi] = harm_ana(inpt, thrsh);


nts = length(inpt);
[rws, cls] = size(inpt{1});

for i = 1:nts
    F(i,:) = inpt{i}(:)';
end

mn = mean(F, 1);

F = F - ones(nts, 1)*mn;

t = (0:nts-1)';

A = [ones(nts, 1) t cos(pi/6*t) sin(pi/6*t) cos(pi/3*t) sin(pi/3*t)];

for i = 1:size(F, 2)
	x(:,i) = inv(A'*A)*A'*F(:, i);
end

a1 = x(3,:);
b1 = x(4,:);

a2 = x(5,:);
b2 = x(6,:);

r1(1,:) = sqrt(a1.^2 + b1.^2);
r1(2,:) = r1(1,:).^2/2;
r1(3,:) = r1(1,:).^2./(2*var(F));

r2(1,:) = sqrt(a2.^2 + b2.^2);
r2(2,:) = r2(1,:).^2/2;
r2(3,:) = r2(1,:).^2./(2*var(F));

phi1 = atan2(b1, a1);
phi2 = atan2(b2, a2);

phi1(phi1 < 0) = pi + (pi + phi1(phi1<0));
phi2(phi2 < 0) = pi + (pi + phi2(phi2<0));

phi1 = phi1 + pi/2;
phi1(phi1 > 2*pi) = phi1(phi1 > 2*pi) - 2*pi;

phi2 = phi2 + pi/2;
phi2(phi2 > 2*pi) = phi2(phi2 > 2*pi) - 2*pi;

R{1,1} = reshape(r1(1,:), rws, cls);
R{1,2} = reshape(r1(2,:), rws, cls);
R{1,3} = reshape(r1(3,:), rws, cls);

R{2,1} = reshape(r2(1,:), rws, cls);
R{2,2} = reshape(r2(2,:), rws, cls);
R{2,3} = reshape(r2(3,:), rws, cls);

Phi{1,1} = reshape(phi1, rws, cls);
Phi{2,1} = reshape(phi2, rws, cls);

Phi{1,1}(R{1,3} < thrsh) = NaN;
Phi{2,1}(R{2,3} < thrsh) = NaN;


for i = 1:3
    R{1,i}(R{1,3} < thrsh) = NaN;
    R{2,i}(R{2,3} < thrsh) = NaN;
end
    






    





