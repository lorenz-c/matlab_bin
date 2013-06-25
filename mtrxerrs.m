function errs = mtrxerrs(fld1, fld2, quant, thresh, tscale)

if nargin < 5, tscale = 'monthly'; end
if nargin < 4, thresh = -inf; end
if nargin < 3, quant  = 'rmse'; end


if strcmp(tscale, 'monthly')
    % Select only simultaneous time-steps
    [fld1, fld2] = find_sim_tspts(fld1, fld2);
    
    fld1 = fld1(2:end, 4:end);
    fld2 = fld2(2:end, 4:end);
    
elseif strcmp(tscale, 'mean_monthly')
    
    fld1 = fld1(2:end, 2:end);
    fld2 = fld2(2:end, 2:end);
    
end

fld1(fld1 < thresh) = NaN;
fld2(fld2 < thresh) = NaN;


errs = fld1 - fld2;
nts  = length(fld1(:,1));

switch quant
    
    % 1. Absolute errors
    case 'ae'                           
        errs = abs(errs); 

    % 2. Mean absolute errors                                   
    case 'mae'
        errs = abs(errs);
        errs = nanmean(errs);

    % 3. Squared errors
    case 'se'                           
        errs = errs.^2;

    % 4. Mean Squared errors
    case 'mse'                         
        errs = errs.^2;
        errs = nanmean(errs);

    % 5. Root mean squared errors
    case 'rmse'
        errs = errs.^2;
        errs = nanmean(errs);
        errs = sqrt(errs);
        
    % 6. Relative errors
    case 're'
        errs = errs./fld1;
     
    % 7. Absolute relative errors
    case 'are'
        errs = errs./fld1;    
        errs = abs(errs);
        
    % 8. Mean absolute relative errors
    case 'mare'
        fld1(fld1 == 0) = NaN;
        errs = abs(errs);
        errs = errs./fld1;    
        errs = nanmean(errs);
        
    case 'mare_2'
        errs = abs(errs);
        errs = nanmean(errs);
        errs = errs./(max(fld1) - min(fld1));    

    % 9. Squared relative errors
    case 'sre'
        errs = errs./fld1;
        errs = errs.^2;
        
    % 10. Mean squared relative errors
    case 'msre'
        errs = errs./fld1;
        errs = errs.^2;
        errs = nanmean(errs);
    
    % 11. Root mean squared relative erros
    case 'rmsre'
        errs = errs./fld1;
        errs = errs.^2;
        errs = nanmean(errs);
        errs = sqrt(errs);
        
    % 12. Normalized root mean square deviation
    case 'nrmse'
        errs = errs.^2;
        errs = nanmean(errs);
        errs = sqrt(errs);
        errs = errs./(max(fld1) - min(fld1)); 
        
    % 13. Coefficient of variation of the RMSE
    case 'cvrmse'
        errs = errs.^2;
        errs = nanmean(errs);
        errs = sqrt(errs);
        errs = errs./nanmean(fld1);
        
    case 'cvmae'
        errs = abs(errs);
        errs = nanmean(errs);
        errs = errs./nanmean(fld1);    
        
    % 13. Coefficient of variation of the RMSE
    case 'corr'
        errs = nancorr(fld1, fld2);
        
end




        
