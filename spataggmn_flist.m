function [] = spataggmn_flist(fnmes, id_map, area_id, outnme)
% This function acts as an "input-parser" for the spataggmn.m function,
% which allows the processing of several input FILES, given in the
% inpt-parameter

if ischar(fnmes)
    otpt.filelist = fnmes;
    tmp    = importdata(fnmes);
    clear fnames
    fnmes = tmp;
end

h = waitbar(0,'','Name','Number of datasets processed...'); 
for i = 1:length(fnmes)
     
    
    varnme = who('-file', fnmes{i});
    
    otpt.filename{i,1} = fnmes{i};
    otpt.varname{i,1}  = varnme;
    
    load(fnmes{i});
    
    data = eval(varnme{1});
    otpt.data{i,1} = spataggmn(data, id_map, area_id);     
    clear('data')
    
    save(outnme, 'otpt');
    
	if exist('h')
        waitbar(i/length(fnmes), h, [int2str(i), ' of ', length(fnmes)])
	end
    
        
end



                                                          
                                                          
    