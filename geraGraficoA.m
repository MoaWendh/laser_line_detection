function geraGraficoA(cLineA, cLineB, img)

% Original
figure(1);
imshow(img);
hold on;
%plot(cLineA(1,:),cLineA(2,:),'g',cLineB(1,:),cLineB(2,:),'r');
title('Linha laser imagem esquerda');
text(3000,200,'Branco= Imagem filtrada','Color','w','FontSize',12);
text(3000,400,'Verde= Centro de massa','Color','w','FontSize',12);
text(3000,600,'Verme= Varredura laser','Color','w','FontSize',12);
    
end

