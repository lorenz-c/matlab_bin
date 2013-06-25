function [klm_f] = reg_flt(klm, P, K, cmpstrct, sig, ccrit, l01rem, pthflnme);

% The function filters a set of colombo ordererd sh-coefficients klm 
% according to the regularization approach with their inverse covariance 
% matrix P and a constraining function K. K can be given as two parameters 
% of a power-law type signal covariance, as a c\s, s|c, row- or column 
% vector or as a full (lmax + 1)^2 x (lmax + 1)^2 matrix. 
% The input data klm and P can be provided through a path and filename
% where the .mat-file are stored. 
%
% The weight factors between the covariance matrix and the signal
% covariance matrix can be provided through the input parameter sig in a 
% column-vector. If this vector is empty, the factors are computed by the
% function itself according to a variance component estimation, which is
% iterated until the convergence criterion ccrit is reached.
%
% The filtered coefficients and their covariance matrix as well as the
% optionally estimated variance components can be stored in an arbitrary
% file, defined through the structure-variable pthflnme. Otherwise, the
% results are copied to the working space.
%
%--------------------------------------------------------------------------
% Input:        klm      unfiltered sh-coefficients in c\s-, s|c-, or 
%                        colombo ordered row- or column-vector format
%                        klm can be a structure variable with the elements
%                        klm.path  -> path where the input data is stored
%                        klm.fname -> filename (without .mat extension) of
%                                     the input data
%
%               P        inverse colombo ordered covariance matrix of the 
%                        input coefficients klm
%                        P can be a structure variable with the elements
%                        P.path  -> path where the covariance matrix is 
%                                   stored
%                        P.fname -> filename (without .mat extension) of
%                                   the input covariance matrix
%
%               K        Vector/matrix which contains either the two 
%                        polynomial coefficients of a fitting power law or 
%                        the coefficients of an arbitrary signal covariance
%                        model in c\s-, s|c-, or colombo ordered row- or 
%                        column-vector format or in a full 
%                        (lmax + 1)^2 x (lmax + 1)^2 matrix. 
%               
%               cmpstrct String-variable which defines the treatment of the 
%                        covariance structure:
%                        - 'full' -> P is assumed as a full covariance 
%                          matrix, all correlations between degrees and 
%                          orders are considered (might take long time for 
%                          computation)
%                        - 'block' -> P is considered as a block-diagonal 
%                          matrix, only correlations between coefficients 
%                          of the same order are considered (default)
%                        - 'diag' -> P is considered as a diagonal           
%                          matrix, no correlations are considered
%
%               sig      Variance components of the inverse covariance
%                        matrix P sig(1,1) and the signal covariance 
%                        K sig(1,2). If sig is an empty array, the variance 
%                        components are computed through a variance 
%                        component estimation by the function itself
%                        (default: sig = [])
%
%               ccrit    The parameter ccrit is the convergence criterion
%                        of the variance component estimation, if no 
%                        variance components are provided 
%                        (default: ccrit = 10^-8)
%
%               l01rem   If GRACE data is used, it is usual to remove the
%                        degree 0,1 coefficients. If one wants to keep
%                        these coefficients, l01rem has to be set to 0
%                        (default: l01rem = 1)
%
%               pthflnme structure variable which defines the path and
%                        filename place where the output data klm_f, Qx, K
%                        and sig should be stored:
%                        pthflnme.path -> path
%                        pthflnme.fname -> filename
%                        if pthflnme is an empty array, the data will be
%                        copiped to the working space             
%
%
% Output:       klm_f    filtered sh-coefficients which are arranged in the 
%                        same format as the input coefficients
%
%               Qx       covariance matrix of the filtered coefficients
%
%               F        matrix with filter coefficients
%
%               sig      variance components of the covariance matrix
%                        (sig(1,1)) and the signal covariance (sig(1,2))
%
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   10.01.2010
%--------------------------------------------------------------------------
% Uses: mod01.m, P_ord2.m, vce.m, chkfrmt.m, plwmtrx.m
%--------------------------------------------------------------------------

% Checking the input arguments and setting the default parameters
if nargin < 8 
    pthflnme = [];
end

if nargin < 7 
	l01rem = 1; 
end

if nargin < 6
    ccrit = 10^-8;
end

if nargin < 5
    sig = [];
end

if nargin < 4 
    cmpstrct = 'block';
end

% Loading the input data, if a filename is provided
if isstruct(klm)
    fname = [klm.path, '/', klm.fname, '.mat'];
    clear klm
    klm = importdata(fname);
    clear fname
end

if isstruct(P)
    fname = [P.path, '/', P.fname, '.mat'];
    clear P 
    P = importdata(fname);
    clear fname
end

% Size of the input data
[rp, cp] = size(P);
[rk, ck] = size(K);
[r, c] = size(klm);

% Checking the input format of the sh-coefficients
[klmfrmt, lmax, klm] = chkfrmt(klm, 'rvec');

% Checking the format of the covariance matrix P,
if strcmp(cmpstrct, 'diag')
    [cvrfrmt, lmx, P] = chkfrmt(P, 'rvec');
    clear lmx
end
% Computing the signal covariance
if size(K) == [1,2] | size(K) == [2,1]
    
    K = plwmtrx(K(1), K(2), lmax, 'vec', 'rms_1');
else
    [tmp1 tmp2 K] = chkfrmt(K, 'rvec');
    clear tmp*
end

if strcmp(cmpstrct, 'full')
    K = diag(K);
end

% Removing the degree 0,1 coefficients from the datasets 
if l01rem == 1
    klm = mod01(klm, 'rem');
    P = mod01(P, 'rem');
    K = mod01(K, 'rem');
end

% If no variance components are provided, the function computes the
% appropriate weight factors itself
if isempty(sig)
    clear sig
    fprintf('Performing VCE... \n \n')
    [vcmpts, sig] = vce(klm, P, K, ccrit, cmpstrct, lmax);
    fprintf('Done! \n \n')
end

fprintf('Filtering the input coefficients.... ')

if strcmp(cmpstrct, 'block')
        
	P_m = P_ord2(P, -1, 'cell');
    K_m = P_ord2(diag(K), -1, 'cell');
    klm_m = P_ord2(diag(klm), -1, 'cell');
    
	Qx{1,1} = inv(1/sig(1)*P_m{1,1} + 1/sig(2)*K_m{1,1});
	Qx{1,2} = zeros(size(Qx{1,1}));
        
	F{1,1}  = Qx{1,1}*1/sig(1)*P_m{1,1};
	F{1,2}  = zeros(size(F{1,1}));
            
	klm_f{1,1} = diag(F{1,1}*diag(klm_m{1,1}));
	klm_f{1,2} = diag(zeros(size(klm_f{1,1})));
            
        
	for m = 1:lmax
        Qx{m+1,1} = inv(1/sig(1)*P_m{m+1,1} + 1/sig(2)*K_m{m+1,1});
        Qx{m+1,2} = inv(1/sig(1)*P_m{m+1,2} + 1/sig(2)*K_m{m+1,2});

        F{m+1,1}  = Qx{m+1,1}*1/sig(1)*P_m{m+1,1};
        F{m+1,2}  = Qx{m+1,2}*1/sig(1)*P_m{m+1,2};
            
        klm_f{m+1,1} = diag(F{m+1,1}*diag(klm_m{m+1,1}));
        klm_f{m+1,2} = diag(F{m+1,2}*diag(klm_m{m+1,2}));
    end
        
	Qx    = blkdiag(Qx{:,1}, Qx{2:end,2});
	F     = blkdiag(F{:,1}, F{2:end,2});
	klm_f = diag(blkdiag(klm_f{:,1}, klm_f{2:end,2}));
        
elseif strcmp(cmpstrct, 'diag')
	
	Qx    = 1./(1/sig(1)*P + 1/sig(2)*K);
	F     = Qx*1/sig(1).*P;
	klm_f = F.*klm;
        
elseif strcmp(cmpstrct, 'full')
        
	Qx = inv(1/sig(1)*P + 1/sig(2)*K);
	F  = Qx*1/sig(1)*P;
	klm_f = F*klm;
    
end

% If degree 0,1 coefficients were removed, they will be added here again as
% zeros
if l01rem == 1
    klm_f = mod01(klm_f, 'add');
    Qx = mod01(Qx, 'add');
    F = mod01(F, 'add');
end

% If only variances were considered, the resulting errors and filter
% coefficients are arranged in the same format as the sh-coefficients
if strcmp(cmpstrct, 'diag')
    [tmp1, tmp2, Qx] = chkfrmt(Qx, klmfrmt);
    [tmp1, tmp2, F]  = chkfrmt(F,  klmfrmt);
end

% Rearranging the filtered sh-coefficients in the input format
if strcmp(klmfrmt, 'rvec') == 0
    [frmt lmx klm_f] = chkfrmt(klm_f, klmfrmt);
end

fprintf('Done! \n')

% If no specific output path and filename were provided, the output data is
% copied to the workspace for further computations
if isempty(pthflnme)
    assignin('base', 'Qx', Qx);
    assignin('base', 'F',  F);
    assignin('base', 'sig', sig);
else
    fnamef = [pthflnme.path, '/', pthflnme.fname];
    save(fnamef, 'klm_f', 'Qx', 'F');
end





    






    
