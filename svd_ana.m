function [eofs, ecof, lams, recon] = svd_ana(inpt1, inpt2, varargin);



pp = inputParser;
pp.addRequired('inpt1', @(x) (iscell(x) | isnumeric(x)));   
pp.addRequired('inpt2', @(x) (iscell(x) | isnumeric(x)));   

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

pp.parse(inpt1, inpt2, varargin{:});

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

[rws, cls] = size(inpt1{1, clms(3)});

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
        mask(inpt1{1, clms(3)} == miss) = 0;
        mask(inpt2{1, clms(3)} == miss) = 0;
        mask_vec = mask(:);
        c_indx   = find(mask_vec == 1);
        
        for i = 1:size(inpt, 1)
            tmp1 = inpt1{i, clms(3)}.*weights;
            tmp2 = inpt2{i, clms(3)}.*weights;
            F1(i,:) = tmp1(mask == 1)';
            F2(i,:) = tmp2(mask == 1)';
        end
        
    else
        for i = 1:size(inpt, 1)
            tmp1 = inpt1{i, clms(3)}.*weights;
            F1(i,:) = tmp1(:)';
            F2(i,:) = tmp2(:)';
        end
        c_indx   = ones(rws*cls,1);
    end
elseif size(mask) == [rws, cls]
    
    if containsmiss == true 
        mask(inpt1{1, clms(3)} == miss) = 0;
        mask(inpt2{1, clms(3)} == miss) = 0;
    end
	mask_vec = mask(:);
	c_indx   = find(mask_vec == 1);

    for i = 1:size(inpt, 1)
        tmp1 = inpt1{i, clms(3)}.*weights;
        tmp2 = inpt2{i, clms(3)}.*weights;
    	F1(i,:) = tmp1(mask == 1)';
        F2(i,:) = tmp2(mask == 1)';
    end
end

[n, p] = size(F1);


% Removing the mean from the data
mn_F1    = mean(F1,1);
mn_F2    = mean(F2,1);

F1_prime = F1 - ones(n, 1)*mn_F1;
F2_prime = F2 - ones(n, 1)*mn_F2;


% Compute the covariance matrix between inpt1 and inpt2
C = F1_prime'*F2_prime;

% Eigenvectors and eigenvalues of the covariance matrix R = F'*F
if mxmde == 0 | mxmde == p
    [U, P, eofs] = svd(C);
else
    [U, P, eofs] = svds(C, mxmde);
end

% Calculate the expansion coefficients
ecof1 = F1_prime*U;
ecof2 = F2_prime*V;

ecof1 = [cell2mat(inpt1(:, clms(1))) cell2mat1(inpt(:, clms(2))) ecof1];
ecof2 = [cell2mat(inpt2(:, clms(1))) cell2mat2(inpt(:, clms(2))) ecof2];

% Compute the squared covariance fraction
scf(:,1) = diag(P);
scf(:,2) = scf(:,1)*100./sum(scf(:,1));

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


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

        








