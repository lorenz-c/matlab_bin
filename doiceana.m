function [B, Se, recon_ic, recon_F] = doiceana(inpt, mxmde, mask, theta)
    

if nargin < 4, theta = 89.75:-0.5:-89.75; end
if nargin < 3, mask = ones(size(inpt{1})); end
if nargin < 2, mxmde = length(inpt); end


doeof = input('Perform PCA? Y/N [Y]: ', 's');
if isempty(doeof)
    doeof = 'Y';
end
[rws, cls] = size(inpt{1});


if strcmp(doeof, 'Y')
    fprintf('Performing PCA.....')
    [eofs, pcs, lams, recon_G] = eof_ana(inpt, 'mask', mask, ...
                                               'mxmde', mxmde, ... 
                                               'areawght', false, ... 
                                               'dorecon', false);
    fprintf(' Done! \n')                                       
    showeigs = input('Show eigenvalues? Y/N [Y]: ', 's');
    
    if isempty(showeigs)
        doeof = 'Y';
    end
    
    if strcmp(showeigs, 'Y')
        plot(1:mxmde, lams(:,2));
        xlabel('Mode');
        ylabel('%');
        fprintf('%g \n', lams(:,3))
    end
    
    changemd = input('Change number of modes? Y/N [N]: ', 's');
    if isempty(changemd)
       changemd = 'N';
    end
    
    if strcmp(changemd, 'Y')
        mxmde = input('Enter number of modes: ');
    end
end

[F, c_indx] = cell2catchmat(inpt, mask, theta');

decomp = input('1 for temporal decomposition; 2 for spatial decomposition: ');

if decomp == 1
    
    fprintf('Performing tempora decomposition... ')
    B  = jadeR(F, mxmde, true);
    fprintf('Done! \n')
    fprintf('Computing the source signals... ')
    Se = B * F;
    fprintf('Done! \n')
    
    maprecon = input('Reconstruct maps? Y/N [N]: ', 's');
    if isempty(maprecon)
        maprecon = 'Y';
    end
    
    if strcmp(maprecon, 'Y')
        A = pinv(B);
        recon_ic = catchmat2cell(Se, c_indx, rws, cls);
        recon_F  = catchmat2cell(A*Se, c_indx, rws, cls);
    else
        recon_ic = 0;
        recon_F = 0;
    end
    
    
elseif decomp == 2
    
    fprintf('Performing spatial decomposition... ')
    B = jadeR(F', mxmde, true);
    fprintf('Done! \n')
    fprintf('Computing the source signals... ')
    Se = B * F';
    fprintf('Done! \n')
    
    maprecon = input('Reconstruct maps? Y/N [N]: ', 's');

    if isempty(maprecon)
        maprecon = 'Y';
    end
    
    if strcmp(maprecon, 'Y')
        A = pinv(B);
        recon_ic = catchmat2cell(B, c_indx, rws, cls);
        recon_F  = catchmat2cell((A*Se)', c_indx, rws, cls);
    else
        recon_ic = 0;
        recon_F = 0;
    end
    
end












