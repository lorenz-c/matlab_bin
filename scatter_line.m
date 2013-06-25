function [] = scatter_line(ref_ts, varargin)



clr = [ 60   60    60;
        050  136  189;
        244  109   67;
        026  152  080;
        240  130   40;
          0  200  200;
        230  220   50;
        160    0  200;
        160  230   50;
          0  160  255;
        240    0  130;
        230  175   45;
          0  210  140;
        130    0  220]/255; 
    
    
    
for i = 1:length(varargin)
	mdl_ts(:, i) = varargin{i};
    
    A = [mdl_ts(:, i) ones(size(mdl_ts,1),1)];
    y = ref_ts;

    A(isnan(y), :) = [];
    y(isnan(y))    = [];
    
    y(isnan(A), :) = [];
    A(isnan(A), :) = [];
   
    xht(:,i) = inv(A'*A)*A'*y;  
        
end


figure;
hold on

for i = 1:size(mdl_ts, 2)
    scatter(mdl_ts(:,i), ref_ts, 50, clr(i,:), 'filled');
    g = refline(xht(:,i));
    set(g, 'Color', clr(i,:));
    set(g, 'Linewidth', 1.5);
   
end
axis equal
    



