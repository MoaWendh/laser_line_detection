%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Moacir
% Data: 27/06?2019
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function pts3DL = generatePoints3D(pathImgL, pathImgR, mat_F, file_calib)
imgL = imread(pathImgL);
imgR = imread(pathImgR);

% Extrai o tamanho das imagens esquerda e direita. Armazena em uma matriz 2x2
imgSize = size(imgL);

centerMass= 1;
% Chama função para calcular o centro de massa da linha laser.
if centerMass
    centerLineL = calcCenterMass(imgL);
else
    imgDataL = sum(double(imgL),3);
    centerLineL = varre_linha_Laser(imgDataL);
end    

% Chama a função que detecta as linhas epipolares a partir das coordenadas
linhas_eps = gera_linhas_epipolares(centerLineL, mat_F, imgSize, imgR);

% Chama função discretiza para discretizar as linhas epipolares
[linhas_eps_discr] = DiscretizeAllLines(linhas_eps, imgSize);

% Efetua a varredura em todas as linhas epip. para determinar os pontos
% homologos
imgDataR = sum(double(imgR),3);
[imgPtsR, imgPtsL] = FindLinesCenter(linhas_eps_discr, centerLineL, imgDataR);

filterNaNs = or(isnan(imgPtsL(1, :)),isnan(imgPtsR(1, :)));
imgPtsL(:,filterNaNs) = [];
imgPtsR(:,filterNaNs) = [];

%Apenas plota a linha laser da imagem esquerda.
mustPlotLaser = 0;
if mustPlotLaser
    fprintf('\nPlota resultado\n');
    %plota linha laser da imagem esquerda.
    plota_linha_laser_l(imgPtsL+1, imgL, imgR);
    hold on;   
    %Plota os pontos homologos obtidos
    plota_linha_laser_r(imgPtsR);
end

%Efetua a triangulação laser para reconstrução das linhas que definem
%os pontos 3D no espaço. 
[pts3DL pts3DR] = faz_triangulacao_Laser(imgPtsL, imgPtsR, file_calib);

end



