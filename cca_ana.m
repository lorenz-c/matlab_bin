function [eofs, pcs, lams, recon] = eof_ana(inpt1, inpt2, varargin);
% The function computes the Empirical orthagonal functions, principal
% components and the eigenvalues for a set of input fields.
%--------------------------------------------------------------------------
% Input (mandatory):
% - inpt1  {m x 1}      Cell arrays which contains the input fields. 
%   inpt2  {n x 1}
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
% - dorecon (logical)  If set to true, the function will compute maps of 
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
pp.addParamValue('mask', 0, @isnumeric);
pp.addParamValue('mxmde', 0, @isint);

pp.addParamValue('dorecon', true, @islogical);
pp.addParamValue('addmn', true, @islogical);
pp.addParamValue('remmn', true, @islogical);
pp.addParamValue('cntsmiss', false, @islogical);
pp.addParamValue('areawght', true, @islogical);           
pp.addParamValue('decompdim', 'temp', @ischar);    
pp.addParamValue('nrmflgeof', true, @islogical);
pp.addParamValue('rotflg', 0, @isint);
pp.addParamValue('maxit', 1000, @isint);
pp.addParamValue('normrot', true, @islogical);



pp.parse(inpt, varargin{:});

areawght  = pp.Results.areawght;
theta     = pp.Results.theta;
miss      = pp.Results.miss;
mask      = pp.Results.mask;
mxmde     = pp.Results.mxmde;
dorecon   = pp.Results.dorecon;
addmn     = pp.Results.addmn;
remmn     = pp.Results.remmn;
cntsmiss  = pp.Results.cntsmiss;
decompdim = pp.Results.decompdim;
nrmflgeof = pp.Results.nrmflgeof;
rotflg    = pp.Results.rotflg;
maxit     = pp.Results.maxit;
normrot   = pp.Results.normrot;

clear pp


% Compute the size of the input fields and the number of available samples
% (i.e. the number of time-steps). It is assumed that the number of
% time-steps corresponds to the number of available fields in the input
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
if size(mask) == [1 1]
    fprintf('EOF-ana -> No mask is applied! \n')
    if cntsmiss == true 
        % Create a mask with the same dimensions as the input dataset. In
        % this mask, all elements which are missing in the input data are
        % set to zero. The loop must be evaluated prior to transforming the
        % input cell array to a large data matrix to account for changing
        % positions of the missing values.
        mask = ones(rws, cls);
        for i = 1:nts
            mask(inpt{i} == miss) = 0;
        end
        % Mask_vec is the column vector representing the mask. This is used
        % to determine the index (i.e. the location) of missing values in
        % the input dataset.
        mask_vec = mask(:);
        c_indx   = find(mask_vec == 1);
    
        % The loop weights the input data according to the previously
        % computed weight factors and stores only the elements at the
        % locations where the mask matrix contains ones. 
        fprintf('EOF-ana -> Rearange the cell-array in a matrix! \n')
        for i = 1:nts
            tmp = inpt{i}.*weights;
            F(i,:) = tmp(mask == 1)';
            clear tmp
        end
        
    else
        % No mask is provided and the input data does not contain
        % missing values
        fprintf('EOF-ana -> Rearange the cell-array in a matrix! \n')
        for i = 1:nts
            tmp = inpt{i}.*weights;
            F(i,:) = tmp(:)';
            clear tmp
        end
        % In this case, c_indx is simply a column vector whose elements are
        % all 1.
        c_indx   = (1:rws*cls)';
    end

    
% Apply a binary mask to perform the domain selection 
elseif size(mask) == [rws, cls]
    
    % If the input data contains missing values, these elements are set to
    % zero in the mask
    if cntsmiss == true 
        for i = 1:nts
            mask(inpt{i} == miss) = 0;
        end
    end
    % Mask_vec is the column vector representing the mask. This is used
    % to determine the index (i.e. the location) of missing values in
    % the input dataset.
	mask_vec = mask(:);
	c_indx   = find(mask_vec == 1);

    for i = 1:nts
        tmp = inpt{i}.*weights;
    	F(i,:) = tmp(mask == 1)';
        clear tmp
    end
end

clear weights

if strcmp(decompdim, 'spat')
    F = F';
end

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
Fnew = F;
save Fnew.mat Fnew

% -------------------------------------------------------------------------
%              Compute EOFs, PCs and eigenvalues through SVD
% -------------------------------------------------------------------------
% Compute left and right singular vecors and the singular values of the
% input data F througth F = U*P*V'
% The right singular vectors V contain the eigenvectors (EOFs) of the
% covariance matrix R = F'*F while the (diagonal) matrix P contains the
% square roots of the eigenvalues of R.
if mxmde == 0 | mxmde == nts
    [U, P, eofs] = svd(F, 'econ');
elseif mxmde == rws*cls
    [U, P, eofs] = svd(F);
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
lams(:,1) = (diag(P).^2)/(nts);                          % Eigenvalues
lams(:,2) = (lams(:,1)/sum(lams(:,1)))*100;                % SCF
for i = 1:length(lams)
    lams(i,3) = (sum(lams(1:i,1))/sum(lams(:,1)))*100;     % CSCF
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
pcs = F*eofs;

% Still under construction.....
% -------------------------------------------------------------------------
%                       Optional: Rotation of EOFs
% -------------------------------------------------------------------------
% Rotation of the PCs
% if rotflg == 1 
%     if normrot == true
%         pcs_rt = pcs./(ones(nts,1)*sum(pcs.^2).^(1/2));
%     else
%         pcs_rt = pcs;
%     end
%     
%     TT = eye( nc );
%     d = 0;
% 
%     for i = 1 : maxit
%         z = x * TT;
%         B = x' * ( z.^3 - z * diag(squeeze( ones(1,p) * (z.^2) )) / p );
%   
%         [U,S,V] = svd(B);
%   
%         TT = U * V';
% 
%         d2 = d;
%         d = sum(diag(S));
%   
%         % End if exceeded tolerance.
%         if d < d2 * (1 + tol), break; end
%     end
    
        
        
        
        
    
    


% -------------------------------------------------------------------------
%             Reconstruction of the EOFs and the input data
% -------------------------------------------------------------------------
% For the spatial representation of the EOFs, the function computes maps
% for each single mode and reconstructs the input data from the EOFs. 
if dorecon == true
    % For each mode, a vector with [rws*cls] elements (NaNs) is created.
    % This allows to reshape each EOF mode to the dimensions of the input
    % fields (i.e. the maps).
    for i = 1:size(eofs,2)
        tmp           = zeros(rws*cls, 1)*NaN;
        tmp(c_indx,1) = eofs(:,i);
        recon.eofs{i,1} = reshape(tmp, rws, cls);
        clear tmp
    end
 
    % Each row of F_recon represents the reconstruction (i.e. the map) of
    % the input data from the PCs and the EOFs at one time-step. Thus, the
    % matrix has a total of [nts] rows. 
    F_recon = pcs*eofs';
    
    % To better compare the reconstruced data with the input data, the mean
    % must be added back to the maps. This step also ensures that unwanted
    % elements in the input dataset, i.e. where the binary map contains
    % zeros, are set to NaN in the reconstructed maps.
    mn_fld = zeros(rws*cls, 1)*NaN;
    if addmn == true   
        mn_fld(c_indx,1) = mn_F(:);
    else
        mn_fld(c_indx,1) = 0;
    end
    
    % The reconstruction of the input data is performed by reshaping each
    % row of the F_recon matrix to a matrix with [rws, cls] dimensions.
    for i = 1:size(F_recon, 1)
        tmp = zeros(rws*cls, 1);
        tmp(c_indx, 1) = F_recon(i,:)';    
        recon.F{i} = reshape(tmp + mn_fld, rws, cls);
        clear tmp
    end
    
else
    recon = 0;
end


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

        








