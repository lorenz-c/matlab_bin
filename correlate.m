function [c,cfb,icfb,pc,pcfb,ipcfb] = correlate(in1,in2,maxlag,typ,pord,damp,flag)

% CORRELATE calculates the cross-covariance or correlation between two
% input signals. Auto-correlation is handled as a special case of a single
% input. The calculation is similar to XCORR but this one is able to handle
% data gaps. 
%
% The two input vectors can have different length. The shorter one is
% zero-padded to the length of the longer one.
%
% For auto correlation/covariance use either the same input twice or call
% the function with an emtpy matrix for the second input signal. 
% 
% How:    [c,cfb,icfb,pc,pcfb,ipcfb] = correlate(in1,in2,maxlag,typ,pord,damp,flag)
% 
% Input:  in1    [n,1]  input signal 1
%         in2    [m,1]  input signal 2
%         maxlag [1,1]  maximum lag 
%         typ    [str]  'biased'   - output is (biased) covariance 
%                       'unbiased' - output is (unbiased) covariance 
%                       'corr'     - output is the (biased) correlation (default)
%                       'unbcorr'  - output is the (unbiased) correlation
%         pord   [1,1]  maximum lag for partial autocovariance
%         damp   [1,1]  damping factor for autocorrelation
%         flag   [1,1]  flag for substraction of the mean (def:=true)
%
% Output: out    [k,1]  coefficients (k = max(n,m))
%
% Weigelt, GI Stuttgart                                            27.04.11


%% Input Check
error(nargchk(1,7,nargin))
if ~isvector(in1), error('Input 1 must be a vector');          end
if nargin < 7 || isempty(flag),   flag   = true;               end
if nargin < 6 || isempty(damp),   damp   = [];                 end
if nargin < 5 || isempty(pord),   pord   = [];                 end
if nargin < 4 || isempty(typ),    typ    = 'corr';             end
if nargin < 3 || isempty(maxlag), maxlag = fix(numel(in1)/10); end
if nargin < 2 || isempty(in2),    in2    = in1;                end
if ~isvector(in2), error('Input 2 must be a vector');          end

%% Preparation
if isempty(maxlag), 
    maxlag = numel(in1); 
elseif maxlag > numel(in1)
    warning('Matlab:Correlate:MaxLagToBig','MAXLAG is larger than the number of elements. It is reduced to the latter.')
    maxlag = numel(in1);
end

% Substract the mean before we do anything
in1 = in1(:);
in2 = in2(:);
if flag,
    %detrend the data with a robustfit: dataset 1
    ti  = (1:size(in1,1))';
    b   = robustfit(ti,in1);
    in1 = in1 - (b(1) + b(2).*ti);
    %detrend the data with a robustfit: dataset 2
    ti  = (1:size(in2,1))';
    b   = robustfit(ti,in2);
    in2 = in2 - (b(1) + b(2).*ti);
    clear b ti
end

%% Calculation of the autocovariance function
log_in1 = double(~isnan(in1)); in1(isnan(in1)) = 0;
log_in2 = double(~isnan(in2)); in2(isnan(in2)) = 0;
Sout = xcorr(in1,in2,maxlag);                 
Sout = Sout(maxlag+1:end-1);
if strcmp(typ,'biased')
    c    = Sout./numel(in1);
elseif strcmp(typ,'unbiased')
    Nout = round(xcorr(log_in1,log_in2,maxlag));  
    Nout = Nout(maxlag+1:end-1);        
    c    = Sout./Nout;
elseif strcmp(typ,'corr'),  
    c    = Sout./numel(in1);
    c    = c./c(1);
elseif strcmp(typ,'unbcorr'),  
    Nout = round(xcorr(log_in1,log_in2,maxlag));  
    Nout = Nout(maxlag+1:end-1);        
    c    = Sout./Nout;
    c    = c./c(1);
end
if ~isempty(damp)
    gwin = gausswin(2*numel(c)-1,damp);
    c    = c.*gwin(numel(c):end);
end
cfb  = c(1).*1.96/sqrt(numel(in1));
icfb = 1:find(abs(c) > cfb,1,'last');

%% Calculation of the partial autocovariance
if nargout > 3,
    if isempty(pord),
        pord = maxlag - 1;
    elseif pord > maxlag,
        warning('Matlab:Correlate:PordToBig','PORD cannot be larger than maxlag. It is reduced to the latter.')
        pord = maxlag - 1;
    end
    pc    = zeros(pord,1);
    acf   = c./c(1);
    pc(1) = c(1);
    for idx = 2:pord+1
        r    = c(2:idx);
        col  = acf(1:idx-1);
        R    = toeplitz(col,col');
        hpc  = R\r;
        pc(idx) = hpc(end);
    end
    if ~isempty(damp)
        gwin = gausswin(2*numel(pc)-1,damp);
        pc    = pc.*gwin(numel(pc):end);
    end
    pcfb  = pc(1).*1.96/sqrt(numel(in1));
    ipcfb = 1:find(abs(pc) > pcfb,1,'last');
end




%% ------------------------------------------------------------------------
% uses 
% m-files: 
%
% revision history
%
% remarks
