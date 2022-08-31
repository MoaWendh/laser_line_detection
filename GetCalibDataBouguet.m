function [KKL,RtL,kcL, KKR,RtR,kcR,RtLR] = GetCalibDataBouguet(filePath)
% www.vision.caltech.edu/bouguetj/calib_doc/
% Bouguet calibration data

%% Load file
%fullPathAndPath = which(filePath);
%which only works if file is in matlab path
fullPathAndPath = filePath;
%files=which('stereoRefraCalibData.mat','-all')
%fprintf('Loading Bouguet calibration data from:   "%s" \n',fullPathAndPath);

load(fullPathAndPath,'R','T','KK_right','KK_left','kc_left','kc_right','Tc_left_2','omc_left_2');

%% 1 Left

%Intrinsic
KKL = KK_left;

%Distortion
kcL = kc_left;

%Extrinsic
RL = rodrigues(omc_left_2);
RL = roty(-20)*rotz(-90)*RL;
%RL = roty(0)*rotz(0)*RL;
tL = Tc_left_2;

RtL = [RL tL; 0 0 0 1];

%% 2 Right

%Intrinsic
KKR = KK_right;

%Distortion
kcR = kc_right;

% RotationOfCamera2 Rotation of camera 2 relative to camera 1
% Cam 1 cam 2 relative pose
% Rt1 = RtL ||| W -> Cam1
% Rt2 = RtR ||| W -> Cam2
% Rt12 ||| Cam1 -> Cam2
% Rt2 = Rt12*Rt1 ||| W -> Cam1, Cam1 -> Cam2 == W -> Cam2
% XR = R * XL + T
% http://www.vision.caltech.edu/bouguetj/calib_doc/htmls/example5.html
%RtLR = [R T; 0 0 0 1];
% RtLR = RtR*inv(RtL) == L -> W, W -> R
% RtRL = RtL*inv(RtR) == R -> W, W -> L
%RtR = RtLR*RtL; % W -> CamL, CamL -> CamR == W -> CamR
RtLR = [R T; 0 0 0 1];
RtR = RtLR*RtL;

% clear R T RL tL KK_right KK_left kc_right kc_left omc_left_1 Tc_left_1 omc_left_2 Tc_left_2;

% Overwrite Rt
% Load same as water calib
% load('RtL.mat');
% load('RtR.mat');
% dt = [0 0 0 0; 0 0 0 -8; 0 0 0 13; 0 0 0 0];
% RtR = RtR + dt;
% RtL = RtL + dt;
