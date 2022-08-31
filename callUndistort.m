close all;
clear;
clc;
dbstop if error;

nStart = 40;
nEnd = 40;

currPath = mfilename('fullpath');
[fileDir, fileName, ext] = fileparts(currPath);

dirL_in  = '\images\L-tif';
dirR_in  = '\images\R-tif';
dirL_out = '\images\L-Undistort';
dirR_out = '\images\R-Undistort';

pathImgL_in  = strcat(fileDir, dirL_in);
pathImgR_in  = strcat(fileDir, dirR_in);
pathImgL_out = strcat(fileDir, dirL_out);
pathImgR_out = strcat(fileDir, dirR_out);

nameFileCalib = '\images\Calib_Results_stereo.mat';
pathFileCalib = strcat(fileDir, nameFileCalib);
[KKL,RtL,kcL,KKR,RtR,kcR,RtLR]= GetCalibDataBouguet(pathFileCalib);

for i= nStart:nEnd
    tic;
    numArq= i;
    fprintf('Corrigindo distorção da imagem %s de %s. ', int2str(numArq), int2str(nEnd));
    nameFile_L= sprintf('\\L%03s.tif',int2str(numArq));
    imgPathL = strcat(pathImgL_in, nameFile_L); 
    %Chama função para corrigir distorção na img esquerda.
    undistImg_L = UndistortImageBouguet(imgPathL,KKL,kcL,'RectifiedMissingValue',0); 
    
    
    nameFile_R= sprintf('\\R%03s.tif',int2str(numArq));
    imgPathR = strcat(pathImgR_in, nameFile_R);
    %Chama função para corrigir distorção na img direita.
    undistImg_R = UndistortImageBouguet(imgPathR,KKR,kcR,'RectifiedMissingValue',0);
   
    %Salva as imagens da esquerda com distorções corrigidas
    nome_file= sprintf('\\%03sLu.tif',int2str(numArq));
    pathImgUndistL= strcat(pathImgL_out, nome_file);
    imwrite(undistImg_L, pathImgUndistL, 'Compression', 'none');
   
    %Salva as imagens da direita com distorções corrigidas
    nome_file= sprintf('\\%03sRu.tif',int2str(numArq));
    pathImgUndistR= strcat(pathImgR_out, nome_file);
    imwrite(undistImg_R, pathImgUndistR, 'Compression', 'none');
    fprintf(' Duração= %4.2f min.\n',toc/60.0);
end

