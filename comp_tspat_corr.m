function R = comp_tspat_corr(fld1, fld2, mval)


    n = length(fld1)

    [r1, c1] = size(fld1{1});
    [r2, c2] = size(fld2{1});
    
    
if r1 ~= r2 | c1 ~= c2
    error('Input fields must have the same the same length')
end


    



% R = NaN(r1);

mn_1  = zeros(r1, c1);
mn_2  = zeros(r1, c1);
sig_1 = zeros(r1, c1);
sig_2 = zeros(r1, c1);
nom   = zeros(r1, c1);

for k = 1:n
    mn_1 = mn_1 + fld1{k};
    mn_2 = mn_2 + fld2{k};            
end
        
mn_1 = mn_1/n;
mn_2 = mn_2/n;
% keyboard       
for k = 1:n
    sig_1 = sig_1 + (fld1{k} - mn_1).^2;
    sig_2 = sig_2 + (fld2{k} - mn_2).^2;
                
	nom = nom + (fld1{k} - mn_1).*(fld2{k} - mn_2);
end

sig_1 = sqrt(sig_1);
sig_2 = sqrt(sig_2);
   
% nom = nom;
% keyboard
R = nom./(sig_1.*sig_2);


        
            
        
%             tmp_1 = shiftdim(fld1_new(i,j,:));
%             tmp_2 = shiftdim(fld2_new(i,j,:));
        
%         mn_1  = mean(tmp_1);
%         mn_2  = mean(tmp_2);
%         
%         sig_1 = std(tmp_1);
%         sig_2 = std(tmp_2);
        
%         if abs(sig_1) < 1e-5
%             sig_1 = 1e-10;
%         end
%         
%         if abs(sig_2) < 1e-5
%             sig_2 = 1e-10;
%         end
%         
%         if abs(mn_1) < 1e-5
%             mn_1 = 1e-10;
%         end
%         
%         if abs(mn_2) < 1e-5
% %             mn_2 = 1e-10;
% %         end
% 
%         R(i,j) = 1/n*((tmp_1 - mn_1)'*(tmp_2 - mn_2))/(sig_1*sig_2);
% 
%     end
% end
%         
        
