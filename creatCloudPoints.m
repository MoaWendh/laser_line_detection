%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function creatCloudPoints(pathin, numFile, pts3DAll,single)

if single 
    name_file= sprintf('\\pointsClound.txt',numFile);
    path= strcat('.',pathin, name_file);
    fid = fopen(path,'wt'); 
    M = cell2mat(pts3DAll);
    
    fprintf(fid,'%5.2f %5.2f %5.2f\r\n', M);
else
    M = pts3DAll';
    name_file= sprintf('\\pc%03d.txt',numFile);
    path= strcat('.',pathin, name_file);
    fid = fopen(path,'wt');
    
    fprintf(fid,'%5.2f %5.2f %5.2f\r\n', M');
end;

fclose(fid);



