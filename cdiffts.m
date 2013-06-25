function ddt = cdiffts(inpt, tsrs, varargin)

pp = inputParser;
pp.addRequired('inpt', @ismatrix);                % Input dataset (cell)
pp.addRequired('tsrs', @isvector);                % Id_map (matrix)
pp.addParamValue('dt', 1, @isnumeric);
pp.addParamValue('clms', [1 2 3], @isnumeric);    % Columns with m/y/dta

pp.parse(inpt, tsrs, varargin{:})

clms = pp.Results.clms;
dt   = pp.Results.dt;

sind = find(inpt(:,1) == tsrs(1) & inpt(:,2) == tsrs(2));
eind = find(inpt(:,1) == tsrs(3) & inpt(:,2) == tsrs(4));

n_ts = size(inpt,1);



if sind > 1 && eind < n_ts
    bw = inpt(sind-1:eind-1,clms(3):end);
    fw = inpt(sind+1:eind+1,clms(3):end);
    ddt = zeros(size(bw,1), size(bw,2)+2);

    ddt(:,1) = inpt(sind:eind, clms(1));
    ddt(:,2) = inpt(sind:eind, clms(2));
    ddt(:, 3:end) = (fw(:,:) - bw)/dt;
end