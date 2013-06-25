function Q = iqrts(inpt, clms)

if nargin < 3, clms = [1 2 3];    end


Q(:, 1:2) = [inpt(:, clms(1)) inpt(:, clms(2))];
Q(:, 3)   = datenum(Q(:,2), Q(:,1), 15);
Q(:, 4)   = iqr(inpt(:, clms(3):end), 2);



    