%#######################################################################
%#                                                                     #
%#                       EERI 474 - Tile Data Function                 #
%#                         by J. Koekemoer 26035170                    #
%#                                                                     #
%#######################################################################

% This function reads the tile file, and stores all useful information
% and data in a format usable by the main code and other sub-functions.
% IN: the file path and name together
% OUT: the dem data, metadata, and reference matrix

function [tileData, tileInfo, refMat, refMatg] = getTileStuff(tileName)

%tileName = '9129CATD.ddf';

% Determine file extension
lowerTile = lower(tileName);
tileExtension = extractAfter(lowerTile,'.');

% Sort file formats
if (strcmp(tileExtension,'tif') || strcmp(tileExtension,'tiff')) %GeoTiff files
    
    [tileData, refMat] = geotiffread(tileName); % get tile data and reference matix
    tileInfo = geotiffinfo(tileName);           % get tile metadata
    tileData = double(tileData);                % Convert data to doubles
    % Geographical objects
    refMatg = georefcells(refMat.LatitudeLimits,refMat.LongitudeLimits,refMat.RasterSize);

elseif strcmp(tileExtension,'ddf') % SDTS files
    [tileData, refMatg] = sdtsdemread(tileName); % get tile data and reference matix
    tileInfo = sdtsinfo(tileName);              % get tile metadata
    tileData = double(tileData);                % Convert data to doubles
    
else
    errordlg('File not currently supported','File Error');
end

% Map objects
% S = maprefcells(s.XIntrinsicLimits,s.YIntrinsicLimits,s.RasterSize); 


end