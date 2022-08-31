function undistImg = UndistortImageBouguet(img,KK,kc,varargin)
% uses Bouguet's cam calib toolbox
%
% Undistort call "shortcut" by Pedro Buschinelli, 2016
% [undistImg] = UndistortImageBouguet(img,KK,kc,varargin)
% Option by PVB
%%Input option processing and set up

img = imread(img);

op.RectifiedMissingValue = 255;

for ii=1:2:length(varargin)
    param=varargin{ii};
    val=varargin{ii+1};
    if strcmpi(param,'RectifiedMissingValue')
        op.RectifiedMissingValue = val;
    else
        error(['Option ''' param ''' not recognized']);
    end
end

[fc,cc,alphac] = GetCameraParametersFromIntrinsicMatrix(KK);

is8bpp = isa(img,'uint8');

if is8bpp
    img = double(img);
end

%Use altered rect that includes RectifiedMissingValue option
%toolbox_calib PVB (PNG+Auto corners)

colors = size(img,3);

if colors > 1
    % Undistort RGB images or n channels.
    undistImg = img;
    for ii=1:1:size(img,3)
        undistImg(:,:,ii) = rect(img(:,:,ii),eye(3),fc,cc,kc,alphac,KK,'RectifiedMissingValue',op.RectifiedMissingValue);
    end
else
    undistImg = rect(img,eye(3),fc,cc,kc,alphac,KK,'RectifiedMissingValue',op.RectifiedMissingValue);
end

if is8bpp
    undistImg = uint8(undistImg);
end