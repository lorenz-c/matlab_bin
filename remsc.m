function [Res, SC] = remsc(inpt, clms)
% The function computes and removes the seasonal cycle from the input
% time-series
if isnumeric(inpt)
    SC = tsmean(inpt, 'monthly', 'clms', clms);

    nyrs = (length(inpt)-1)/12;

% keyboard
    Res = inpt;
    Res(2:end, clms(3):end) = inpt(2:end, clms(3):end) - repmat(SC(2:end, 2:end), nyrs, 1);

elseif iscell(inpt)
    if nargin < 2
        clms = [3 4 8];
    end
    
    SC   = spatmn(inpt, [inpt{1,clms(2)} inpt{end,clms(2)}], 'monthly', clms);
    nyrs = length(inpt)/12;
    Res  = inpt;

    for i = 1:length(inpt)
        Res{i,clms(3)} = Res{i,clms(3)} - SC{Res{i,clms(1)}};
    end
    
end
