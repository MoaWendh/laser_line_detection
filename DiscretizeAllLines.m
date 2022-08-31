%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [lines] = DiscretizeAllLines(linhas, size_img)
[c nlinhas]= size(linhas);
dados_invalidos=0;
delta=1;
ini = 0;
fim = size_img(1,2)-1;

lines = {}; %cel pois a qtd de pontos por linha pode variar

for m=1:nlinhas
    nans = isnan(linhas(:,m));
    if nans
       lines{m} = NaN;
       dados_invalidos = dados_invalidos + 1; 
    else
        p1 = [ini; linhas(1,m)];
        p2 = [fim; linhas(2,m)];
        pt_disc = DiscretizeLine(p1, p2, delta);     
        lines{m} = pt_disc;
    end
end

return
