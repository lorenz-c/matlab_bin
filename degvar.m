function dv = degvar(spctrm,maxdeg,cum,fstr,h,cap,type)

% DEGVAR(SPCTRM,MAXDEG) computes the root-mean-squared error of the degree-
% variances.
%
% dv = degvar(spctrm,maxdeg)
% dv = degvar(spctrm,maxdeg,cum,fstr,h,cap,type)
%
% INPUT
% spctrm    -   Co-efficients of the spectral field given in sc- or
%               cs-formats or in [l m Clm Slm] format.
% maxdeg    -   Maximum degree of the co-efficients.
% cum       -   Cumulative degree variances are computed if cum=1, else
%               degree variances are alone calculated.
% fstr      -   String that defines the quantity to be calculated.
%               'none' - dimensionless, 'geoid' [m], 'smd' [kg/m^2],
%               'water' [m], 'potential' [m^2/s^2], 'dg' or 'gravity'
%               (gravity anomalies), 'tr' (gravity disturbances),'trr'
%               (d^2/dr^2), 'slope' (slope of the surface gradient).
%               def - ['none']
% h         -   height of the point of evaluation [m]
% cap       -   Smoothing radius Pellinen <= 90[deg], Gaussian >= 100[km].
% type      -   'champ', 'grace', 'normal'
%
% OUTPUT
% dv        -   Degree variances (power spectrum) of the spectral field.
%--------------------------------------------------------------------------

% Created on 29 May 2007
% Modified on 9 January 2009
%   added additional inputs for applying isotf function
%   removed for loops
% Author: Balaji Devaraju, Stuttgart
%--------------------------------------------------------------------------

% dv = [(0:maxdeg)',zeros(maxdeg+1,1)];
[rows, cols] = size(spctrm);

if cols == 4 || ((2*rows - 1) == cols) || (rows == cols)

    if nargin == 2
        cum = 0;
        fstr = 'none';
        h = 0;
        cap = 0;
        type = 'none';
    elseif nargin == 3
        fstr = 'none';
        h = 0;
        cap = 0;
        type = 'none';
    elseif nargin == 4
        h = 0;
        cap = 0;
        type = 'none';
    elseif nargin == 5
        cap = 0;
        type = 'none';
    elseif nargin == 6
        type = 'none';
    end

    cum = logical(cum);


    if cols == 4
        if length(spctrm) == sum(1:maxdeg+1)
            spctrm = sc2cs(gcoef2sc(cssc2clm(spctrm,120)));
        else
            error('Incomplete set of co-efficients')
        end
    elseif (2*rows-1 == cols)
        spctrm = sc2cs(spctrm);
    end

    if size(spctrm,1) == size(spctrm,2)
        dv = tril(spctrm);
        spctrm = spctrm - dv;
        dv = (sum(dv'.^2) + sum(spctrm.^2))';
        if nargin > 3
            dv = dv.*(isotf((0:maxdeg)',fstr,h,cap,type)).^2;
        end
        if cum
            dv = cumsum(dv);
        end
        dv = [(0:maxdeg)' dv];
    end
else
    error('The format is not compatible with the function')
end
