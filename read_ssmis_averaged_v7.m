% read_ssmis_averaged_v7
%
% this subroutine reads uncompressed SSMIS data from Remote Sensing Systems'
% binary format  (version-7 released October 2010) 
%
% The averaged files can be 3-Day, weekly, or monthly time composites (averages).
% These averaged time composite files all share the same data file format.
% File name format is  	Fss_yyyymmddv7_d3d for 3-day   (average of 3 days ending on file date)
%			      Fss_yyyymmddv7	 for weekly  (start sunday, end saturday, named by saturday date)
%			      Fss_yyyymmv7	 for monthly 
%	
% input arguments:
% data_file = the full path and name of the uncompressed data file
%
% the function returns these products:
% wind = wind speed in meters/second
% vapor = atmospheric water vapor in millimeters
% cloud = liquid cloud water in millimeters
% rain  = rain rate in millimeters/hour
%
% longitude is 0.25*xdim- 0.125
% latitude  is 0.25*ydim-90.125
%
%
% For detailed data description, see 
% http://www.remss.com/ssmi/ssmis_data_description.html
%
% Remote Sensing Systems
% support@remss.com


function [wind,vapor,cloud,rain] = read_ssmis_averaged_v7(data_file)

scale=[.2 .3 .01 .1];
offset=[0.,0.,0.05,0.]
xdim=1440;ydim=720;numvar=4;
mapsiz=xdim*ydim;

if ~exist(data_file)
   error = ['file not found: ', data_file]
   wind=[];vapor=[];cloud=[];rain=[];
   return;
end;

fid=fopen(data_file,'rb');
data=fread(fid,mapsiz*numvar,'uint8');
fclose(fid);
data_file
map=reshape(data,[xdim ydim numvar]);

for i=1:numvar
    tmp=map(:,:,i);
    ia=find(tmp<=250);tmp(ia)=tmp(ia)*scale(i)-offset(i);
    map(:,:,i)=tmp;
end;

wind  = map(:,:,1);
vapor = map(:,:,2);
cloud = map(:,:,3);
rain  = map(:,:,4);

return;
