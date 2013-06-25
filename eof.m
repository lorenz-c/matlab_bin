function [eofs, pcs, lams, recon] = eof_ana(inpt, varargin);



pp = inputParser;
pp.addRequired('inpt', @(x) (iscell(x) | isnumeric(x)));   

pp.addParamValue('weightflg', true, @islogical);                   
pp.addParamValue('theta', (89.75:-0.5:-89.75)', @isnumeric);
pp.addParamValue('dlambda', 0.5, @isnumeric);
pp.addParamValue('clms', [4 5 9], @isnumeric);              
pp.addParamValue('miss', -9999, @(x) (isnumeric(x) | strcmp(x, 'NaN')));
pp.addParamValue('mask', 0, @isnumeric);
pp.addParamValue('mxmde', 0, @isint);
pp.addParamValue('dorecon', true, @islogical);
pp.addParamValue('addmn', true, @islogical);
pp.addParamValue('containsmiss', false, @islogical);

pp.parse(inpt, varargin{:});

weightflg = pp.Results.theta;
theta     = pp.Results.theta;
dlambda   = pp.Results.dlambda;
clms      = pp.Results.clms;
miss      = pp.Results.miss;
mask      = pp.Results.mask;
mxmde     = pp.Results.mxmde;
dorecon   = pp.Results.dorecon;
addmn     = pp.Results.addmn;
containsmiss = pp.Results.containsmiss;
[rws, cls] = size(inpt{1, clms(3)});

% Compute weight factors (cos(theta)). 
if weightflg == true
    if size(theta, 2) > size(theta, 1)
        theta = theta';
    end   
    weights = cos(theta*pi/180)*ones(1, cls);
else
    weights = ones(rws, cls);
end


    
% Domain selection with a binary mask
if size(mask) == [1 1]
    if containsmiss == true 
        
        mask = ones(360, 720);
        mask(inpt{1, clms(3)} == miss) = 0;
        mask_vec = mask(:);
        c_indx   = find(mask_vec == 1);
        
        for i = 1:size(inpt, 1)
            tmp = inpt{i, clms(3)}.*weights;
            F(i,:) = tmp(mask == 1)';
        end
        
    else
        for i = 1:size(inpt, 1)
            tmp = inpt{i, clms(3)}.*weights;
            F(i,:) = tmp(:)';
        end
        c_indx   = ones(rws*cls,1);
    end
elseif size(mask) == [rws, cls]
    
    if containsmiss == true 
        mask(inpt{1, clms(3)} == miss) = 0;
    end
	mask_vec = mask(:);
	c_indx   = find(mask_vec == 1);

    for i = 1:size(inpt, 1)
        tmp = inpt{i, clms(3)}.*weights;
    	F(i,:) = tmp(mask == 1)';
    end
end

[n, p] = size(F);


% Removing the mean from the data
mn_F    = mean(F,1);
F_prime = F - ones(n, 1)*mn_F;

% Eigenvectors and eigenvalues of the covariance matrix R = F'*F
if mxmde == 0 | mxmde == p
    [U, P, eofs] = svd(F);
else
    [U, P, eofs] = svds(F, mxmde);
end

% Compute the eigenvalues and the fraction of the variance explained
lams(:,1) = diag(P).^2;
lams(:,2) = lams*100/sum(lams);

% Compute the principal components
pcs = F_prime*eofs;
pcs = [cell2mat(inpt(:, clms(1))) cell2mat(inpt(:, clms(2))) pcs];

% Compute the map for the eofs and reconstruct the data
if dorecon == true
 
    for i = 1:size(eofs,2)
        tmp           = zeros(rws*cls, 1)*NaN;
        tmp(c_indx,1) = eofs(:,i);
        
        recon.eofs{i,1} = reshape(tmp, rws, cls);
    end
    
    
    F_recon = pcs(:, 3:end)*eofs';
    
    mn_fld = zeros(rws*cls, 1)*NaN;
    if addmn == true   
        mn_fld(c_indx,1) = mn_F(:);
    end
    
    for i = 1:size(F_recon, 1)
        tmp = zeros(rws*cls, 1)*NaN;
        tmp(c_indx, 1) = F_recon(i,:)';
        
        recon.F{i,1} = inpt{i, clms(1)};
        recon.F{i,2} = inpt{i, clms(2)};
        recon.F{i,3} = reshape(tmp + mn_fld, rws, cls);
    end
else
    recon = 0;
end


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

        








