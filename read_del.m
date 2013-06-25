function del = read_del(fnames)
% The function reads a set of Precipitation or Temperature datasets in the
% format which is used by the University of Delaware and stores the
% formatted data in a structure variable.
% The missing values are set to -9999 for consistency with similar
% datasets.

long = -179.75:0.5:179.75;
lat  = 89.75:-0.5:-89.75;

nr_files = size(fnames,1);

del = cell(nr_files*12, 3);

h = waitbar(0,'','Name','Reading progress...');

for i = 1:nr_files
        
    
    
    d      = importdata(fnames{i});
    year   = str2num(fnames{i}(end-3:end));
    
    tmp = cell(12,1);
    
    for k = 1:12
        tmp{k,1} = zeros(360,720)-9999;
        tmp{k,2} = k;
        tmp{k,3} = year;
    end
    
    for j = 1:length(d)
        row_ind = find(lat   == d(j,2));
        clm_ind = find(long  == d(j,1));
        
        tmp{1,1}(row_ind, clm_ind)  = d(j,3);
        tmp{2,1}(row_ind, clm_ind)  = d(j,4);
        tmp{3,1}(row_ind, clm_ind)  = d(j,5);
        tmp{4,1}(row_ind, clm_ind)  = d(j,6);
        tmp{5,1}(row_ind, clm_ind)  = d(j,7);
        tmp{6,1}(row_ind, clm_ind)  = d(j,8);
        tmp{7,1}(row_ind, clm_ind)  = d(j,9);
        tmp{8,1}(row_ind, clm_ind)  = d(j,10);
        tmp{9,1}(row_ind, clm_ind)  = d(j,11);
        tmp{10,1}(row_ind, clm_ind) = d(j,12);
        tmp{11,1}(row_ind, clm_ind) = d(j,13);
        tmp{12,1}(row_ind, clm_ind) = d(j,14);
        

    end

    del((i-1)*12+1:i*12,1) = tmp(:,2);
    del((i-1)*12+1:i*12,2) = tmp(:,3);
    del((i-1)*12+1:i*12,3) = tmp(:,1);
    clear tmp
    
    waitbar(i/nr_files, h, [int2str(i) '/' int2str(nr_files) ' files'])
    sprintf([fnames{i}, '...Ok'])
end
close(h)
              
            