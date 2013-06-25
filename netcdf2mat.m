function otpt = netcdf2mat(flist, date, var_ids);

% -------------------------------------------------------------------------
% The function reads one or multiple netcdf-files and stores the variables
% in a cell-array. The names of the files to be read must be provided in
% the file flist. As the date of the datasets is stored as well, a start-
% and end-date can be provided. Furthermore, if the netcdf-files contain
% multiple variables, the desired variables can be selected with the
% parameter var_ids, which is a vector containing the variable ids of the
% variables which shall be stored. 
% -------------------------------------------------------------------------
% Note: At present, the program supports only monthly input. In a future
% version, support for arbitrary timesteps will be implemented.
% -------------------------------------------------------------------------
% Input:   flist   'string'     File which contains the names of the
%                               netcdf-files to be read
%          date    [1 x 4]      Vector which contains start- and
%                               end-date of the dataset in the 
%                               following arrangement:
%                               [start_year start_month end_year end_month]
%          var_ids [1 x n]      vector which contains the variable ids of 
%                               the variables which shall be read                             
%
% Output:  otpt    [m x n+2]    cell-structure which contains the month and 
%                               year of a specific dataset in the first two 
%                               columns and the desired data
%
% -------------------------------------------------------------------------
% Christof Lorenz, IMK-IFU Garmisch-Partenkirchen
% September 2010
% -------------------------------------------------------------------------
% Uses: netcdf-toolbox
% -------------------------------------------------------------------------


files = importdata(flist);



syear = date(1);
smonth = date(2);
eyear = date(3);
emonth = date(4);


month    = smonth;
year     = syear;
nr_files = 0;

i = 0;
flg = 0;

while flg == 0
    i = i + 1;
    
    if month == emonth & year == eyear
        flg = 1;
    end
    
    date_vec(i,1:2) = [month year];
    
    month = month + 1;
    
    if month == 13
        month = 1;
        year = year + 1;
    end
        
  
    nr_files = nr_files + 1;
    
    
    
end
keyboard
if nr_files ~= length(files)
    error('Time domain does not match with number of files');
end
    

for i = 1:length(files)
    ncid = netcdf.open(files{i}, 'nowrite');
    
    otpt{i,1} = date_vec(i,1);
    otpt{i,2} = date_vec(i,2);

    for j = 1:length(var_ids)
        otpt{i,j+2} = netcdf.getVar(ncid, var_ids(j));
    end

    netcdf.close(ncid);
end




    