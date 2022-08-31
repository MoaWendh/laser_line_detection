% Filtra todas as imagens definidas entre nStart e nEnd
% Através da chamanda da função FilterLaserLine().

close all;
clear;
clc;

nStart = 1;
nEnd = 55;

currPath = mfilename('fullpath');
[fileDir,fileName,ext] = fileparts(currPath);

dirImagesL_in = '\images\L-Undistort';
dirImagesR_in = '\images\R-Undistort';

dirImagesL_out = '\images\L-Filter';
dirImagesR_out = '\images\R-Filter';

pathImgL_in = strcat(fileDir, dirImagesL_in);
pathImgR_in = strcat(fileDir, dirImagesR_in);

pathImgL_out = strcat(fileDir, dirImagesL_out);
pathImgR_out = strcat(fileDir, dirImagesR_out);

timeTotal=0;

for reg = nStart:nEnd
    tic;
    numArq=(reg);
    fprintf('Filtrando imagem %s de %s. ', int2str(numArq), int2str(nEnd))
    %Gera path da imagem a ser filtrada
    nameFile_L= sprintf('\\%03sLu.tif',int2str(numArq));
    imgPathL_in = strcat(pathImgL_in, nameFile_L);
    
    nameFile_R= sprintf('\\%03sRu.tif',int2str(numArq));
    imgPathR_in = strcat(pathImgR_in, nameFile_R);
        
    %Chama função para filtrar as imagens esquerda e direita,
    %Retorna o path da imagem filtrada.
    nameFile_LF= sprintf('\\L%03sF.tif',int2str(numArq));
    imgPathL_outF= strcat(pathImgL_out, nameFile_LF);
    nameFile_RF= sprintf('\\R%03sF.tif',int2str(numArq));
    imgPathR_outF = strcat(pathImgR_out, nameFile_RF);
    
    FilterLaserLine(imgPathL_in, imgPathL_outF, numArq);
    FilterLaserLine(imgPathR_in, imgPathR_outF, numArq);
   
    time= toc/60.0;
    timeTotal= timeTotal + time;
    fprintf(' Duração= %4.2f min. | tempo total decorrido= %4.2f min. \n',time, timeTotal);
end

