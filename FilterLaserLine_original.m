clearvars; clc;

%% Config - Image path and filters
% Image path

imgRelPath = 'Images\L-tif-reduzido\L015.tif';

% Filter type
% 1: RGB
% 2: HSV
% 3: YCrCb
filterType = 3;

% Filters limits
th{1} = [0 0];
th{2} = [0 0];
th{3} = [152 255];

%Mostrar
mustPlot = 1;

%% Image load
currPath = mfilename('fullpath');
[fileDir,fileName,ext] = fileparts(currPath);

imgPath = strcat(fileDir,'\',imgRelPath);

img = imread(imgPath);

% Remove alpha (if exists)
if size(img,3) == 4
    img(:,:,4) = [];
end

%Create image in filter color space (FCS)
switch filterType
    case 1
        colorSpace = {'R','G','B'};
        imgFCS = img;
    case 2
        colorSpace = {'H','S','V'};
        imgFCS = uint8(255*rgb2hsv(img));
    case 3
        colorSpace = {'Y','Cb','Cr'};
        imgFCS = rgb2ycbcr(img);
    otherwise
        error('Invalid filter type');
end


%% Filter image
imgFiltered = imgFCS;
for c = 1:3
    temp = imgFCS(:,:,c);
    thMin = th{c}(1); thMax = th{c}(2);
    temp(temp<thMin) = 0;
    temp(temp>thMax) = 255;
    imgFiltered(:,:,c) = temp;
end
clear temp;



%% Back to original format
switch filterType
    case 1
        imgFilteredRGB = imgFiltered;
    case 2
        imgFilteredRGB = hsv2rgb(imgFiltered);
    case 3
        imgFilteredRGB = ycbcr2rgb(imgFiltered);
    otherwise
        error('Invalid filter type');
end


%% Show images
if mustPlot
    colorScaleVals = jet(256);
    
    fig1 = figure(1);
    sx = size(img,2); sy = size(img,1);
    n = 1;
    % Original
    subplot(3,3,n); n = n+1; hold on; title('Original');
    imshow(img);
    grid on; axis on; xlim([0 sx]); ylim([0 sy]);
    
    % Filtered
    subplot(3,3,n); n = n+1; hold on; title('Filtered');
    imshow(imgFilteredRGB);
    grid on; axis on; xlim([0 sx]); ylim([0 sy]);
    
    % Original-Mask
    subplot(3,3,n); n = n+1; hold on; title('Original-Mask');
    imshow(img);
    grid on; axis on; xlim([0 sx]); ylim([0 sy]);
    
    for c = 1:3
        subplot(3,3,n); n = n+1; hold on; title(colorSpace{c});
        imshow(imgFCS(:,:,c),'Colormap',colorScaleVals); colorbar;
        grid on; axis on; xlim([0 sx]); ylim([0 sy]);
    end
    
    % filtered
    for c = 1:3
        str = sprintf('Filtered %s [%.0f %.0f]',colorSpace{c}, th{c});
        subplot(3,3,n); n = n+1; hold on; title(str);
        imshow(imgFiltered(:,:,c),'Colormap',colorScaleVals); colorbar;
        temp = imgFiltered(:,:,c); [min(temp(:)) max(temp(:))]
        grid on; axis on; xlim([0 sx]); ylim([0 sy]);
    end
end

