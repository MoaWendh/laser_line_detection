%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Moacir Wendhausen
% 27/06/2019
% Esta fun��o faz a varredura na primeira linha da imagem para detectar o ponto da linha laser
% Ela retorna as coordenadas do ponto
% Par�metros de entrada: 
%  - image= imagem a ser feita a varredura.
%
% Par�metros de sa�da:
%  - pts_laser: matriz contendo as coordenadas dos pontos da linha laser bem como sua intensiade 
%               esta matriz cont�m: 1)O n�mero do ponto
%                                   2)Coordenada x;
%                                   3)Coordenada y;
%                                   4)Intensidade do ponto. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function pts = varre_linha_Laser(img)

fprintf('Fazendo varredura na linha laser...\n');

[ny nx]= size(img);
pts = nan(2,ny);
pts(2,:) = 0:ny-1;
val = zeros(1,ny);

for y = 1:ny
    for x = 1:nx
        if img(y,x) > val(y) 
            val(y) = img(y,x);
            pts(1,y) = x-1;
        end
    end
end

return;