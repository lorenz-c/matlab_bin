function [eofs, pcs, lams, varargout] = eof_ana(inpt, varargin);
% The function computes the Empirical orthagonal functions, principal
% components and the eigenvalues for a set of input fields.
%--------------------------------------------------------------------------
% Input (mandatory):
% - inpt  {m x 1}      Cell array which contains the input fields. 
% 
% Input (optional):
% - theta [i x 1]      Vector containing the latitudes of the elements of
%                      the input fields. Theta is only needed if areawghts 
%                      is set to true
%                      Default: (89.75:-0.5:-89.75)'
%
% - miss  [1 x 1]      Scalar (or NaN) representing missing values in the
%                      input fields. The parameter is only needed if 
%                      cntsmiss is set to true.
%                      Default: -9999 
%
% - mask  [i x j]      Optional binary map which can be applied to perform 
%                      a domain selection. The map must have the same
%                      dimensions as the input fields and its elements must
%                      be either 0 or 1.
%
% - mxmde [1 x 1]      Highest mode of the singular value decomposition. 
%                      Set to 0 if the highest mode should be determined 
%                      from the data. 
%                      Default: 0
%
% - rec_eofs (logical) If set to true, the function will compute maps of 
%                      the eigenvectors (the EOFs) and reconstruct the data 
%                      from the PCs and the EOFs.
%                      Default: true
%
% - addmn   (logical)  By default, the input data is centralized before the
%                      computation of the EOFs. To better compare the
%                      reconstructed data with the input fields, the mean
%                      can be added back to the maps.
%                      Default: true
%
% - remmn   (logical)  Prior to the computation of the EOFs, the temporal
%                      mean should be removed from the input data. In this 
%                      case, the matrix product R = F'*F represents the 
%                      covariance matrix of the input data.
%                      Default: true
% 
% - cntsmiss (logical) In some cases, the input dataset contains missing
%                      values. The function removes these values from the 
%                      analysis. By default, it is assumed that missing
%                      elements contain -9999. In any other case, the
%                      parameter miss must be set to the appropriate value.
%                      Default: false
%
% - areawght (logical) In most cases, latitude-dependent area weights (the 
%                      square root of the cosine of the latitude) are
%                      applied to account for meridional convergence, i.e. 
%                      the area of the grid cells decreases towars high 
%                      latitudes. If set to true, the parameter theta must
%                      agree with the latitudes of the input fields.
%                      Default: true
%
% - decompdim (string) The dimension in which the decomposition shall be
%                      performed. By default, the function does a temporal
%                      decomposition.
%                      Default: temp
%
% - pltflg (logical)   If pltflg is set to true, some plots are created
%                      during the EOF-analysis
%
% - nrmflgeof (logical)If normflg is set to true, the EOFs are normalized
%                      so that the length of each vector is 1.
%                      Default: true
%
% - nrmflgdta (logical)If nrmflgdta is set to true, the data is normalized
%                      before the EOF decomosition. In this case, the EOFs 
%                      do not consider the amplitude of the signal but only 
%                      the variability. This helps if the EOFS of different 
%                      quantities (e.g. precipitation and temperature) 
%                      should be compared.
%                      Default: false
% quantitiers
%
% Output:
% - eofs               Matrix which contains the normalized eigenvectors
%                      (i.e. the EOFs of the covariance matrix) where the
%                      kth column contains the EOF of the kth mode.
%
% - pcs                Principal components of the EOFs which account for
%                      their temporal variability. The matrix contains 
%                      time-series for each principal component.
%
% - lams               Eigenvalues of the covariance matrix R = F'*F. The
%                      first column contains the absolute values. The 
%                      second column contains the percentage of the total 
%                      explained variance (i.e. the sum of all eigenvalues) 
%                      while the elements of the third column are the 
%                      cumulative squared covariance fraction. 
%
% - recon              Structure parameter which contains maps of the
%                      eigenvectors and the reconstructed input data from 
%                      the EOFs and the PCs.
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   January 201
%--------------------------------------------------------------------------
% Uses: 
%--------------------------------------------------------------------------
fprintf('------------------------------------------------------------ \n')
fprintf('                      EOF - Analysis                         \n')
fprintf('------------------------------------------------------------ \n')


% -------------------------------------------------------------------------
%               Input checking and setting defalut values
% -------------------------------------------------------------------------

pp = inputParser;
pp.addRequired('inpt', @(x) (iscell(x) | isnumeric(x)));   

pp.addParamValue('theta', (89.75:-0.5:-89.75)', @isnumeric);
pp.addParamValue('miss', -9999, @(x) (isnumeric(x) | strcmp(x, 'NaN')));
pp.addParamValue('mask', [], @isnumeric);
pp.addParamValue('mxmde', 0, @isint);

pp.addParamValue('dorecon', true, @islogical);
pp.addParamValue('addmn', true, @islogical);
pp.addParamValue('remmn', true, @islogical);
pp.addParamValue('cntsmiss', false, @islogical);
pp.addParamValue('areawght', true, @islogical);           
pp.addParamValue('decompdim', 'temp', @ischar);    
pp.addParamValue('nrmflgeof', true, @islogical);
pp.addParamValue('normstd', false, @islogical);
pp.addParamValue('pltflg', false, @islogical);
pp.addParamValue('rotflg', false, @islogical);
pp.addParamValue('maxit', 1000, @isint);
pp.addParamValue('normrot', true, @islogical);
pp.addParamValue('clms', [3 4 8], @isnumeric);
pp.addParamValue('recon_eofs', true, @islogical);
pp.addParamValue('recon_data', true, @islogical);
pp.addParamValue('recon_mode', 0, @isnumeric);
pp.addParamValue('comp_errs', true, @islogical);
pp.addParamValue('corrmps', false, @islogical);
pp.addParamValue('eeof', false, @islogical);
pp.addParamValue('eeof_lags', 0, @isnumeric);
pp.addParamValue('eeof_dt', 0, @isnumeric);

pp.parse(inpt, varargin{:});

areawght   = pp.Results.areawght;
theta      = pp.Results.theta;
miss       = pp.Results.miss;
mask       = pp.Results.mask;
mxmde      = pp.Results.mxmde;
dorecon    = pp.Results.dorecon;
addmn      = pp.Results.addmn;
remmn      = pp.Results.remmn;
cntsmiss   = pp.Results.cntsmiss;
decompdim  = pp.Results.decompdim;
nrmflgeof  = pp.Results.nrmflgeof;
rotflg     = pp.Results.rotflg;
maxit      = pp.Results.maxit;
normrot    = pp.Results.normrot;
normstd    = pp.Results.normstd;
pltflg     = pp.Results.pltflg;
clms       = pp.Results.clms;
recon_eofs = pp.Results.recon_eofs;
recon_data = pp.Results.recon_data;
recon_mode = pp.Results.recon_mode;
comp_errs  = pp.Results.comp_errs;
corrmps    = pp.Results.corrmps;
eeof       = pp.Results.eeof;
eeof_lags  = pp.Results.eeof_lags;
eeof_dt    = pp.Results.eeof_dt;

clear pp


% Get the time information and the cells which contain the data
mnths = cell2mat(inpt(:, clms(1)));
yrs   = cell2mat(inpt(:, clms(2)));
inpt  = inpt(:, clms(3));

% Compute the size of the input fields and the number of available samples
% (i.e. the number of time-steps). It is assumed that the number of
% time-steps corresponds to the number of availab612le fields in the input
% dataset.
[rws, cls] = size(inpt{1});
nts        = length(inpt);


% -------------------------------------------------------------------------
%                      Computation of area weights
% -------------------------------------------------------------------------
% Compute weight factors. In some publications the weight factors are 
% simply the cosines of the latitute. But it is more convenient to use the
% square root of the cosines as this will ensure the correct weighting of
% the covariance matrix, i.e C_w = cos(lat)*F'*F;
if areawght == true
    fprintf('EOF-ana -> Computing the weight factors! \n')
    if size(theta, 2) > size(theta, 1)
        theta = theta';
    end   
    weights = sqrt(cos(theta*pi/180))*ones(1, cls);
else
    weights = ones(rws, cls);
end


% -------------------------------------------------------------------------
%               Domain selection and array re-ordering
% -------------------------------------------------------------------------
% Domain selection with a binary mask. Note that the computation of EOFs
% has a strong domain dependency, i.e the results might differ
% significantly based on the selected domain.
% If no mask is applied, the function generates a mask to account for
% missing elements in the input data, i.e. grid points where no values
% are available
if isempty(mask)
    fprintf('EOF-ana -> No mask is applied! \n')
    mask = ones(rws, cls);
elseif size(mask) == [rws, cls]
    fprintf('EOF-ana -> Applying a binary mask! \n')
else
    warning('Mask does not have the correct input format! \n')
    warning('Skipping the mask! \n')
    mask = ones(rws, cls);
end

if cntsmiss == true 
    fprintf('EOF-ana -> Data contains missing values! \n')
    % If the input data contains missing values, these have to be removed
    % before performing the EOF decomposition
	for i = 1:nts
        mask(inpt{i} == miss) = 0;
	end
end

% Now we have a mask which contains only those elements with which the EOF
% decomposition can be performed
fprintf('EOF-ana -> Rearange the cell-array in a matrix \n')   
[F, c_indx] = cell2catchmat(inpt, mask);

if areawght == true
	fprintf('EOF-ana -> Apply area weights! \n')
	weights = weights(:);
	weights = weights(c_indx);    
% 	F       = F*diag(weights);
    F       = F.*(ones(nts,1)*weights');
    % We do not need the weights any more...
    clear weights
end

if normstd == true
    fprintf('EOF-ana -> Normalize the input matrix by the stds. \n')
    norm_std = std(F);
    F        = F*diag(1./norm_std);
end


 
% % For a spatial decompositon, we transpose the matrix F.
% if strcmp(decompdim, 'spat')
%     fprintf('EOF-ana -> Spatial decompositon! \n')
%     F = F';
% end
% CAN BE COMPUTED LATER!!!!!!!!



% -------------------------------------------------------------------------
%                     Centralize the input dataset
% -------------------------------------------------------------------------
% Removing the sample mean from the data. This ensures that R = F'*F can be
% interpreted as the covariance matrix (which is not done explicitly in
% this function as the SVD-approach is used to compute the EOFs). However,
% the EOFs can be also computed without removing the mean from the data
% (set remmn to false) but the results are more difficult to interpret. 
if remmn == true
    fprintf('EOF-ana -> Removing the mean... \n')
    mn_F = mean(F,1);
    F    = F - ones(nts, 1)*mn_F;
end




if eeof == true
    fprintf('EOF-ana -> Building lagged data matrix! \n')
    npts    = size(F, 2);
    nr_lags = length(eeof_lags);
    F_old   = F;
    F = zeros(nts - eeof_lags(end), nr_lags*npts);
        
    for i = 1:length(eeof_lags)
        indx = (eeof_lags(i)+1:nts-eeof_lags(end)+eeof_lags(i))';
        F(:, (i-1)*npts + 1 : i*npts) = F_old(indx, :);
    end
end
% keyboard
% -------------------------------------------------------------------------
%              Compute EOFs, PCs and eigenvalues through SVD
% -------------------------------------------------------------------------
% Compute left and right singular vecors and the singular values of the
% input data F througth F = U*P*V'
% The right singular vectors V contain the eigenvectors (EOFs) of the
% covariance matrix R = F'*F while the (diagonal) matrix P contains the
% square roots of the eigenvalues of R.
if mxmde == 0 | mxmde == nts
    mxmde = nts;
    [U, P, eofs] = svd(F, 'econ');
elseif mxmde == rws*cls
    [U, P, eofs] = svd(F, 'econ');
else
    [U, P, eofs] = svds(F, mxmde);
end

% Compute the eigenvalues and the fraction of the variance explained
% For the eigenvalues, we have to divide through the sample size (which is
% the number of time-steps). This is due to the fact that the squared
% elements of P are the eigenvalues of the covariance matrix R = F'*F, but
% it is more reasonable to divide the covariance throught the number of
% samples, i.e. R = (1/(N-1))*F'*F.
% The function further computes the squared covariance explained (SCF) and
% the cumulative squared covariance fraction (CSCF) of the covariance 
% matrix R.
lams(:,1) = (1:size(P, 1))';
lams(:,2) = (diag(P).^2)/(size(P,1)-1);                    % Eigenvalues
lams(:,3) = lams(:,2)./sum(lams(:,2))*100;                 % SCF
lams(:,4) = cumsum(lams(:,3))./sum(lams(:,3))*100;         % CSCF

if pltflg == true
    eigplot(P, lams);
end
    



% The EOFs are normalized such that the sum of squares for each EOF pattern 
% equals one. To denormalize the returned EOFs multiply by the square root 
% of the associated eigenvalue.
if nrmflgeof == true
    eofs = eofs./(ones(length(eofs),1)*sum(eofs.^2).^(1/2));
end

% Compute the principal components which are row vectors containing
% time-series for each mode. They are simply the projection of F onto the
% EOF of each mode.

pcs = U*P;

if eeof == true
    if mxmde == nts
        mxmde = size(pcs, 1);
    end
%     keyboard
    nts = size(pcs, 1);
    pcs = [0     0   0                                   (1:mxmde)  ; 
           mnths(1:nts) yrs(1:nts) datenum(yrs(1:nts), mnths(1:nts), ones(nts,1)*15) pcs];
else
	pcs = [0     0   0                   (1:mxmde)  ; 
           mnths yrs datenum(yrs, mnths, ones(nts,1)*15) pcs];
end


% Still under construction.....
% -------------------------------------------------------------------------
%                       Optional: Rotation of EOFs
% -------------------------------------------------------------------------
if rotflg == true
    [pcs(2:end, 4:end), r] = varimax(pcs(2:end, 4:end));   
    eofs                   = eofs*r;
end
    

% -------------------------------------------------------------------------
%             Reconstruction of the EOFs and the input data
% -------------------------------------------------------------------------
% For the spatial representation of the EOFs, the function computes maps
% for each single mode and reconstructs the input data from the EOFs. 
if recon_data == true
    if recon_mode == 0
        recon_mode = mxmde;
    end
    % Each row of F_recon represents the reconstruction (i.e. the map) of
    % the input data from the PCs and the EOFs at one time-step. Thus, the
    % matrix has a total of [nts] rows. 
    fprintf('EOF-ana -> Reconstructing the input data from the truncated set of EOFS ')   
    if eeof == true
        F_recon = recon_eeofs(eofs, pcs(2:end, 4:recon_mode+3), eeof_lags, recon_mode);
%         pcs_md   = [zeros(eeof_lags(end), recon_mode); pcs(2:end, 4:recon_mode+3); zeros(eeof_lags(end), recon_mode)];
%         eofs_md  = zeros(nr_lags*recon_mode, npts);
%         bigmat   = zeros(nts + eeof_lags(end), nr_lags*recon_mode);
% 
%         for i = 1:nr_lags
%             bigmat(:, (i-1)*recon_mode+1:i*recon_mode) = ...
%                 pcs_md(eeof_lags(end)+1-eeof_lags(i):size(pcs_md, 1)-eeof_lags(i), 1:recon_mode);
%             eofs_md((i-1)*recon_mode+1:i*recon_mode, :) = eofs((i-1)*npts+1:i*npts, 1:recon_mode)';
%         end
%         div = zeros(size(bigmat));
%         div(bigmat ~= 0) = 1;
%         div = 1./(sum(div, 2)/recon_mode);
%         F_recon = repmat(div, 1, npts).*(bigmat*eofs_md);
    else
        F_recon = pcs(2:end, 4:recon_mode+3)*eofs(:, 1:recon_mode)';
    end
    
    
    
    
    % To better compare the reconstruced data with the input data, the mean
    % must be added back to the maps. This step also ensures that unwanted
    % elements in the input dataset, i.e. where the binary map contains
    % zeros, are set to NaN in the reconstructed maps.
    if addmn == true   
        F_recon = F_recon + ones(size(F_recon, 1), 1)*mn_F;
    end
    
    % The reconstruction of the input data is performed by reshaping each
    % row of the F_recon matrix to a matrix with [rws, cls] dimensions.
    
    F_recon_map = catchmat2cell(F_recon, c_indx, rws, cls, NaN);    
    F_recon_map = [num2cell(mnths), num2cell(yrs), F_recon_map];
    
    fprintf(' Done! \n')
    varargout{1} = F_recon_map;
    
    if comp_errs == true
        if eeof == true
            F_errs     = F_old - F_recon;
        else
            F_errs         = F - F_recon;
        end
        F_errs_map     = catchmat2cell(F_errs, c_indx, rws, cls, NaN);    
        F_errs_map     = [num2cell(mnths), num2cell(yrs), F_errs_map];
        varargout{2}   = F_errs_map;
    end
    
end
    
if recon_eofs == true
    % The reconstruction of the EOFs is performed by reshaping each
    % row of the eof matrix to a matrix with [rws, cls] dimensions.
    fprintf('EOF-ana -> Remapping of the EOFS to the size of the input')
    if eeof == true
        eofs_mat = eofs;
        clear eofs
        for i = 1:nr_lags
            tmp = catchmat2cell(eofs_mat((i-1)*npts + 1 : i*npts, :)', c_indx, rws, cls, NaN);
            eofs(:, i) = tmp;
            clear tmp
        end
    else
        eofs = catchmat2cell(eofs', c_indx, rws, cls, NaN);
    end
    fprintf(' Done! \n')
end

if corrmps == true
    % Computation of correlation maps between the full input data and the
    % individual PCs
    if eeof == true
        corrs     = corr(F_old(1:end-max(eeof_lags), :), pcs(2:end, 4:end));
    else
        corrs     = corr(F, pcs(2:end, 4:end));
    end
    corrs_map = catchmat2cell(corrs', c_indx, rws, cls, NaN);
    varargout{3} = corrs_map;
end

    
    


    

    
    
 

    





    
    
    
    
    
function [] = eigplot(P, lams);
    mde = 0:size(lams, 1) - 1;
    
    scrsz = get(0,'ScreenSize');
    figure('OuterPosition',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2])
      
    subplot(1,4,1)
    plot(mde, diag(P), 'x', 'linewidth', 1.5);
    title('Singular values')
    xlabel('Mode')
    axis square
    
    subplot(1,4,2)
    plot(mde, lams(:,2), 'x', 'linewidth', 1.5);
    title('Eigenvalues')
    xlabel('Mode')
    axis square
    
    subplot(1,4,3)
    plot(mde, lams(:,3), 'x', 'linewidth', 1.5);
    title('Squared covariance explained')
    xlabel('Mode')
    ylabel('%')
    axis square
    axis([0 max(mde) 0 100])
    
    subplot(1,4,4)
    plot(mde, lams(:,4), 'x', 'linewidth', 1.5);
    title('Squared covariance fraction')
    xlabel('Mode')
    ylabel('%')
    axis square
    axis([0 max(mde) 0 100])
    
    
    
    
    
    
    
    

        








