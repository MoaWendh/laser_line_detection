clearvars; clc;

%% Create sample data
N = 50;

data = 20*rand(1,N);
ids = 1:1:N;

centerValues = [240 250 252 251 250 230 255];
Npeak = numel(centerValues);
startId1 = 7;
data(startId1:startId1+Npeak-1) = centerValues;


%% Filter #1 - Threshold
dataMean = mean(data);
dataStd = std(data);
filterA = 1;
filterB = 2*(25/N);
th = dataMean + filterB*dataStd;

dataFiltered = data;
dataFiltered(dataFiltered<th) = 0;

%multilines:
dataMulti = [data;dataFiltered];

[center12,centerVal12] = CenterOfMass(dataMulti);

[center1,centerVal1] = CenterOfMass(data);
[center2,centerVal2] = CenterOfMass(dataFiltered);

% Check
if false
    [center1 center2] - center12'
    [centerVal1 centerVal2] - centerVal12'
end
%% Filter #2 - BandPass
bandHalfSize = 5;
[dataBand1, idsInterval, dataFindBand2] = FilterBandPass(data, bandHalfSize);

%% Plot result
fig = figure(1);
clf(fig,'reset');

% Threshold test
subplot(2,1,1);
grid on; hold on;
title('Threshold test');
xlabel('Position');
ylabel('Value');

legendData = [];

% Data
str = sprintf('Data (N = %i. Mean = %.1f. Std = %.1f)',N, dataMean, dataStd);
legendData(end+1) = plot(ids,data,'.k','DisplayName',str);

% Th
px = [0 max(ids)];
py = [th th];
str = sprintf('Threshold %.1f',th);
legendData(end+1) = plot(px,py,'-b','DisplayName',str);

% Center
px = [center2 center2]';
py = [0 255]';
str = sprintf('Center position [%.1f %.1f]',center2, centerVal2);
plot(px,py,'-r','DisplayName',str);
legendData(end+1) = plot(center2,centerVal2,'*r','DisplayName','Center point');

legend(legendData);

% Bandpass test
subplot(2,1,2);
grid on; hold on;
title('Bandpass test');
xlabel('Position');
ylabel('Value');

legendData = [];

% Data
str = sprintf('Data (N = %i. Mean = %.1f. Std = %.1f)',N, dataMean, dataStd);
legendData(end+1) = plot(ids,dataFindBand2(1,:),'.k','DisplayName',str);

% Data band
str = sprintf('Data band (N = %i)',size(dataBand1,2));
bandIds = idsInterval(1,1):1:idsInterval(1,2);
legendData(end+1) = plot(bandIds,dataBand1(1,:),'.b','DisplayName',str);

% Bandpass
px = [idsInterval(1,1) idsInterval(1,1)]';
py = [0 255]';
plot(px,py,'-b','DisplayName',str);

px = [idsInterval(1,2) idsInterval(1,2)]';
py = [0 255]';
str = sprintf('Bandpass [%i %i]',idsInterval(1,1), idsInterval(1,2));
legendData(end+1) = plot(px,py,'-b','DisplayName',str);

legend(legendData);
