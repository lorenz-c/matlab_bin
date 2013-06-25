function fld2gis(fld, fname, xll, yll, cellsz)

% FLD2GIS
%
% This function writes the fields obtained fom GSHS to an ASCII file format
% for use in ArcView GIS package.
%
% INPUT - 
% fld - GSHS fields
% fname - file name of the ArcView file
% xll - lower left corner x-coordinate
% yll - lower left corner y-coordinate
% cellsz - cell size
% OUTPUT - ASCII files in the ArcView GIS format
%
%--------------------------------------------------------------------------

% Author: Balaji Devaraju
% Created on: 29 March 2007, Stuttgart
%--------------------------------------------------------------------------

tt = '%14.6f ';
[m,n] = size(fld);
frmtwrt = [repmat(tt,1,n), '\n'];

%fld = [fld(:,((n/2)+1):end), fld(:,1:(n/2))];


fid = fopen(fname,'w+');
fprintf(fid, 'ncols            %g',n);
fprintf(fid, '\n');
fprintf(fid, 'nrows            %g',m);
fprintf(fid, '\n');
fprintf(fid, 'xllcorner        %g',xll);
fprintf(fid, '\n');
fprintf(fid, 'yllcorner        %g',yll);
fprintf(fid, '\n');
fprintf(fid, 'cellsize         %2.4f', cellsz);
fprintf(fid, '\n');
fprintf(fid, 'NODATA_value   -9999');
fprintf(fid, '\n');
fprintf(fid, frmtwrt, fld');
fclose(fid);