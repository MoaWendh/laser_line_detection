%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear;
clc;
dbstop if error;

currPath = mfilename('fullpath');
[fileDir, fileName, ext] = fileparts(currPath);

fCalib = '\images\L\Calib_Results_stereo.mat';
dirCloud = '\Images\CloudPoints';

dirImagesL_out = '\Images\L';
dirImagesR_out = '\Images\R';

pathImgL_out = strcat(fileDir, dirImagesL_out);
pathImgR_out = strcat(fileDir, dirImagesR_out);
pathCalib = strcat(fileDir, fCalib);

%Define a imagem inicial "nStart" e imagem final "nEnd"
nStart = 1;
nEnd = 1;

%Chama a função que extrai a matriz F.
F=gera_matriz_F(pathCalib);

timeTotal=0;
for reg = nStart:nEnd
    tic;
    numArq=(reg);
    fprintf('Determinado pontos 3D Imagem %d ', numArq);

    %Apenas gera o path da imagem já filtrada, se esta já existir
    nameFile_LF= sprintf('\\L%04s.tif',int2str(numArq));
    pathImgLF = strcat(pathImgL_out, nameFile_LF); 
    nameFile_RF= sprintf('\\R%04s.tif',int2str(numArq));
    pathImgRF = strcat(pathImgR_out, nameFile_RF);
    
    %Chama função para gerar os pontos 3D
    pts3D = generatePoints3D(pathImgLF, pathImgRF, F, pathCalib);
    maxZ = 5300; 
    minZ = 4800; 
    maxY = 0;
    pts3D(:, or(pts3D(3,:)<minZ, pts3D(3,:)>maxZ)) = [];
    pts3D(:, pts3D(2,:)>maxY) = [];     
    pts3DAll{reg} = pts3D;  
    
    % Chama função para gerar 1 arquivo de nuvem de pontos para cada linha
    % se singleFile =0
   
    time= toc/60.0;
    timeTotal= timeTotal + time;
    fprintf(' Duração= %4.2f min. | tempo total decorrido= %4.2f min. \n',time, timeTotal);
end

singleFile=0;

if singleFile
   creatCloudPoints(dirCloud, reg, pts3DAll, singleFile);
end

plotPoints3D=1;
if plotPoints3D
    for n = nStart : nEnd
        plota_linha_laser_3D(pts3DAll{n}); 
    end 
    view([10 20]);
end    

