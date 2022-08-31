clc;
clear all;
close all;
dbstop if error;

%Defina a imagem inicial e final para efetuar a verredura em todos os
%pares de imagens stereo.
im_inicial= 1;
im_final= 18;

%Carrega arquivo de calibração.
%f_calib = 'D:\Moacir\GoogleDrive\Trabalho\Trabalho\VisaoComputacional\Etapa_02\images\Calib_Results_stereo.mat';
f_calib = '.\images\Calib_Results_stereo.mat';

%fullPath = fullfile(pwd, '..');
fullPath = f_calib;

%Chama a função que extrai a matriz F.
F = gera_matriz_F(fullPath);

%Carrega arquivo por arquivo para fazer a análise de cada par estéreo.
% Total de arquivos definido em nArquivos
for n = im_inicial: im_final
    clc;
    fprintf('Processando par estéreo %d \n',n);
    numArq= n;
    %  image_l= sprintf('.\\images\\left%s.tif',  sprintf('%03d',numArq));
    %  image_r= sprintf('.\\images\\Right%s.tif', sprintf('%03d',numArq));
    
    image_l= sprintf('.\\images\\L%s_f.tif', sprintf('%03d',numArq));
    image_r= sprintf('.\\images\\R%s_f.tif', sprintf('%03d',numArq));
    
    imgL = imread(image_l);
    imgR = imread(image_r);
    
    %imgL = imgL(:,:,1:3); %remove alpha channel "4th"
    %imgR = imgR(:,:,1:3);
    
    pts3D = StereoLaser_2V1(imgL, imgR, F, f_calib);
    
    maxZ = 6000;
    minZ = 4600;
    maxY = 0;
    pts3D(:, or(pts3D(3,:)<minZ,pts3D(3,:)>maxZ)) = [];
    pts3D(:, pts3D(2,:)>maxY) = [];
    
    %Plota linha laser projetada no espaço 3D.
   % plota_linha_laser_3D(pts3D);
    
    pts3DAll{n} = pts3D;
end

 creatCloudPoints(pts3DAll);

return


for n = im_inicial: im_final
    plota_linha_laser_3D(pts3DAll{n});
    
end
view([40 70]);



