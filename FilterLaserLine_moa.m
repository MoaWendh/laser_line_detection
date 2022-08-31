clearvars; 
clc;
close all;

%Mostrar
mustPlot = 1;
plotLikeMoa = 0;


%% Config - Image path and filters
% Image path

imgRelPath = 'Images\L-tif\L042.tif';

% Filter type
% 1: RGB
% 2: HSV
% 3: YCrCb
filterType = 3;

% Filters limits
th{1} = [152 255];
th{2} = [152 255];
th{3} = [152 255];

%Mostrar

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
    if plotLikeMoa %Plota conforme Moacir
        colorScaleVals = jet(256);

        figure(1);
        sx = size(img,2); sy = size(img,1);
        n = 1;
        % Original
        %subplot(1,3,n); n = n+1; hold on; title('Original');
        imshow(img);
        title('Original');
        grid on; axis on; xlim([0 sx]); ylim([0 sy]);

        % Filtered Color Map        
        figure(2);
        sx = size(img,2); sy = size(img,1);
        str = sprintf('Filtered %s [%.0f %.0f]',colorSpace{3}, th{3});
       % subplot(1,3,n); n = n+1; hold on; title(str);
        imshow(imgFiltered(:,:,3),'Colormap',colorScaleVals); colorbar;
        title(str);
        temp = imgFiltered(:,:,3); [min(temp(:)) max(temp(:))]
        grid on; axis on; xlim([0 sx]); ylim([0 sy]);         

        % Filtered
        figure(3);
        sx = size(img,2); sy = size(img,1);
        %subplot(1,3,n); n = n+1; hold on; title('Filtered');
        imshow(imgFiltered(:,:,3)); colorbar;
        title('Filtered');
        grid on; axis on; xlim([0 sx]); ylim([0 sy])
        
        mw=0;
       
    else %Plota conforme Pedro
        colorScaleVals = jet(256);

        fig1 = figure(1);
        sx = size(img,2); sy = size(img,1);
        n = 1;
       
        % filtered
        for c = 1:3
            str = sprintf('Filtered %s [%.0f %.0f]',colorSpace{c}, th{c});
            subplot(3,1,n); n = n+1; hold on; title(str);
            imshow(imgFiltered(:,:,c),'Colormap',colorScaleVals); colorbar;
            temp = imgFiltered(:,:,c); [min(temp(:)) max(temp(:))]
            grid on; axis on; xlim([0 sx]); ylim([0 sy]);
        end   
    end    
end



