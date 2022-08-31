clearvars; clc;

%% Image path and load

currPath = mfilename('fullpath');
[fileDir,fileName,ext] = fileparts(currPath);

imgRelPath = '\Images-old\Left008.tif';
imgPath = strcat(fileDir,imgRelPath);

img = imread(imgPath);

% Remove alpha (if exists)
if size(img,3) == 4
    img(:,:,4) = [];
end

% RGB -> HSI
imgHSV = uint8(255*rgb2hsv(img));
imgYCbCr = rgb2ycbcr(img);

%
thY  = [0 255];
thCb = [0 255];
thCr = [147 255];

imgY = imgYCbCr(:,:,1);
imgY(imgY<thY(1)) = 0;
imgY(imgY>thY(2)) = 255;

imgCb = imgYCbCr(:,:,2);
imgCb(imgCb<thCb(1)) = 0;
imgCb(imgCb>thCb(2)) = 255;

imgCr = imgYCbCr(:,:,3);
imgCr(imgCr<thCr(1)) = 0;
imgCr(imgCr>thCr(2)) = 255;

imgHSIf(:,:,1) = imgY;
imgHSIf(:,:,2) = imgCb;
imgHSIf(:,:,3) = imgCr;


%% Show images
colorScaleVals = jet(256);

fig1 = figure(1);
sx = size(img,2); sy = size(img,1);
n = 1;
% Original
subplot(3,3,n); n = n+1; hold on; title('R');
imshow(img(:,:,1));
grid on; axis on; xlim([0 sx]); ylim([0 sy]);

% Max
subplot(3,3,n); n = n+1; hold on; title('G');
imshow(img(:,:,2));
grid on; axis on; xlim([0 sx]); ylim([0 sy]);

% Original-Mask
subplot(3,3,n); n = n+1; hold on; title('B');
imshow(img(:,:,3));
grid on; axis on; xlim([0 sx]); ylim([0 sy]);

% H
subplot(3,3,n); n = n+1; hold on; title('H');
%imshow(imgHSV(:,:,1),'Colormap',colorScaleVals); colorbar;
imshow(imgYCbCr(:,:,1));
grid on; axis on; xlim([0 sx]); ylim([0 sy]);

% S
subplot(3,3,n); n = n+1; hold on; title('S');
%imshow(imgHSV(:,:,2),'Colormap',colorScaleVals); colorbar;
imshow(imgYCbCr(:,:,3));
grid on; axis on; xlim([0 sx]); ylim([0 sy]);

% I
subplot(3,3,n); n = n+1; hold on; title('V');
%imshow(imgHSV(:,:,3),'Colormap',colorScaleVals); colorbar;
imshow(imgYCbCr(:,:,3))
grid on; axis on; xlim([0 sx]); ylim([0 sy]);

% H filtered
subplot(3,3,n); n = n+1; hold on; title('Y');
imshow(imgY);
grid on; axis on; xlim([0 sx]); ylim([0 sy]);

% S filtered
subplot(3,3,n); n = n+1; hold on; title('Cb');
imshow(imgCb);
grid on; axis on; xlim([0 sx]); ylim([0 sy]);

% I filtered
subplot(3,3,n); n = n+1; hold on; title('Cr');
imshow(imgCr);
grid on; axis on; xlim([0 sx]); ylim([0 sy]);

figure(2);

% S filtered
subplot(1,2,1); hold on; title('Original');
imshow(img);
grid on; axis on; xlim([0 sx]); ylim([0 sy]);

% I filtered
subplot(1,2,2); hold on; title('Filtrada');
imshow(imgCr);
grid on; axis on; xlim([0 sx]); ylim([0 sy]);

