%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [XL, XR]=faz_triangulacao_Laser(xL, xR, file_calib)

fullPathAndPath = file_calib;
%fprintf('Carregando dados de calibração...\n');

load(fullPathAndPath,'T','om','fc_left','cc_left','kc_left','alpha_c_left','fc_right','cc_right','kc_right','alpha_c_right');

%fprintf('Gerando coordenadas 3D...\n');
% Chama a função stereo_triangulation para determinar a projeção dos pontos
% 3D referentes a imagem esquerda e direita, 
[X_L, X_R] = stereo_triangulation(xL,xR,om,T,fc_left,cc_left,kc_left,alpha_c_left,fc_right,cc_right,kc_right,alpha_c_right);

%[l c]= size(xL);
[l c]= size(xR);

ct=0;
for m=1:c 
    if (isnan(X_L(:,m)) | isnan(X_R(:,m)))
      ct= ct+1;   
    else
      XL(1,(m-ct))=X_L(1,m);  
      XL(2,(m-ct))=X_L(2,m);  
      XL(3,(m-ct))=X_L(3,m);  
      XR(1,(m-ct))=X_R(1,m);  
      XR(2,(m-ct))=X_R(2,m);  
      XR(3,(m-ct))=X_R(3,m);       
    end
end    

plot=0;

if plot  
    figure;
    plot3(XL(1,:),XL(2,:),XL(3,:), '--gs',...
        'LineStyle','none','Marker','.',...
        'MarkerSize',0.5,...
        'MarkerEdgeColor','r',...
        'MarkerFaceColor',[0.5,0.5,0.5]);
    hold on;
    grid on;

    plot3(XR(1,:),XR(2,:),XR(3,:), '--gs',...
        'LineStyle','none','Marker','.',...
        'MarkerSize',0.5,...
        'MarkerEdgeColor','b',...
        'MarkerFaceColor',[0.5,0.5,0.5]);
end