%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear;
clc;
dbstop if error;

currPath = mfilename('fullpath');
[fileDir,fileName,ext] = fileparts(currPath);

dirImagesL = '\Images-old\L-tif';
dirImagesR = '\Images-old\R-tif';
fCalib = '\images-old\Calib_Results_stereo.mat';

pathImgL = strcat(fileDir, dirImagesL);
pathImgR = strcat(fileDir, dirImagesR);
pathCalib = strcat(fileDir, fCalib);

nStart = 1;
nEnd = 1;

%Caso as imagens filtradas já existam, applyFilter=0.
%Se quiser filtrar novamente applyFilter=1.
applyFilter =1;

%Chama a função que extrai a matriz F.
F=gera_matriz_F(pathCalib);

for reg = nStart:nEnd
    numArq=(reg);
    
    if applyFilter
        %Gera path da imagem a ser filtrada
        nameFile_L= sprintf('\\L00%s_red.tif',int2str(numArq));
        imgPathL = strcat(pathImgL, nameFile_L);
    
        nameFile_R= sprintf('\\R00%s_red.tif',int2str(numArq));
        imgPathR = strcat(pathImgR, nameFile_R);
        
        %Chama função para filtrar as imagens esquerda e direita,i
        %Retorna o path da imagem filtrada.
        pathImgLF= FilterLaserLine(imgPathL, numArq);
        pathImgRF= FilterLaserLine(imgPathR, numArq);
    else
        %Apenas gera o path da imagem já filtrada, se esta já existir
        nameFile_LF= sprintf('\\L00%sF.tif',int2str(numArq));
        pathImgLF = strcat(pathImgL, nameFile_LF);
    
        nameFile_RF= sprintf('\\R00%sF.tif',int2str(numArq));
        pathImgRF = strcat(pathImgR, nameFile_RF);
    end
    
    imgL= imread(pathImgLF);
    [rows cols]= size(imgL);
    
    for i=1:rows
        data= imgL(i,:); 
        [A(1,i) A(2,i)]= CenterOfMass(data);
    end
    
    A= round(A);
    A= round(A);
    
    plot(A(1,:))
    
    pts3D = generatePoints3D(pathImgLF, pathImgRF, F, pathCalib);
    maxZ = 6400;
    minZ = 6000;
    maxY = 0;
    pts3D(:, or(pts3D(3,:)<minZ, pts3D(3,:)>maxZ)) = [];
    pts3D(:, pts3D(2,:)>maxY) = [];
    
    %Plota linha laser projetada no espaço 3D.
    %plota_linha_laser_3D(pts3D);
    
    pts3DAll{reg} = pts3D;
end

creatCloudPoints(pts3DAll);

for n = nStart : nEnd
    plota_linha_laser_3D(pts3DAll{n}); 
end
view([40 70]);