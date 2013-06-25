function [tot_ref, tot_obs] = glob_stats(ref_field, mval, varargin)

theta = (0.25:0.5:179.75)';

A = area_wghts(theta, 0.5)
A = A*ones(1,720);


for i = 1:length(ref_field)
    % This step ensures that both the ref_field and obs_field are converted
    % to vectors of the same length
    tmp_ref = ref_field{i}(ref_field{i}~=mval);
    tmp_A   = A(ref_field{i}~=mval);
    A_tot   = sum(tmp_A);
    wt_ref  = tmp_A.*tmp_ref/A_tot;
    tot_ref(i,1) = sum(wt_ref);
    for k = 1:length(varargin)
        tmp_obs(:,k) = varargin{k}{i}(ref_field{i}~=mval);
        wt_obs  = tmp_A.*tmp_obs(:,k)/A_tot;
        tot_obs(i,k) = sum(wt_obs);
    end
    
%     keyboard
    
    
%     keyboard
    
    
    
    
    
end

% [R E sig] = taylor_stats(tot_ref, tot_obs);


    
    
    
    
    
    
    
    
    
    


