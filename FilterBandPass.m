function [dataBand,idsInterval, dataBandRemoved] = FilterBandPass(data, bandHalfSize)
bandSize = 2*bandHalfSize + 1;

N = size(data,2);

if bandSize >= N
    error('Data bandSize (bandHalfSize*2 + 1) must be < size(data,2)');
end

[dataMax, maxId] = max(data);

dataBandCenterId = maxId;

startId = maxId - bandHalfSize;
endId = maxId + bandHalfSize;

startId(startId<1) = 1;
endId(endId>N) = N;

dataBand = data(:,startId:endId);
dataBandRemoved = data;
dataBandRemoved(:,startId:endId) = 0;

idsInterval = [startId endId];

return