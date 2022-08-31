%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plota_linha_laser_l(linha_L,imgL,imgR)

%Cria e configura uma entidade para exiir as imagens na mesma figura 
%denominada tela. 
tela = figure('Position', [50 200 1200 800],'Color',[0.8 0.8 0.8], ...
        'NumberTitle','off', ...
        'Name','Par estéreo','DoubleBuffer', 'on',...
        'Units','normalized');

ah1 = axes('Parent', tela,'Position',[.2 0 0.5 1]);
h1 = imshow(imgL); 
hold on; 
title('Imagem esquerda');
%sx = size(imgL,2); sy = size(imgL,1);
%grid on; axis on; xlim([0 sx]); ylim([0 sy]);

plot(linha_L(1,:),linha_L(2,:),'--gs',...
    'LineStyle','none','Marker','o',...
    'MarkerSize',0.4,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor',[0.5,0.5,0.5]) 

ah2 = axes('Parent',tela,'Position',[.5 0 0.5 1],'Tag','Axes2');
h2=imshow(imgR); 
hold on; 
title('Imagem direita');



return