function F_recon = recon_eeofs(eeofs, pcs, lags, recon_mode)

nts = size(pcs, 1) + max(lags);
nr_lags = length(lags);
npts = size(eeofs, 1)/nr_lags;

% keyboard
pcs_md   = [zeros(max(lags), recon_mode); pcs(:, 1:recon_mode); zeros(max(lags), recon_mode)];
eeofs_md = zeros(nr_lags*recon_mode, npts);
bigmat   = zeros(nts, nr_lags*recon_mode);

for i = 1:nr_lags
    bigmat(:, (i-1)*recon_mode+1:i*recon_mode) = ...
        pcs_md(max(lags)+1-lags(i):size(pcs_md, 1)-lags(i), 1:recon_mode);
	eeofs_md((i-1)*recon_mode+1:i*recon_mode, :) = eeofs((i-1)*npts+1:i*npts, 1:recon_mode)';
end

div = zeros(size(bigmat));
div(bigmat ~= 0) = 1;
div = 1./(sum(div, 2)/recon_mode);
F_recon = repmat(div, 1, npts).*(bigmat*eeofs_md);
        
        
        