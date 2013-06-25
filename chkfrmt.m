function [frmt, lmx, otpt] = chkfrmt(inp, otptfrmt)

% The function checks the format of the sh-input data inp, which can be a
% vector or a matrix. If the argument otptfrmt is given, the input data is
% rearranged in the specified output format
%--------------------------------------------------------------------------
% Input:   inp          matrix in c\s or s|c format or colombo ordered 
%                       vector with sh-coefficients
%          otptfrmt     desired output format of the input coefficients:
%                       - 'cs' -> inp is rearranged to the c\s format
%                       - 'sc' -> inp is rearranged to the s|c format
%                       - 'rvec' -> inp is rearranged to a colombo ordered 
%                                   row-vector
%                       - 'cvec' -> inp is rearranged to a colombo ordered 
%                                   column-vector
%                       - 'fmat' -> inp is a full (lmx+1)²+(lmx+1)² matrix
%                       if otptfrmt is not defined, the output format
%                       will be the same as the format of the input data
%
% Output   frmt         format of the input data 
%                       - 'cs' -> inp is in c\s format
%                       - 'sc' -> inp is in s|c format
%                       - 'rvec' -> inp is a colombo ordered row-vector
%                       - 'cvec' -> inp is a colombo ordered column-vector
%
%          lmx          maximal degree of expansion of the input data
%
%          otpt         optional output data, which was rearranged
%                       according to the parameter otptfrmt
%                       
%--------------------------------------------------------------------------
% Author: Christof Lorenz
% Date:   10.01.2010
%--------------------------------------------------------------------------
% Uses: sc2cs.m, cs2sc.m, sh_sort.m, mat2vec.m
%--------------------------------------------------------------------------
[r, c] = size(inp);

if r == c && r <= 120
    % inp is in c\s format
    frmt = 'cs';
    lmx  = r - 1;
elseif r > 1 && c == 1 
    % inp is a row-vector
    frmt = 'rvec';
    lmx  = sqrt(r) - 1; 
elseif r == 1 && c > 1
    % inp is a column-vector
    frmt = 'cvec';
    lmx  = sqrt(c) - 1;
elseif c == 2*r - 1
    % inp is in s|c format
    frmt = 'sc';
    lmx  = r - 1;
elseif r == c && r > 120
    % inp is a full (lmx+1)²+(lmx+1)² matrix
    frmt = 'fmat';
    lmx  = sqrt(r) - 1;
else
    error('Input data has unknown format!')
end

if nargin < 2
    otptfrmt = frmt;
end

if nargout > 2
    
    if strcmp(otptfrmt,frmt)
        otpt = inp;
        
    % Output format: c\s
    elseif strcmp(otptfrmt, 'cs') 
        
        if strcmp(frmt, 'sc')
            otpt = sc2cs(inp);
        elseif strcmp(frmt, 'rvec')
            otpt = sh_sort(inp, 'cs');
        elseif strcmp(frmt, 'cvec')
            otpt = inp';
            otpt = sh_sort(otpt, 'cs');
        elseif strcmp(frmt, 'fmat')
            otpt = sh_sort(diag(inp), 'cs');
        end
        
    % Output format: row-vector   
    elseif strcmp(otptfrmt, 'rvec') 
        
        if strcmp(frmt, 'cs')  
            otpt = mat2vec(inp);
        elseif strcmp(frmt, 'sc')   
            otpt = sc2cs(inp);
            otpt = mat2vec(otpt);
        elseif strcmp(frmt, 'cvec')  
            otpt = inp';
        elseif strcmp(frmt, 'fmat')
            otpt = diag(inp);
        end
        
    % Output format: column-vector     
    elseif strcmp(otptfrmt, 'cvec') 
        
        if strcmp(frmt, 'cs')  
            otpt = mat2vec(inp);
            otpt = otpt';
        elseif strcmp(frmt, 'sc')   
            otpt = sc2cs(inp);
            otpt = mat2vec(otpt);
            otpt = otpt';
        elseif strcmp(frmt, 'rvec')  
            otpt = inp';
        elseif strcmp(frmt, 'fmat')
            otpt = diag(inp)';
        end
        
    % Output format: s|c-format      
    elseif strcmp(otptfrmt, 'sc') 
        
        if strcmp(frmt, 'cs')
            otpt = cs2sc(inp, 0);
        elseif strcmp(frmt, 'rvec')
            otpt = sh_sort(inp, 'sc');
        elseif strcmp(frmt, 'cvec')
            otpt = sh_sort(inp', 'sc');
        elseif strcmp(frmt, 'fmat')
            otpt = sh_sort(diag(inp), 'sc');
        end
    % Output format: full matrix
    elseif strcmp(otptfrmt, 'fmat')
        if strcmp(frmt, 'cs')
            otpt = diag(mat2vec(inp));
        elseif strcmp(frmt, 'rvec') || strcmp(frmt, 'cvec')
            otpt = diag(inp);
        elseif strcmp(frmt, 'sc')
            otpt = diag(mat2vec(sc2cs(inp)));
        end
        
    end
end
    
    