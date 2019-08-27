%#######################################################################
%#                                                                     #
%#                       EERI 474 - Tile Data Function                 #
%#                         by J. Koekemoer 26035170                    #
%#                                                                     #
%#######################################################################

% This function reads the tile file, and stores all useful information
% and data in a format usable by the main code and other sub-functions.
% IN: the file path and name together
% OUT: the dem data, metadata, reference matrix, and coordinate ranges

function [tileData, e, refMat, lat_range, long_range] = getTileStuff(tileName)

%tileName = '9129CATD.ddf';

% Determine file extension
lowerTile = lower(tileName);
tileExtension = extractAfter(lowerTile,'.');
tileNameOnly = extractBefore(tileName,'.');

% Sort file formats
if (strcmp(tileExtension,'tif') || strcmp(tileExtension,'tiff')) %GeoTiff files
    
    [tileData, refMatp] = geotiffread(tileName); % get tile data and reference matix
    tileInfo = geotiffinfo(tileName);           % get tile metadata
    tileData = double(tileData);                % Convert data to doubles
    % Geographical objects
    refMat = georefcells(refMatp.LatitudeLimits,refMatp.LongitudeLimits,refMatp.RasterSize);
    
    [lat_range, long_range] = dispDEMInfo(refMat);
    
    e = referenceEllipsoid(tileInfo.Ellipsoid);
    
elseif strcmp(tileExtension,'ddf') % SDTS files
    [tileData, refMat] = sdtsdemread(tileName); % get tile data and reference matix
    tileInfo = sdtsinfo(tileName);              % get tile metadata
    tileData = double(tileData);                % Convert data to doubles
    
    [lat_range, long_range] = dispDEMInfo(refMat);
    
    
elseif strcmp(tileExtension,'dem') % GTOPO30 files
    [tileData,refvec] = gtopo30(tileNameOnly); % Include lat and long lims in future
    rasterSize = size(tileData);
    refMat = refvecToGeoRasterReference(refvec,rasterSize);
    [lat_range, long_range] = dispDEMInfo(refMat);
    
    % Calculate the reference ellipsoid
    UTM = utmzone(lat_range,long_range);
    [ellip,ellipName] = utmgeoid(UTM);
    e = referenceEllipsoid(ellipName);
    
else
    errordlg('File not currently supported','File Error');
end

% Map objects
% S = maprefcells(s.XIntrinsicLimits,s.YIntrinsicLimits,s.RasterSize); 


end