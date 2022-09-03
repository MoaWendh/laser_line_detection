%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function epiPts = gera_linhas_epipolares(L_1, matriz_F, imgSize, imgR)

%fprintf('Gerando linhas epipolares...\n');

N = size(L_1,2);

imshow(imgR);
hold on;
for m = 1:N
    aux = [L_1(1,m); L_1(2,m); 1];
    pt_trans = matriz_F*aux;
    coord = get_line_points(pt_trans, imgSize);
    if isempty(coord) || size(coord,2) < 2 % testa se as cordenadas vem nulas, se sim pula ao ponto seguinte.
        epiPts(:,m) = [NaN NaN]; % função isnan(var) testa se var é NaN.
    else
        epiPts(:,m) = [coord(2,1) coord(2,2)];
        plot(coord(:,1),coord(:,2),'r');
    end
end


function pts=get_line_points(v,sz)
a=v(1);
b=v(2);
c=v(3);
h=sz(1);
w=sz(2);

% This might cause 'divide by zero' warning:
ys=c/-b ;
yf=-(a*w+c)/b;
xs=c/-a;
xf=-(b*h+c)/a;

m1 = [[xs;1] [xf;h] [1;ys] [w;yf]];
%talvez possa mudar aqui, xs<w & xs>=0, etc, se considerar de 0 a n-1
%mas por segurança deixei assim e mudei somente no final pts=pts-1
%padronizando coordenadas base 0 sempre.
w2 = [(xs<=w & xs>=1) (xf<=w & xf>=1) (ys<=h & ys>=1) (yf<=h & yf>=1)];
v = w2>0;
pts = m1(:,v);
pts = pts-1; %padrão sistema de coordenadas começa em 0,0
