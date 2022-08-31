%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plota_linha_laser_3D(pts3D)

figure(2);
axis equal; hold on;
xlabel('X','FontSize',14);ylabel('Y','FontSize',14);zlabel('Z','FontSize',14);

plot3(pts3D(1,:),pts3D(2,:),pts3D(3,:), '--gs',...
    'LineStyle','none','Marker','.',...
    'MarkerSize',0.5,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.5]);

grid on;

return
