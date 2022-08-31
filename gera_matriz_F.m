%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extrai a matriz F a partir do arquivo de calibração file_calib
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function matriz_F = gera_matriz_F(file_calib)

%fprintf('Construindo a matrix fundamental F...\n%s\n');
[KKL,RtL,kcL, KKR,RtR,kcR,RtLR] = GetCalibDataBouguet(file_calib);
load(file_calib);
% Determina a matriz F.
KKL=KK_left;

PL = [KKL [0 0 0]'; 0 0 0 1]*RtL;
PR = [KKR [0 0 0]'; 0 0 0 1]*RtR;

matriz_F = vgg_F_from_P(PL,PR);

