%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Moacir Wendhausen
% 27/06/2019
% Esta função faz a varredura na primeira linha da imagem para detectar o ponto da linha laser
% Ela retorna as coordenadas do ponto
% Parâmetros de entrada:
%  - image= imagem a ser feita a varredura.
%
% Parâmetros de saída:
%  - pts_laser: matriz contendo as coordenadas dos pontos da linha laser bem como sua intensiade
%               esta matriz contém: 1)O número do ponto
%                                   2)Coordenada x;
%                                   3)Coordenada y;
%                                   4)Intensidade do ponto.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  [imgPtsR imgPtsL]= FindLinesCenter(linhas, PtsL, img)

threshold = 0;
N = size(linhas,2);

for m=1:N
    if ~isnan(linhas{m}(1))
        ptsCount = size(linhas{m},2);
        
        %encontrar intensidades interpoladas ou não
        %interp2(
        
        max = -1;
        ptMax = [NaN NaN]';
        for n=1:ptsCount
            pt = linhas{m}(:,n) + 1;%Matlab matriz é base 1
            val = img(pt(2),pt(1)); %Matlab --> img(y,x)
            if (val > threshold) && (val > max)
                max = val;
                ptMax = linhas{m}(:,n);
            end
        end
        %if ~isnan(ptMax)
        imgPtsR(:,m) = ptMax;
        imgPtsL(:,m) = PtsL(:,m);
        %end
    end
end
