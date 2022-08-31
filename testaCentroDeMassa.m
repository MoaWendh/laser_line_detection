clear;
clc;

image=imread('C:\Projetos\Matlab\mine\laser_line_detection-master\images\L\LFx0001.tif');
a= size(image);

for (n=1:a(1))
    data= image(n,:); 
    centerLineL = calcCenterMass(image);
   % centerLine{n}.pos= n-1;
   % center{n}=A;
   % center(1,n) = A(1,n);
   % center(2,n) = n-1; 
    mw=0;
end



function [center, centerVal] = fCenterOfMass(data)

if any(data(:))
    N = size(data,1);
    data= double(data);
    ids = 1:1:size(data,2);
    dataTimesId = data.*ids;

    center = sum(dataTimesId,2)./sum(data,2);

    centerBefore = floor(center);

    percent = center - centerBefore;

    linesIds = 1:N;
    idx = sub2ind(size(data), linesIds, centerBefore');
    
    centerBefore(max(centerBefore)>=N) = N-1;
   
    % A função "sub2ind()" retorna o índice equivalente da matriz NxM
    % quando tranformada numa matriz de uma única linha.
    idx2 = sub2ind(size(data), linesIds, centerBefore'+1);

    centerVal = data(idx)'.*(1 - percent) + data(idx2)'.*(percent);
else
    center= NaN;
    centerVal= NaN;
end    
end