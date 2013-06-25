function [] = tseval(ref, varargin)
 

miss = -9999;

nr_sets = length(varargin);
nr_tsps = length(ref);

cxis1 = [0 500];
cxis2 = [-50 50];

% Assumption: Reference and the other datasets consist of the same time
% period

% First/second column: Month/year
syr = ref{1,2};
eyr = ref{end,2};

% 0. Apply a mask to all datasets based on the reference
for i = 1:nr_tsps
    for j = 1:nr_sets
    varargin{j}{i,3}(ref{i,3} == miss) = miss;
    end
end


% 1. Compute annual averages, absolute and relative differences
ann_ref = spatmn(ref, [syr eyr], 'annual_1', [1 2 3], -9999, 0);

for i = 1:nr_sets
    ann_evl{i}   = spatmn(varargin{i}, [syr eyr], 'annual_1', [1 2 3], -9999, 0);
    d_ann{i}     = ann_evl{i} - ann_ref;
    d_ann_rel{i} = (d_ann{i}./ann_ref)*100;
end


% 2. Compute climatological monthly means
mnth_ref = spatmn(ref, [syr eyr], 'monthly_1', [1 2 3], -9999, 0);
for i = 1:nr_sets
    mnth_evl(:,i) = spatmn(varargin{i}, [syr eyr], 'monthly_1', [1 2 3], -9999, 0);
end


% 3. Compute spatial correlation maps (STILL TO DO!!!)
% for i = 1:nr_tsps
%     F_ref(i,:) = ref{i}(:);
%     
%     for j = 1:nr_sets
%         F_evl(

% 3. Compute time-series
load indexfile3.asc
load ctchnms.mat

catch_ids   = cell2mat(ctchnms(1:50, 4));
catch_areas = cell2mat(ctchnms(1:50, 2));


ref_ts    = spataggmn(ref, indexfile3, catch_ids, 'clms', [1 2 3]);
ref_ts_mn = [ref_ts(1, 4:end); mean(ref_ts(2:end, 4:end))];

for i = 1:nr_sets
    evl_ts{i}    = spataggmn(varargin{i}, indexfile3, catch_ids, 'clms', [1 2 3]);
    d_ts{i}      = evl_ts{i}(2:end, 4:end) - ref_ts(2:end, 4:end);
    if i == 1
        evl_ts_mn(1:2,:) = [ref_ts(1, 4:end); mean(evl_ts{i}(2:end, 4:end))];
    else
        evl_ts_mn = [evl_ts_mn; mean(evl_ts{i}(2:end, 4:end))];
    end
end

% 3. Compute scatter plots
for i = 1:nr_sets
    [a1(i) b1(i)] = fitline(ref_ts_mn(2,:)', evl_ts_mn(i+1,:)');
end


    
if length(varargin) == 2
    for i = 1:nr_sets
        tmp = matrixcorr(ref_ts(2:end, 4:end), evl_ts{i}(2:end, 4:end));
        R(:,i) = tmp';
    end
    [a2 b2] = fitline(R(:,1), R(:,2));
end
        
    
    




% 4. Create some plots
load coast
theta   = 89.75:-0.5:-89.75;
lambda  = -179.75:0.5:179.75;


figure('Name', 'Annual mean')
for i = 1:nr_sets+1 
    subplot(1, nr_sets+1,i);
    if i == 1
        imagesc(lambda, theta, ann_ref);
        title('Reference')
    else
        imagesc(lambda, theta, ann_evl{i-1});
        tlte = ['Dataset', num2str(i)];
        title(tlte);
    end
    
    axis xy
    hold on
    plot(long, lat, 'k', 'linewidth', 1.5);
    pbaspect([2 1 1]);
    caxis(cxis1);
end

figure('Name', 'Annual mean difference')
for i = 1:nr_sets
    subplot(1, nr_sets,i);
    imagesc(lambda, theta, d_ann{i});
    axis xy
    hold on
    plot(long, lat, 'k', 'linewidth', 1.5);
    pbaspect([2 1 1]);   
    tlte = ['Dataset', num2str(i)];
    title(tlte);
    caxis(cxis2);
end  

figure('Name', 'Annual mean difference (relative)')
for i = 1:nr_sets
    subplot(1, nr_sets,i);
    imagesc(lambda, theta, d_ann_rel{i});
    axis xy
    hold on
    plot(long, lat, 'k', 'linewidth', 1.5);
    pbaspect([2 1 1]);   
    tlte = ['Dataset ', num2str(i)];
    title(tlte);
    caxis([-100 100])
end  

for i = 1:nr_sets
    fname = ['Monthly difference, dataset ', num2str(i)];
    figure('Name', fname);
    for j = 1:12
        subplot(3,4,j)
        imagesc(lambda, theta, mnth_evl{j,i} - mnth_ref{j});
        axis xy
        hold on
        plot(long, lat, 'k', 'linewidth', 1.5);
        pbaspect([2 1 1]);   
        caxis(cxis2);
    end
end


x = 0:ceil(max(ref_ts_mn(2,:)));
axs1 = min(min([ref_ts_mn(2,:); evl_ts_mn(2:end,:)]));
axs2 = max(max([ref_ts_mn(2,:); evl_ts_mn(2:end,:)]));
for i = 1:nr_sets
    figure
    scatter(ref_ts_mn(2,:), evl_ts_mn(i+1,:), 'filled');
    hold on
    plot(x, a1(i)*x+b1(i));   
    xlabel('Reference')
    ytlte = ['Dataset ', num2str(i)];
    ylabel(ytlte);
    axis([axs1 axs2 axs1 axs2]);
end

if length(varargin) == 2
   x = 0:0.1:1;
   axs1 = min(min([R(1,:) R(2,:)]));
   axs2 = max(max([R(1,:) R(2,:)]));
   figure
   scatter(R(:,1), R(:,2), 'filled');
   hold on
   plot(x, a2*x+b2)   
   xlabel('Correlation Reference vs. Dataset 1')
   ylabel('Correlation Reference vs. Dataset 2');
   axis([0 1 0 1]);
end

   
   
  









    
    
    
    
    
    
    



    

