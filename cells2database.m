function otpt = cells2database(inpt, syr, smnth);

fprintf('\n')
fprintf('---------------------------------------------------- \n')
fprintf('Convert a "unordered" cell array to a data array     \n')
fprintf('---------------------------------------------------- \n')
fprintf(' \n')
cntrnme = input('Data center: ', 's');
varnme  = input('Variable name: ', 's');

units   = input('Enter units of variable: ', 's');
dly     = input('Daily dataset?: ', 's');
fprintf('---------------------------------------------------- \n')


mnth = smnth;
yr   = syr;
N = length(inpt);

if strcmp(dly, 'y')
 
    day = 1;
    for i = 1:N
        otpt{i,1} = cntrnme;
        otpt{i,2} = varnme;
        otpt{i,3} = day;
        otpt{i,4} = mnth;
        otpt{i,5} = yr;
        otpt{i,6} = 'Global';
        otpt{i,7} = 89.75:-0.5:-89.75;
        otpt{i,8} = -179.75:0.5:179.75;
        otpt{i,9} = inpt{i};
        otpt{i,10} = units;
        
        nr_days = eomday(yr, mnth)
        day = day + 1;
        
        if day > nr_days
            day = 1;
            mnth = mnth + 1;
            
            if mnth == 13      
                mnth = 1;
                yr = yr + 1;                
            end
        end
    end
    
else
    
    for i = 1:N
        otpt{i,1} = cntrnme;
        otpt{i,2} = varnme;
        otpt{i,3} = mnth;
        otpt{i,4} = yr;
        otpt{i,5} = 'Global';
        otpt{i,6} = 89.75:-0.5:-89.75;
        otpt{i,7} = -179.75:0.5:179.75;
        
        for j = 1:size(inpt,2)
            otpt{i,j+7} = inpt{i,j};
        end
        otpt{i,j+8} = units;
        
        mnth = mnth + 1;
        if mnth == 13
            mnth = 1;
            yr   = yr + 1;
        end
    end
end            
        



    
