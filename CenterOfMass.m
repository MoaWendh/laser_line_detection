% [IN]:
% - data: L x N data values, regular spaced/indexed
%   L: Lines and N: Number of values
%   Eg: For 1 line and 300 values: 1 x 300.
% [OUT]:
% - center [L x 1]: Center position
% - centerVal [L x 1]: Value at center position
% Pedro Buschinelli 20/07/2019
function [center, centerVal] = CenterOfMass(data)

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
    
    idx2 = sub2ind(size(data), linesIds, centerBefore'+1);

    centerVal = data(idx)'.*(1 - percent) + data(idx2)'.*(percent);
else
    center= NaN;
    centerVal= NaN;
end    
    
return