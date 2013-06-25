function [dsdt, nanflag] = vimfd_r(vimfd, runoff);

% -------------------------------------------------------------------------
% The function computes the hydrometeorological storage change (i.e.
% vimfd - R of a set of catchments.
% It is assumed that the first two columns of vimfd and runoff contain
% months and years and the first row contains the catchment ids, according
% to which the output dsdt is created
% -------------------------------------------------------------------------
% Input:   vimfd   [i x j]     cell-array which contains month, year,
%                              eastward and northward component of specific 
%                              humidity
%          runoff  [i x k]     column in which the fields of the eastward 
%                              component of specific humidity is stored   
%
% Output:  dsdt    [i x j]     
%                           
% -------------------------------------------------------------------------
% Christof Lorenz, IMK-IFU Garmisch-Partenkirchen
% September 2010
% -------------------------------------------------------------------------
% Uses: 
% -------------------------------------------------------------------------


dsdt(:,1:2) = vimfd(:,1:2);

% nan_msk = zeros(size(vimfd));
% runoff_corr = runoff;

% runoff_corr(isnan(runoff)) = 0;

% dsdt(:,1:2) = vimfd(:,1:2);
k = 1;
for i = 3:size(vimfd,2)
    
    tmp = find(runoff(1,3:end) == vimfd(1,i));
%     keyboard
    if tmp 
        dsdt(1,k+2) = vimfd(1,i);
        dsdt(2:end,k+2) = vimfd(2:end,i) - runoff(2:end,tmp+2);
        k = k + 1;
        
    end
    clear tmp
end
    